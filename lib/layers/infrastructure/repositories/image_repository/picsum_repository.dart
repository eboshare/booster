import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:flutter_starter_template/layers/domain/entities/photo/image.dart';
import 'package:flutter_starter_template/layers/domain/failures/image_repository/image_list_failure.dart';
import 'package:flutter_starter_template/layers/domain/repositories/i_image_repository.dart';

part 'picsum_repository.g.dart';

@singleton  // this annotation is just for convenience
@RestApi(baseUrl: 'https://picsum.photos/')
abstract class PicsumClient {
  @factoryMethod
  factory PicsumClient(Dio dio) = _PicsumClient;

  @GET('/v2/list')
  Future<List<Image>> imagesList();
}

@Singleton(as: IImageRepository)
class PicsumRepository implements IImageRepository {
  final PicsumClient client;

  const PicsumRepository(this.client);

  @override
  Future<Either<ImageListFailure, List<Image>>> getImagesList() async {
    try {
      return Right(await client.imagesList());
    } on DioError {
      return Left(ImageListFailure.unknown());
    }
  }
}
