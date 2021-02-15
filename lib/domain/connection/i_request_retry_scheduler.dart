abstract class IRequestRetryScheduler {
  /// Schedules a retry on the moment when a connection is restored and
  /// returns [Future] which completes when retry is done.
  Future<T> scheduleRequestRetry<T>(Future<T> Function() retryRequest);
}
