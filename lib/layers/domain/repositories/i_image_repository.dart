import 'package:dartz/dartz.dart';

import 'package:flutter_starter_template/layers/domain/entities/photo/image.dart';
import 'package:flutter_starter_template/layers/domain/failures/image_repository/image_list_failure.dart';

abstract class IImageRepository {
  Future<Either<ImageListFailure, List<Image>>> getImagesList();
}
