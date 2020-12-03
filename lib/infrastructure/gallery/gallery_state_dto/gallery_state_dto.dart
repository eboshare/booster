import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/application/gallery/gallery_bloc.dart';
import 'package:flutter_booster_kit/domain/gallery/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/infrastructure/gallery/image_local_dto/image_local_dto.dart';

part 'gallery_state_dto.freezed.dart';
part 'gallery_state_dto.g.dart';

@Freezed(unionKey: 'type')
abstract class GalleryStateDto implements _$GalleryStateDto {
  const GalleryStateDto._();

  const factory GalleryStateDto.initial() = _InitialDto;
  const factory GalleryStateDto.loading() = _LoadingDto;
  const factory GalleryStateDto.error() = _ErrorDto;
  const factory GalleryStateDto.success(
    @JsonKey(name: 'images') @ImagesConverter() List<ImageEntity> images,
  ) = _SuccessDto;

  factory GalleryStateDto.fromJson(Map<String, dynamic> json) => _$GalleryStateDtoFromJson(json);

  factory GalleryStateDto.fromStateEntity(GalleryState stateEntity) {
    return stateEntity.map(
      initial: (_) => const GalleryStateDto.initial(),
      loading: (_) => const GalleryStateDto.loading(),
      error: (_) => const GalleryStateDto.error(),
      success: (state) => GalleryStateDto.success(state.images),
    );
  }

  GalleryState toStateEntity() {
    return map(
      initial: (_) => const GalleryState.initial(),
      loading: (_) => const GalleryState.loading(),
      error: (_) => const GalleryState.error(),
      success: (state) => GalleryState.success(state.images),
    );
  }
}

class ImagesConverter implements JsonConverter<List<ImageEntity>, List<dynamic>> {
  const ImagesConverter();

  @override
  List<ImageEntity> fromJson(List<dynamic> imageJsonList) {
    return imageJsonList
        .map(
          (imageJson) => ImageLocalDto.fromJson(imageJson).toEntity(),
        )
        .toList();
  }

  @override
  List<dynamic> toJson(List<ImageEntity> imageEntityList) {
    return imageEntityList
        .map(
          (imageEntity) => ImageLocalDto.fromEntity(imageEntity).toJson(),
        )
        .toList();
  }
}
