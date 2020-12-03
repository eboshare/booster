part of 'image_list_bloc.dart';

@Freezed(unionKey: 'type')
abstract class ImageListState with _$ImageListState {
  const factory ImageListState.initial() = _Initial;
  const factory ImageListState.loading() = _Loading;
  const factory ImageListState.error() = _Error;
  const factory ImageListState.success(
    @JsonKey(name: 'images') @ImagesConverter() List<ImageEntity> images,
  ) = _Success;

  factory ImageListState.fromJson(Map<String, dynamic> json) => _$ImageListStateFromJson(json);
}

class ImagesConverter implements JsonConverter<List<ImageEntity>, List<dynamic>> {
  const ImagesConverter();

  @override
  List<ImageEntity> fromJson(List<dynamic> imageJsonList) {
    return imageJsonList.map(
      (imageJson) => ImageLocalDto.fromJson(imageJson).toEntity(),
    ).toList();
  }

  @override
  List<dynamic> toJson(List<ImageEntity> imageEntityList) {
    return imageEntityList.map(
      (imageEntity) => ImageLocalDto.fromEntity(imageEntity).toJson(),
    ).toList();
  }
}
