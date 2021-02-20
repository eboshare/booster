import 'package:dartz/dartz.dart';

import 'package:built_collection/built_collection.dart';
import 'package:booster/domain/gallery/gallery_failure/gallery_failure.dart';
import 'package:booster/domain/gallery/image_entity/image_entity.dart';

abstract class IImageRepository {
  Future<Either<GalleryFailure, BuiltList<ImageEntity>>> getImages();
}
