import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
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
import 'package:booster/infrastructure/connection/connection_repository/fake_connection_repository.dart';
import 'package:booster/infrastructure/core/storages/fake_storage.dart';
import 'package:booster/infrastructure/gallery/image_repository/mock_image_repository.dart';
import 'package:booster/utils/environment.dart';

final getIt = GetItExtended(GetIt.instance);

Future<void> configureDependencies(Environment environment) async {
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
      switch (environment) {
        case Environment.development:
        case Environment.production:
          return DataConnectionRepository(getIt<DataConnectionChecker>());
        case Environment.testing:
          return FakeConnectionRepository();
      }
      throw AssertionError();
    },
  );
  getIt.registerLazySingleton<IImageRepository>(
    () {
      switch (environment) {
        case Environment.production:
        case Environment.development:
          return PicsumRepository(getIt<PicsumClient>());
        case Environment.testing:
          return MockImageRepository();
      }
      throw AssertionError();
    },
  );
  getIt.registerLazySingletonAsync<Storage>(() async {
    switch (environment) {
      case Environment.production:
      case Environment.development:
        return await HydratedStorage.build();
      case Environment.testing:
        return FakeStorage();
    }
    throw AssertionError();
  });

  await getIt.allReady();
}
