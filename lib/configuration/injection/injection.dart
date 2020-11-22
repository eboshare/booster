import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'package:flutter_booster_kit/configuration/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies(String environment) => $initGetIt(getIt, environment: environment);

@module
abstract class RegisterModule {
  @singleton
  Dio get dio {
    return Dio()
      ..interceptors.add(
        PrettyDioLogger(logPrint: logger.i),
      );
  }
}
