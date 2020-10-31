import 'package:flutter/material.dart' hide Router;
import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_booster_kit/layers/presentation/design_system/design_system.dart';
import 'package:flutter_booster_kit/layers/presentation/design_system/design_system_data.dart';
import 'package:flutter_booster_kit/layers/presentation/navigation/router.gr.dart';
import 'package:flutter_booster_kit/generated/l10n.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DesignSystem(
      data: DesignSystemData.main(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Starter Template', // can't use S.of(context)
            theme: ThemeData(
              primarySwatch: DesignSystem.of(context).colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            builder: ExtendedNavigator.builder<Router>(
              router: Router(),
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
}
