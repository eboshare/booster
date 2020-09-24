import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_starter_template/injection/injection.dart';
import 'package:flutter_starter_template/core/presentation/app_widget.dart';

void main() {
  configureDependencies();
  runApp(App());
}
