import 'package:flutter_booster_kit/domain/image_list/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/utils/sealed_classes/loading_status.dart';

abstract class IImageListStore {
  List<ImageEntity> get images;

  LoadingStatus get status;

  Future<void> loadImages();
}
