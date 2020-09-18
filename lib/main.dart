import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_template/injection/injection.dart';

import 'package:flutter_starter_template/presentation/feature/counter/counter_page.dart';
import 'package:flutter_starter_template/presentation/navigation/router.gr.dart';

void main() {
  configureDependencies();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Starter Template',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: ExtendedNavigator.builder(
        router: Router(),
      ),
    );
  }
}
