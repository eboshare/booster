import 'package:flutter/material.dart' hide Router, ConnectionState;
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booster/domain/connection/connection_status.dart';
import 'package:booster/domain/connection/i_connection_bloc.dart';
import 'package:booster/config/injection.dart';
import 'package:booster/domain/connection/connection_state/connection_state.dart';

typedef OnStatusChanged = void Function(ConnectionStatus status);

class ConnectionListener extends StatefulWidget {
  final OnStatusChanged onStatusChanged;
  final Widget child;

  const ConnectionListener({
    Key key,
    @required this.onStatusChanged,
    @required this.child,
  }) : super(key: key);

  @override
  _ConnectionListenerState createState() => _ConnectionListenerState();
}

class _ConnectionListenerState extends State<ConnectionListener> {
  // ignore: close_sinks
  IConnectionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt();
  }

  @override
  void dispose() {
    super.dispose();
    getIt.dispose(_bloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IConnectionBloc, ConnectionState>(
      child: widget.child,
      cubit: _bloc,
      listenWhen: _listenWhen,
      listener: (context, state) {
        state.map(
          initial: (_) => null,
          connected: (_) => widget.onStatusChanged(ConnectionStatus.connected),
          disconnected: (_) => widget.onStatusChanged(ConnectionStatus.disconnected),
        );
      },
    );
  }

  bool _listenWhen(ConnectionState previousState, ConnectionState currentState) {
    bool mapTrue(_) => true;
    bool mapFalse() => false;

    return previousState.map(
      initial: (_) => currentState.maybeMap(
        // If previous state is initial and current is disconnected.
        disconnected: mapTrue,
        orElse: mapFalse,
      ),
      connected: (_) => currentState.maybeMap(
        // If previous state is connected and current is disconnected.
        disconnected: mapTrue,
        orElse: mapFalse,
      ),
      disconnected: (_) => currentState.maybeMap(
        // If previous state is disconnected and current is connected.
        connected: mapTrue,
        orElse: mapFalse,
      ),
    );
  }
}
