#!/usr/bin/env bash

# --- begin runfiles.bash initialization v3 ---
# Copy-pasted from the Bazel Bash runfiles library v3.
set -uo pipefail; set +e; f=bazel_tools/tools/bash/runfiles/runfiles.bash
# shellcheck disable=SC1090
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
source "$0.runfiles/$f" 2>/dev/null || \
source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
{ echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -e
# --- end runfiles.bash initialization v3 ---

set -euo pipefail

sed_i() {
    if sed --version >/dev/null 2>&1; then
        sed -i -- "$@"
    else
        sed -i "" "$@"
    fi
}

workspace_dir="${BUILD_WORKSPACE_DIRECTORY}"
create_api_tool="$(rlocation com_github_aaronsky_createapi/create-api)"
create_api_config="$(rlocation asc_swift/bazel/tools/create_api/.create-api.yml)"

appstore_api_version="@@APPSTORE_API_VERSION@@"
enterprise_api_version="@@ENTERPRISE_API_VERSION@@"

specs=(
    "$(rlocation com_apple_app_store_connect_api/app_store_connect_api_${appstore_api_version}_openapi.json)"
    "$(rlocation com_apple_enterprise_program_api/enterprise_program_api_${enterprise_api_version}_openapi.json)"
)

output_files_to_merge=(
    "Entities/ErrorLinks.swift"
    "Entities/ErrorResponse.swift"
    "Entities/ErrorSourceParameter.swift"
    "Entities/ErrorSourcePointer.swift"
    "Entities/PagedDocumentLinks.swift"
    "Extensions/AnyJSON.swift"
)
merge_to_path="$workspace_dir/Sources/AppStoreConnect/Entities"
output_files_to_delete=(
    "Extensions/StringCodingKey.swift"
)

for spec in "${specs[@]}"; do
    if [ -z "$spec" ]; then
        echo "path to spec is empty. cannot run create-api"
        exit 1
    fi

    spec_dir="$(dirname "$spec")"
    module_name="$(basename "$spec_dir")"
    output_dir="$spec_dir/Generated"

    "$create_api_tool" \
        generate "$spec" \
        --config "$create_api_config" \
        --config-option "module=$module_name" \
        --output "$output_dir" \
        --clean

    for file in "${output_files_to_merge[@]}"; do
        src="$output_dir/$file"
        dest="$merge_to_path/$(basename "$file")"

        sed_i "/import AppStoreConnect/d" "$src"

        if [ -f "$dest" ]; then
            cmp -s "$src" "$dest" || {
                echo "no!!!! $src $dest"
                exit 1
            }
            rm "$dest"
        fi

        mv "$src" "$dest"
    done

    for file in "${output_files_to_delete[@]}"; do
        rm "$output_dir/$file"
    done
done
