import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_booster_kit/config/injection/injection.dart';
import 'package:flutter_booster_kit/presentation/app_widget.dart';

Future<void> main() async {
  configureDependencies(Environment.prod);
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  runApp(App());
}
