import 'package:flutter_booster_kit/domain/repository_interfaces/i_image_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_booster_kit/utils/sealed_classes/loading_status.dart';
import 'package:flutter_booster_kit/domain/entities/image/image.dart';
import 'package:flutter_booster_kit/domain/store_interfaces/i_image_list_store.dart';

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
