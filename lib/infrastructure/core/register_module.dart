import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:booster/config/injection/injection.dart';

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
    return Dio()
      ..interceptors.add(
        PrettyDioLogger(logPrint: getIt<Logger>().i),
      );
  }
}
