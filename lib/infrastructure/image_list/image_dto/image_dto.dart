import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/domain/image_list/image_entity/image_entity.dart';

part 'image_dto.freezed.dart';
part 'image_dto.g.dart';

@freezed
abstract class ImageDto implements _$ImageDto {
  const ImageDto._();
  const factory ImageDto({
    @JsonKey(name: 'id') @required String id,
    @JsonKey(name: 'author') @required String author,
    @JsonKey(name: 'width') @required int width,
    @JsonKey(name: 'height') @required int height,
    @JsonKey(name: 'url') @required String url,
    @JsonKey(name: 'download_url') @required String downloadUrl,
  }) = _ImageDto;

  factory ImageDto.fromJson(Map<String, dynamic> json) => _$ImageDtoFromJson(json);

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
