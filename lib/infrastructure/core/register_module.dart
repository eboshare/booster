import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:booster/infrastructure/core/interceptors/request_retry_interceptor.dart';
import 'package:booster/config/injection/injection.dart';
import 'package:booster/infrastructure/core/request_retry_scheduler/i_request_retry_scheduler.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Logger get logger {
    return Logger(
      printer: SimplePrinter(
        colors: false,
      ),
    );
  }

  @lazySingleton
  Dio get dio {
    final dio = Dio();
    dio.interceptors.addAll([
      PrettyDioLogger(logPrint: getIt<Logger>().i),
      RequestRetryInterceptor(getIt<IRequestRetryScheduler>(), dio),
    ]);
    return dio;
  }

  @lazySingleton
  DataConnectionChecker get dataConnectionChecker => DataConnectionChecker();
}
