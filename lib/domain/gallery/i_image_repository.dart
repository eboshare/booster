import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

import 'package:booster/domain/gallery/gallery_failure/gallery_failure.dart';
import 'package:booster/domain/gallery/image_entity/image_entity.dart';

abstract class IImageRepository {
  Future<Either<GalleryFailure, KtList<ImageEntity>>> getImages();
}
