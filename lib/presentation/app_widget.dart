import 'package:flutter/material.dart' hide Router;
import 'package:auto_route/auto_route.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system_data.dart';
import 'package:flutter_booster_kit/presentation/navigation/router.gr.dart';
import 'package:flutter_booster_kit/configuration/localization/generated/l10n.dart';

/// Builds root widget and is required for testing.
Widget initializeApp({
  Widget page,
  TransitionBuilder builder,
}) {
  return DesignSystem(
    data: DesignSystemData.main(),
    child: Builder(
      builder: (context) {
        return MaterialApp(
          title: 'Flutter Starter Template', // can't use S.of(context)
          home: page,
          builder: builder,
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
        );
      },
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return initializeApp(
      builder: ExtendedNavigator.builder<Router>(
        router: Router(),
      ),
    );
  }
}
