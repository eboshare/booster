import 'package:flutter/material.dart';

import 'package:flutter_booster_kit/injection/injection.dart';
import 'package:flutter_booster_kit/layers/presentation/app_widget.dart';

void main() {
  configureDependencies();
  runApp(App());
}
