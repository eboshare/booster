import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:booster/domain/connection/i_connection_repository.dart';
import 'package:booster/domain/connection/connection_event/connection_event.dart';
import 'package:booster/domain/connection/connection_state/connection_state.dart';
import 'package:booster/domain/connection/connection_status.dart';
import 'package:booster/domain/connection/i_connection_bloc.dart';

ConnectionEvent _mapStatusToEvent(ConnectionStatus status) {
  switch (status) {
    case ConnectionStatus.connected:
      return const ConnectionEvent.connected();
    case ConnectionStatus.disconnected:
      return const ConnectionEvent.disconnected();
  }
  throw AssertionError();
}

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> implements IConnectionBloc {
  final StreamSubscription<ConnectionStatus> _connectionSubscription;
  final IConnectionRepository _connectionRepository;

  ConnectionBloc._(
    this._connectionSubscription,
    this._connectionRepository,
  ) : super(const ConnectionState.initial());

  factory ConnectionBloc(IConnectionRepository repository) {
    ConnectionBloc bloc;

    // ignore: cancel_subscriptions
    final subscription = repository.onConnectionStatusChanged.listen(
      (status) {
        bloc.add(_mapStatusToEvent(status));
      },
    );

    bloc = ConnectionBloc._(subscription, repository);
    return bloc;
  }

  @override
  Future<void> close() async {
    await _connectionSubscription.cancel();
    return super.close();
  }

  @override
  Stream<ConnectionState> mapEventToState(ConnectionEvent event) async* {
    yield* event.map(
      connected: _mapConnectedEvent,
      disconnected: _mapDisconnectedEvent,
      check: _mapCheckEvent,
    );
  }

  Stream<ConnectionState> _mapConnectedEvent(ConnectionConnectedEvent event) async* {
    yield const ConnectionState.connected();
  }

  Stream<ConnectionState> _mapDisconnectedEvent(ConnectionDisconnectedEvent event) async* {
    yield const ConnectionState.disconnected();
  }

  Stream<ConnectionState> _mapCheckEvent(ConnectionCheckEvent event) async* {
    final status = await _connectionRepository.getConnectionStatus();
    add(_mapStatusToEvent(status));
  }
}
