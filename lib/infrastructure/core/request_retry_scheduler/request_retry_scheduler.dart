import 'dart:async';

import 'package:injectable/injectable.dart';

import 'package:booster/infrastructure/core/connection_repository/i_connection_repository.dart';
import 'package:booster/infrastructure/core/request_retry_scheduler/i_request_retry_scheduler.dart';

@LazySingleton(as: IRequestRetryScheduler)
class DataConnectionRequestRetryScheduler implements IRequestRetryScheduler {
  final IConnectionRepository _connectionRepository;

  const DataConnectionRequestRetryScheduler(this._connectionRepository);

  @override
  Future<T> scheduleRequestRetry<T>(Future<T> Function() retryRequest) {
    StreamSubscription subscription;
    final responseCompleter = Completer<T>();

    subscription = _connectionRepository.onConnectionStatusChanged.listen((status) {
      if (status == ConnectionStatus.connected) {
        responseCompleter.complete(retryRequest());
        subscription.cancel();
      }
    });

    return responseCompleter.future;
  }
}
