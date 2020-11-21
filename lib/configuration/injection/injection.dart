import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies(String environment) => $initGetIt(getIt, environment: environment);

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio();
}
