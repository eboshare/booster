import 'package:dartz/dartz.dart';

import 'package:flutter_booster_kit/domain/gallery/gallery.dart';

abstract class IImageRepository {
  Future<Either<GalleryFailure, List<ImageEntity>>> getImages();
}
