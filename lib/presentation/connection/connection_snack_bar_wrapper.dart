import 'package:flutter/material.dart' hide Router, ConnectionState;
import 'package:auto_route/auto_route.dart';

import 'package:booster/domain/connection/connection_status.dart';
import 'package:booster/config/localization/generated/l10n.dart';
import 'package:booster/presentation/connection/connection_listener.dart';
import 'package:booster/presentation/core/design_system/design_system.dart';

typedef ShowSnackBar = Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> Function({
  @required SnackBar Function(BuildContext) builder,
});

class ConnectionStackBarWrapper extends StatefulWidget {
  final ShowSnackBar showSnackBar;
  final Widget child;

  const ConnectionStackBarWrapper({
    Key key,
    @required this.showSnackBar,
    @required this.child,
  }) : super(key: key);

  @override
  _ConnectionStackBarWrapperState createState() => _ConnectionStackBarWrapperState();
}

class _ConnectionStackBarWrapperState extends State<ConnectionStackBarWrapper> {
  ScaffoldFeatureController _controller;

  @override
  Widget build(BuildContext context) {
    return ConnectionListener(
      child: widget.child,
      onStatusChanged: (status) async {
        _controller = await widget.showSnackBar(
          builder: (context) {
            final design = DesignSystem.of(context);

            final content = Text(
              _mapConnectionStatusToText(context, status),
            );

            switch (status) {
              case ConnectionStatus.connected:
                _controller.close();
                return SnackBar(
                  content: content,
                  backgroundColor: design.colors.green,
                );
              case ConnectionStatus.disconnected:
                const infiniteDuration = Duration(days: 365);
                return SnackBar(
                  content: content,
                  duration: infiniteDuration,
                );
            }
            throw AssertionError();
          },
        );
      },
    );
  }

  String _mapConnectionStatusToText(BuildContext context, ConnectionStatus status) {
    final str = S.of(context);
    switch (status) {
      case ConnectionStatus.connected:
        return str.connectionRestored;
      case ConnectionStatus.disconnected:
        return str.connectionLost;
    }
    throw AssertionError();
  }
}
