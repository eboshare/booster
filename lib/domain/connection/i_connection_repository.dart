import 'package:booster/domain/connection/connection_status.dart';

abstract class IConnectionRepository {
  Future<ConnectionStatus> getConnectionStatus();

  Stream<ConnectionStatus> get onConnectionStatusChanged;
}
