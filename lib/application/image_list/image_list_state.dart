part of 'image_list_bloc.dart';

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

@freezed
abstract class ImageListState with _$ImageListState {
  const factory ImageListState.initial() = _Initial;
  const factory ImageListState.loading() = _Loading;
  const factory ImageListState.error() = _Error;
  const factory ImageListState.success(List<ImageEntity> images) = _Success;
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
