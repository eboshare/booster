import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:booster/config/injection/get_it_extended.dart';
import 'package:booster/domain/connection/i_request_retry_scheduler.dart';
import 'package:booster/infrastructure/connection/request_retry_interceptor.dart';
import 'package:booster/application/connection/connection_bloc.dart';
import 'package:booster/application/gallery/gallery_bloc.dart';
import 'package:booster/domain/connection/i_connection_bloc.dart';
import 'package:booster/domain/connection/i_connection_repository.dart';
import 'package:booster/domain/gallery/i_gallery_bloc.dart';
import 'package:booster/domain/gallery/i_image_repository.dart';
import 'package:booster/infrastructure/connection/connection_repository/data_connection_repository.dart';
import 'package:booster/infrastructure/connection/request_retry_scheduler/request_retry_scheduler.dart';
import 'package:booster/infrastructure/gallery/image_repository/picsum_repository.dart';

final getIt = GetItExtended(GetIt.instance);

void configureDependencies() {
  getIt.registerLazySingleton<Logger>(
    () => Logger(
      printer: SimplePrinter(
        colors: false,
      ),
    ),
  );
  getIt.registerLazySingleton<Dio>(
    () {
      final dio = Dio();
      dio.interceptors.addAll([
        PrettyDioLogger(logPrint: getIt<Logger>().i),
        RequestRetryInterceptor(getIt<IRequestRetryScheduler>(), dio),
      ]);
      return dio;
    },
  );
  getIt.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );

  getIt.registerLazySingleton<IConnectionRepository>(
    () => DataConnectionRepository(getIt<DataConnectionChecker>()),
  );
  getIt.registerLazySingleton<IRequestRetryScheduler>(
    () => DataConnectionRequestRetryScheduler(getIt<IConnectionRepository>()),
  );
  getIt.registerLazySingleton<PicsumClient>(
    () => PicsumClient(getIt<Dio>()),
  );
  getIt.registerLazySingleton<IConnectionBloc>(
    () => ConnectionBloc(getIt<IConnectionRepository>()),
  );
  getIt.registerLazySingleton<IGalleryBloc>(
    () => GalleryBloc(getIt<IImageRepository>()),
  );
  getIt.registerLazySingleton<IImageRepository>(
    () => PicsumRepository(getIt<PicsumClient>()),
  );
}
