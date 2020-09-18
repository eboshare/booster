import 'package:flutter/material.dart';
import 'package:flutter_starter_template/injection/injection.dart';

import 'package:flutter_starter_template/presentation/feature/counter/counter_page.dart';

void main() {
  configureDependencies();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterPage(),
    );
  }
}
