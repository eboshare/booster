import 'package:flutter/material.dart' hide Router;
import 'package:auto_route/auto_route.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system.dart';
import 'package:flutter_booster_kit/presentation/design_system/design_system_data.dart';
import 'package:flutter_booster_kit/presentation/navigation/router.gr.dart';
import 'package:flutter_booster_kit/configuration/localization/generated/l10n.dart';

/// Builds root widget and is required for testing.
///
/// Only one parameter either [page] or [builder] shouldn't be null.
Widget _initializeApp({
  Widget page,
  TransitionBuilder builder,
}) {
  assert(!(page != null && builder != null));
  assert(() {
    if (page == null) {
      return builder != null;
    } else if (builder == null) {
      return page != null;
    } else {
      return false;
    }
  }());

  return DesignSystem(
    data: DesignSystemData.main(),
    // Builder is used to access [DesignSystem.of(context)].
    child: Builder(
      builder: (context) {
        return MaterialApp(
          // Required due to the inability to use [S.of(context)]
          title: 'Flutter Starter Template',
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

Widget initializeAppWithPage({@required Widget page}) => _initializeApp(page: page);

Widget initializeAppWithBuilder({@required TransitionBuilder builder}) => _initializeApp(builder: builder);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return initializeAppWithBuilder(
      builder: ExtendedNavigator.builder<Router>(
        router: Router(),
      ),
    );
  }
}
