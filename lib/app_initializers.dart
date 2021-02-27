import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:booster/config/injection.dart';
import 'package:booster/presentation/app_widget.dart';
import 'package:booster/utils/sealed_classes/environment.dart';
import 'package:booster/domain/core/i_error_report_repository.dart';

Future<void> _initDependencies() async {
  HydratedBloc.storage = await getIt.getAsync<Storage>();
}

Future<Widget> initAppForTesting({
  Widget page,
  Environment environment = const Environment.test(),
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment);
  await _initDependencies();

  if (page != null) {
    return App.fromDirectPage(page: page);
  }
  return App.fromRoot();
}

Future<void> initAndRunApp(Environment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment);
  final errorReportRepository = getIt<IErrorReportRepository>();
  await errorReportRepository.init(
    runApp: () async {
      await _initDependencies();
      runApp(App.fromRoot());
    },
  );
}
