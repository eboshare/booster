import 'package:flutter_starter_template/layers/domain/entities/image/image.dart';
import 'package:flutter_starter_template/utils/sealed_classes.dart';

abstract class IImageListStore {
  List<ImageEntity> get images;

  LoadingStatus get status;

  Future<void> loadImages();
}
