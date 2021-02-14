enum ConnectionStatus {
  connected,
  disconnected,
}

abstract class IConnectionRepository {
  Future<ConnectionStatus> getConnectionStatus();

  Stream<ConnectionStatus> get onConnectionStatusChanged;
}
