import 'package:dartz/dartz.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';

import 'package:booster/domain/gallery/gallery_failure/gallery_failure.dart';
import 'package:booster/domain/gallery/i_image_repository.dart';
import 'package:booster/domain/gallery/image_entity/image_entity.dart';
import 'package:booster/infrastructure/gallery/image_network_dto/image_network_dto.dart';

part 'picsum_repository.g.dart';

@RestApi(baseUrl: 'https://picsum.photos/')
abstract class PicsumClient {
  factory PicsumClient(Dio dio) = _PicsumClient;

  @GET('/v2/list')
  Future<List<ImageNetworkDto>> getImagesList();
}

class PicsumRepository implements IImageRepository {
  final PicsumClient _client;

  const PicsumRepository(this._client);

  @override
  Future<Either<GalleryFailure, BuiltList<ImageEntity>>> getImages() async {
    try {
      final imageDtos = await _client.getImagesList();
      final imageEntities = imageDtos.map((dto) => dto.toEntity()).toBuiltList();
      return Right(imageEntities);
    } on DioError {
      return Left(GalleryFailure.unknown());
    }
  }
}
