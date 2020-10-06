import 'package:flutter_starter_template/layers/domain/entities/photo/image.dart';
import 'package:flutter_starter_template/utils/sealed_classes.dart';

abstract class IImageListStore {
  List<Image> get images;

  LoadingStatus get status;

  Future<void> loadImages();
}
