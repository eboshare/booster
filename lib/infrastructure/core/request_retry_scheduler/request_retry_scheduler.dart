import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';

import 'package:booster/infrastructure/core/request_retry_scheduler/i_request_retry_scheduler.dart';

@LazySingleton(as: IRequestRetryScheduler)
class DataConnectionRequestRetryScheduler implements IRequestRetryScheduler {
  final DataConnectionChecker _connectionChecker;

  const DataConnectionRequestRetryScheduler(this._connectionChecker);

  @override
  Future<T> scheduleRequestRetry<T>(Future<T> Function() retryRequest) {
    StreamSubscription subscription;
    final responseCompleter = Completer<T>();

    subscription = _connectionChecker.onStatusChange.listen((status) {
      if (status == DataConnectionStatus.connected) {
        responseCompleter.complete(retryRequest());
        subscription.cancel();
      }
    });

    return responseCompleter.future;
  }
}
