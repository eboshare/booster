import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/application/image_list/image_list_bloc.dart';
import 'package:flutter_booster_kit/domain/image_list/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/infrastructure/image_list/image_local_dto/image_local_dto.dart';

part 'image_list_state_dto.freezed.dart';
part 'image_list_state_dto.g.dart';

@Freezed(unionKey: 'type')
abstract class ImageListStateDto implements _$ImageListStateDto {
  const ImageListStateDto._();

  const factory ImageListStateDto.initial() = _InitialDto;
  const factory ImageListStateDto.loading() = _LoadingDto;
  const factory ImageListStateDto.error() = _ErrorDto;
  const factory ImageListStateDto.success(
    @JsonKey(name: 'images') @ImagesConverter() List<ImageEntity> images,
  ) = _SuccessDto;

  factory ImageListStateDto.fromJson(Map<String, dynamic> json) => _$ImageListStateDtoFromJson(json);

  factory ImageListStateDto.fromStateEntity(ImageListState stateEntity) {
    return stateEntity.map(
      initial: (_) => const ImageListStateDto.initial(),
      loading: (_) => const ImageListStateDto.loading(),
      error: (_) => const ImageListStateDto.error(),
      success: (state) => ImageListStateDto.success(state.images),
    );
  }

  ImageListState toStateEntity() {
    return map(
      initial: (_) => const ImageListState.initial(),
      loading: (_) => const ImageListState.loading(),
      error: (_) => const ImageListState.error(),
      success: (state) => ImageListState.success(state.images),
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
