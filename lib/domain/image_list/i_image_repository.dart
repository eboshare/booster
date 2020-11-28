import 'package:dartz/dartz.dart';

import 'package:flutter_booster_kit/domain/image_list/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/domain/image_list/image_list_failure/image_list_failure.dart';

abstract class IImageRepository {
  Future<Either<ImageListFailure, List<ImageEntity>>> getImageList();
}
