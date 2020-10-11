import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:flutter_booster_kit/layers/domain/entities/image/image.dart';
import 'package:flutter_booster_kit/layers/domain/failures/image_repository/image_list_failure.dart';
import 'package:flutter_booster_kit/layers/domain/repositories/i_image_repository.dart';

part 'picsum_repository.g.dart';

@singleton  // this annotation is just for convenience
@RestApi(baseUrl: 'https://picsum.photos/')
abstract class PicsumClient {
  @factoryMethod
  factory PicsumClient(Dio dio) = _PicsumClient;

  @GET('/v2/list')
  Future<List<ImageEntity>> getImagesList();
}

@Singleton(as: IImageRepository)
class PicsumRepository implements IImageRepository {
  final PicsumClient client;

  const PicsumRepository(this.client);

  @override
  Future<Either<ImageListFailure, List<ImageEntity>>> getImagesList() async {
    try {
      return Right(await client.getImagesList());
    } on DioError {
      return Left(ImageListFailure.unknown());
    }
  }
}
