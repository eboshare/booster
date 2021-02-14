abstract class IRequestRetryScheduler {
  /// Schedules a retry and returns [Future] which completes when retry is done.
  Future<T> scheduleRequestRetry<T>(Future<T> Function() retryRequest);
}
