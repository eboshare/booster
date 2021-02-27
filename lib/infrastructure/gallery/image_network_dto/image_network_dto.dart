import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:booster/domain/gallery/image_entity/image_entity.dart';

part 'image_network_dto.freezed.dart';
part 'image_network_dto.g.dart';

@freezed
abstract class ImageNetworkDto implements _$ImageNetworkDto {
  const ImageNetworkDto._();
  const factory ImageNetworkDto({
    @JsonKey(name: 'id') @required String id,
    @JsonKey(name: 'author') @required String author,
    @JsonKey(name: 'width') @required int width,
    @JsonKey(name: 'height') @required int height,
    @JsonKey(name: 'url') @required String url,
    @JsonKey(name: 'download_url') @required String downloadUrl,
  }) = _ImageNetworkDto;

  factory ImageNetworkDto.fromJson(Map<String, dynamic> json) => _$ImageNetworkDtoFromJson(json);

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
