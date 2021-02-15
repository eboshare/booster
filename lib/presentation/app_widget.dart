import 'package:flutter/material.dart' hide Router, ConnectionState;
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:booster/domain/connection/i_connection_bloc.dart';
import 'package:booster/config/injection/injection.dart';
import 'package:booster/config/localization/generated/l10n.dart';
import 'package:booster/presentation/core/navigation/router.gr.dart';
import 'package:booster/presentation/core/design_system/design_system.dart';
import 'package:booster/presentation/core/design_system/design_system_data/design_system_data.dart';
import 'package:booster/domain/connection/connection_state/connection_state.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey;
  final Widget page;

  App._({
    Key key,
    this.page,
  })  : _navigatorKey = GlobalKey<NavigatorState>(),
        super(key: key);

  factory App.withRouter({
    Key key,
  }) {
    return App._(key: key);
  }

  /// Required for testing.
  factory App.withSinglePage({
    Key key,
    @required Widget page,
  }) {
    return App._(key: key, page: page);
  }

  @override
  Widget build(BuildContext context) {
    return DesignSystem(
      data: DesignSystemData.main(),
      child: Builder(
        // Builder is used to access [DesignSystem.of(context)].
        builder: (context) {
          return MaterialApp(
            onGenerateTitle: (context) => S.of(context).appTitle,
            theme: ThemeData(
              primarySwatch: DesignSystem.of(context).colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: ExtendedNavigator.builder<Router>(
              navigatorKey: _navigatorKey,
              router: Router(),
              builder: (context, child) {
                return BlocListener<IConnectionBloc, ConnectionState>(
                  cubit: getIt<IConnectionBloc>(),
                  child: page ?? child,
                  listenWhen: _listenWhen,
                  listener: (context, state) {
                    final str = S.of(context);
                    state.map(
                      initial: (_) => null,
                      connected: (_) => _showDialog(
                        _navigatorKey.currentContext,
                        str.connectionRestored,
                      ),
                      disconnected: (_) => _showDialog(
                        _navigatorKey.currentContext,
                        str.connectionLost,
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(text),
      ),
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
