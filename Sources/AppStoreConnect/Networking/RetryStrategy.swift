import Foundation

package func retry<T>(with strategy: some RetryStrategy, _ block: @Sendable () async throws -> T) async rethrows -> T {
    var iteration = 0

    while true {
        do {
            return try await block()
        } catch {
            guard try await strategy.waitAndContinue(for: error, iteration: iteration) else { throw error }
        }

        iteration += 1
    }
}

/// Execute a waiting algorithm and inform the client whether to continue retrying a request.
///
/// This enum is intended to be provided as input to the methods on ``AppStoreConnect``.
public protocol RetryStrategy: Sendable {
    /// Respond to an error from ``AppStoreConnectClient``, typically by waiting for a period of time.
    /// - Parameter error: The received error.
    /// - Returns: A boolean indicating whether or not to continue retrying.
    func waitAndContinue(for error: any Error, iteration: Int) async throws -> Bool
}

/// The strategy that never retries
public struct NeverRetryStrategy: RetryStrategy {
    public func waitAndContinue(for error: any Error, iteration: Int) async throws -> Bool { false }
}

extension RetryStrategy where Self == NeverRetryStrategy {
    public static var never: Self { Self() }
}

/// The strategy that retries on a fixed interval, in seconds, until a limit is reached.
public struct FixedIntervalRetryStrategy<Clock: _Concurrency.Clock, Duration: Swift.DurationProtocol>: RetryStrategy
where Duration == Clock.Duration {
    var interval: Duration
    var limit: Int
    var clock: Clock

    public init(interval: Duration, limit: Int, clock: Clock) {
        self.interval = interval
        self.limit = limit
        self.clock = clock
    }

    public func waitAndContinue(for error: any Error, iteration: Int) async throws -> Bool {
        guard iteration < limit else { return false }

        try await Task.sleep(for: interval, clock: clock)

        return true
    }
}

extension RetryStrategy {
    /// The strategy that retries on a fixed interval, in seconds, until a limit is reached.
    public static func fixedInterval<Clock: _Concurrency.Clock, Duration: Swift.DurationProtocol>(
        _ interval: Duration,
        limit: Int,
        clock: Clock
    ) -> FixedIntervalRetryStrategy<Clock, Duration>
    where Self == FixedIntervalRetryStrategy<Clock, Duration> {
        Self(interval: interval, limit: limit, clock: clock)
    }
}

extension RetryStrategy where Self == FixedIntervalRetryStrategy<ContinuousClock, ContinuousClock.Duration> {
    /// The strategy that retries on a fixed interval, in seconds, until a limit is reached.
    public static func fixedInterval(
        _ interval: ContinuousClock.Duration,
        limit: Int,
        clock: ContinuousClock = ContinuousClock()
    ) -> Self {
        Self(interval: interval, limit: limit, clock: clock)
    }
}

/// The strategy that retries using an exponential backoff approach until a limit is reached.
public struct ExponentialBackoffRetryStrategy<Clock: _Concurrency.Clock, Duration: Swift.DurationProtocol>:
    RetryStrategy
where Duration == Clock.Duration {
    var interval: Duration
    var limit: Int
    var exponentialBase: Int
    var clock: Clock

    public init(interval: Duration, limit: Int, exponentialBase: Int, clock: Clock) {
        self.interval = interval
        self.limit = limit
        self.exponentialBase = exponentialBase
        self.clock = clock
    }

    public func waitAndContinue(for error: any Error, iteration: Int) async throws -> Bool {
        guard iteration < limit else { return false }

        let exp = pow(Double(exponentialBase), Double(iteration))
        let duration = interval * Int(exp)

        try await Task.sleep(for: duration, clock: clock)

        return true
    }
}

extension RetryStrategy {
    /// The strategy that retries using an exponential backoff approach until a limit is reached.
    public static func exponentialBackoff<Clock: _Concurrency.Clock, Duration: Swift.DurationProtocol>(
        interval: Duration,
        limit: Int,
        exponentialBase: Int,
        clock: Clock
    ) -> ExponentialBackoffRetryStrategy<Clock, Duration>
    where Self == ExponentialBackoffRetryStrategy<Clock, Duration> {
        Self(
            interval: interval,
            limit: limit,
            exponentialBase: exponentialBase,
            clock: clock
        )
    }
}

extension RetryStrategy where Self == ExponentialBackoffRetryStrategy<ContinuousClock, ContinuousClock.Duration> {
    /// The strategy that retries using an exponential backoff approach until a limit is reached.
    public static func exponentialBackoff(
        interval: ContinuousClock.Duration,
        limit: Int,
        exponentialBase: Int,
        clock: ContinuousClock = ContinuousClock()
    ) -> Self {
        Self(
            interval: interval,
            limit: limit,
            exponentialBase: exponentialBase,
            clock: clock
        )
    }
}
