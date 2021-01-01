import 'package:dartz/dartz.dart';

import 'package:booster/domain/gallery/gallery.dart';

abstract class IImageRepository {
  Future<Either<GalleryFailure, List<ImageEntity>>> getImages();
}
