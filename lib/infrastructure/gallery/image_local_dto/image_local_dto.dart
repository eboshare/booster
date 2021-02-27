import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:booster/domain/gallery/image_entity/image_entity.dart';

part 'image_local_dto.freezed.dart';
part 'image_local_dto.g.dart';

@freezed
abstract class ImageLocalDto implements _$ImageLocalDto {
  const ImageLocalDto._();
  const factory ImageLocalDto({
    @JsonKey(name: 'id') @required String id,
    @JsonKey(name: 'author') @required String author,
    @JsonKey(name: 'width') @required int width,
    @JsonKey(name: 'height') @required int height,
    @JsonKey(name: 'url') @required String url,
    @JsonKey(name: 'download_url') @required String downloadUrl,
  }) = _ImageLocalDto;

  factory ImageLocalDto.fromJson(Map<String, dynamic> json) => _$ImageLocalDtoFromJson(json);

  factory ImageLocalDto.fromEntity(ImageEntity entity) {
    return ImageLocalDto(
      id: entity.id,
      author: entity.author,
      width: entity.width,
      height: entity.height,
      url: entity.url,
      downloadUrl: entity.downloadUrl,
    );
  }

  ImageEntity toEntity() {
    return ImageEntity(
      id: id,
      author: author,
      width: width,
      height: height,
      url: url,
      downloadUrl: downloadUrl,
    );
  }
}
