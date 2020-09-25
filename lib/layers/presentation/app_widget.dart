import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_starter_template/layers/presentation/design_system/design_system.dart';
import 'package:flutter_starter_template/layers/presentation/design_system/design_system_data.dart';
import 'package:flutter_starter_template/layers/presentation/navigation/router.gr.dart';
import 'package:flutter_starter_template/generated/l10n.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DesignSystem(
      data: DesignSystemData.main(),
      child: _Setup(),
    );
  }
}

class _Setup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Starter Template', // can't use S.of(context)
      theme: ThemeData(
        primarySwatch: DesignSystem.of(context).color.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: ExtendedNavigator.builder(
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
  }
}
