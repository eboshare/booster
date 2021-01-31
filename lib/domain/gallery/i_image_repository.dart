import 'package:dartz/dartz.dart';

import 'package:booster/domain/gallery/gallery.dart';
import 'package:kt_dart/collection.dart';

abstract class IImageRepository {
  Future<Either<GalleryFailure, KtList<ImageEntity>>> getImages();
}
