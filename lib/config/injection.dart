import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:booster/utils/config_reader/config/config.dart';
import 'package:booster/infrastructure/core/error_report_repository/fake_error_report_repository.dart';
import 'package:booster/utils/config_reader/reader.dart';
import 'package:booster/domain/core/i_error_report_repository.dart';
import 'package:booster/infrastructure/core/error_report_repository/sentry_error_report_repository.dart';
import 'package:booster/utils/get_it_extended.dart';
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
import 'package:booster/infrastructure/connection/connection_repository/fake_connection_repository.dart';
import 'package:booster/infrastructure/core/storages/fake_storage.dart';
import 'package:booster/infrastructure/gallery/image_repository/mock_image_repository.dart';
import 'package:booster/utils/sealed_classes/environment.dart';

final getIt = GetItExtended(GetIt.instance);

Future<void> configureDependencies(Environment env) async {
  getIt.registerSingleton<Config>(await loadConfig('config/app_config.json'));

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
  getIt.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );

  getIt.registerLazySingleton<IConnectionRepository>(
    () {
      IConnectionRepository whenDevOrProd() => DataConnectionRepository(getIt<DataConnectionChecker>());
      return env.when(
        dev: whenDevOrProd,
        prod: whenDevOrProd,
        test: () => FakeConnectionRepository(),
      );
    },
  );
  getIt.registerLazySingleton<IImageRepository>(
    () {
      IImageRepository whenDevOrProd() => PicsumRepository(getIt<PicsumClient>());
      return env.when(
        dev: whenDevOrProd,
        prod: whenDevOrProd,
        test: () => MockImageRepository(),
      );
    },
  );
  getIt.registerLazySingletonAsync<Storage>(() async {
    Future<Storage> whenDevOrProd() => HydratedStorage.build();
    return env.when(
      dev: whenDevOrProd,
      prod: whenDevOrProd,
      test: () => FakeStorage(),
    );
  });

  getIt.registerLazySingleton<IErrorReportRepository>(() {
    IErrorReportRepository whenDevOrProd() {
      return SentryErrorReportRepository(dsn: getIt<Config>().sentryDsn);
    }

    return env.when(
      dev: whenDevOrProd,
      prod: whenDevOrProd,
      test: () => FakeErrorReportRepository(),
    );
  });

  await getIt.allReady();
}
