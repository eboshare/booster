import 'package:flutter/material.dart';

import 'package:flutter_starter_template/injection/injection.dart';
import 'package:flutter_starter_template/layers/presentation/app_widget.dart';

void main() {
  configureDependencies();
  runApp(App());
}
