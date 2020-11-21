import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:flutter_booster_kit/domain/entities/image/image.dart';
import 'package:flutter_booster_kit/domain/failures/image_repository/image_list_failure.dart';
import 'package:flutter_booster_kit/domain/repositories/i_image_repository.dart';

part 'picsum_repository.g.dart';

@singleton // this annotation is just for convenience
@RestApi(baseUrl: 'https://picsum.photos/')
abstract class PicsumClient {
  @factoryMethod
  factory PicsumClient(Dio dio) = _PicsumClient;

  @GET('/v2/list')
  Future<List<ImageEntity>> getImagesList();
}

@Singleton(as: IImageRepository, env: [Environment.prod])
class PicsumRepository implements IImageRepository {
  final PicsumClient _client;

  const PicsumRepository(this._client);

  @override
  Future<Either<ImageListFailure, List<ImageEntity>>> getImagesList() async {
    try {
      return Right(await _client.getImagesList());
    } on DioError {
      return Left(ImageListFailure.unknown());
    }
  }
}
