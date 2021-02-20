import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:booster/config/injection/injection.dart';
import 'package:booster/presentation/app_widget.dart';
import 'package:booster/utils/environment/environment.dart';

Future<Widget> initializeApp({
  @required Environment environment,
  Widget page,
}) async {
  await configureDependencies(environment);
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await getIt.getAsync<Storage>();

  if (page != null) {
    return App.fromDirectPage(page: page);
  }
  return App.fromRoot();
}

Future<void> initializeAndRunApp(Environment environment) async {
  final widget = await initializeApp(environment: environment);
  runApp(widget);
}
