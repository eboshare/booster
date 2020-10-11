import 'package:dartz/dartz.dart';

import 'package:flutter_booster_kit/layers/domain/entities/image/image.dart';
import 'package:flutter_booster_kit/layers/domain/failures/image_repository/image_list_failure.dart';

abstract class IImageRepository {
  Future<Either<ImageListFailure, List<ImageEntity>>> getImagesList();
}
