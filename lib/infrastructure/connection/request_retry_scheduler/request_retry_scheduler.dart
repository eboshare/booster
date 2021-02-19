import 'dart:async';


import 'package:booster/domain/connection/connection_status.dart';
import 'package:booster/domain/connection/i_connection_repository.dart';
import 'package:booster/domain/connection/i_request_retry_scheduler.dart';

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
