import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_booster_kit/utils/sealed_classes.dart';
import 'package:flutter_booster_kit/layers/domain/entities/image/image.dart';
import 'package:flutter_booster_kit/layers/domain/stores/i_image_list_store.dart';
import 'package:flutter_booster_kit/layers/domain/repositories/i_image_repository.dart';

part 'image_list_store.g.dart';

@LazySingleton(as: IImageListStore)
class ImageListStore = ImageListStoreBase with _$ImageListStore;

abstract class ImageListStoreBase with Store implements IImageListStore {
  final IImageRepository _repository;

  ImageListStoreBase(this._repository);

  @observable
  List<ImageEntity> _images;

  @observable
  LoadingStatus _status;

  @override
  @computed
  List<ImageEntity> get images => _images;

  @override
  @computed
  LoadingStatus get status => _status;

  @override
  Future<void> loadImages() async {
    _status = LoadingStatus.loading();
    await _repository.getImagesList()
      ..fold(
        (_) {
          _status = LoadingStatus.error();
        },
        (images) {
          _images = images;
          _status = LoadingStatus.success();
        },
      );
  }
}
