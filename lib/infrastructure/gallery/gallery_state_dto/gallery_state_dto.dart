import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:built_collection/built_collection.dart';

import 'package:booster/domain/gallery/gallery_state_entity/gallery_state_entity.dart';
import 'package:booster/infrastructure/gallery/image_local_dto/image_local_dto.dart';
import 'package:booster/utils/converters/image_local_dto_list_converter.dart';

part 'gallery_state_dto.freezed.dart';
part 'gallery_state_dto.g.dart';

@Freezed(unionKey: 'type')
abstract class GalleryStateDto implements _$GalleryStateDto {
  const GalleryStateDto._();

  const factory GalleryStateDto.initial() = _InitialDto;
  const factory GalleryStateDto.loading() = _LoadingDto;
  const factory GalleryStateDto.error() = _ErrorDto;
  const factory GalleryStateDto.success(
    @JsonKey(name: 'images') @ImageLocalDtoListConverter() BuiltList<ImageLocalDto> images,
  ) = _SuccessDto;

  factory GalleryStateDto.fromJson(Map<String, dynamic> json) => _$GalleryStateDtoFromJson(json);

  factory GalleryStateDto.fromEntity(GalleryStateEntity stateEntity) {
    return stateEntity.map(
      initial: (_) => const GalleryStateDto.initial(),
      loading: (_) => const GalleryStateDto.loading(),
      error: (_) => const GalleryStateDto.error(),
      success: (state) => GalleryStateDto.success(
        state.images.map((entity) => ImageLocalDto.fromEntity(entity)).toBuiltList(),
      ),
    );
  }

  GalleryStateEntity toEntity() {
    return map(
      initial: (_) => const GalleryStateEntity.initial(),
      loading: (_) => const GalleryStateEntity.loading(),
      error: (_) => const GalleryStateEntity.error(),
      success: (state) => GalleryStateEntity.success(
        state.images.map((dto) => dto.toEntity()).toBuiltList(),
      ),
    );
  }
}
