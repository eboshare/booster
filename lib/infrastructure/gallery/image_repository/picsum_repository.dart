import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:booster/domain/gallery/gallery.dart';
import 'package:booster/infrastructure/gallery/gallery.dart';

part 'picsum_repository.g.dart';

@lazySingleton // This annotation is just for convenience.
@RestApi(baseUrl: 'https://picsum.photos/')
abstract class PicsumClient {
  @factoryMethod
  factory PicsumClient(Dio dio) = _PicsumClient;

  @GET('/v2/list')
  Future<List<ImageNetworkDto>> getImagesList();
}

@LazySingleton(as: IImageRepository, env: [Environment.prod])
class PicsumRepository implements IImageRepository {
  final PicsumClient _client;

  const PicsumRepository(this._client);

  @override
  Future<Either<GalleryFailure, List<ImageEntity>>> getImages() async {
    try {
      final imageDtos = await _client.getImagesList();
      final imageEntities = imageDtos.map((dto) => dto.toEntity()).toList();
      return Right(imageEntities);
    } on DioError {
      return Left(GalleryFailure.unknown());
    }
  }
}
