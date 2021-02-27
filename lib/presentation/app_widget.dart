import 'package:booster/config/injection.dart';
import 'package:booster/domain/core/i_error_report_repository.dart';
import 'package:flutter/material.dart' hide Router, ConnectionState;
import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:one_context/one_context.dart';

import 'package:booster/presentation/connection/connection_snack_bar_wrapper.dart';
import 'package:booster/config/localization/generated/l10n.dart';
import 'package:booster/presentation/core/navigation/router.gr.dart';
import 'package:booster/presentation/core/design_system/design_system.dart';
import 'package:booster/presentation/core/design_system/design_system_data/design_system_data.dart';

class App extends StatelessWidget {
  final Widget page;

  const App._({
    Key key,
    this.page,
  }) : super(key: key);

  factory App.fromRoot({
    Key key,
  }) {
    return App._(key: key);
  }

  /// Required for testing.
  factory App.fromDirectPage({
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
        // Builder is used to initialize context and access [DesignSystem.of(context)].
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
              router: Router(),
              observers: [
                getIt<IErrorReportRepository>().getNavigationObserver(),
              ],
              builder: (context, child) {
                final targetChild = page ?? child;
                return ConnectionStackBarWrapper(
                  showSnackBar: OneContext.instance.showSnackBar,
                  child: OneContext.instance.builder(context, targetChild),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
