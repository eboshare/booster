import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/domain/gallery/gallery.dart';

part 'gallery_state_entity.freezed.dart';

@freezed
abstract class GalleryStateEntity with _$GalleryStateEntity {
  const factory GalleryStateEntity.initial() = _Initial;
  const factory GalleryStateEntity.loading() = _Loading;
  const factory GalleryStateEntity.error() = _Error;
  const factory GalleryStateEntity.success(List<ImageEntity> images) = _Success;
}
