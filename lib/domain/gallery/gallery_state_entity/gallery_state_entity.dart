import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import 'package:booster/domain/gallery/image_entity/image_entity.dart';

part 'gallery_state_entity.freezed.dart';

@freezed
abstract class GalleryStateEntity with _$GalleryStateEntity {
  const factory GalleryStateEntity.initial() = _Initial;
  const factory GalleryStateEntity.loading() = _Loading;
  const factory GalleryStateEntity.error() = _Error;
  const factory GalleryStateEntity.success(KtList<ImageEntity> images) = _Success;
}
