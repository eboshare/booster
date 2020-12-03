import 'package:dartz/dartz.dart';

import 'package:flutter_booster_kit/domain/gallery/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/domain/gallery/gallery_failure/gallery_failure.dart';

abstract class IImageRepository {
  Future<Either<GalleryFailure, List<ImageEntity>>> getImages();
}
