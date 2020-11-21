import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
abstract class ImageEntity implements _$ImageEntity {
  const ImageEntity._();
  const factory ImageEntity({
    @JsonKey(name: 'id') @required String id,
    @JsonKey(name: 'author') @required String author,
    @JsonKey(name: 'width') @required int width,
    @JsonKey(name: 'height') @required int height,
    @JsonKey(name: 'url') @required String url,
    @JsonKey(name: 'download_url') @required String downloadUrl,
  }) = _ImageEntity;

  factory ImageEntity.fromJson(Map<String, dynamic> json) => _$ImageEntityFromJson(json);

  String constructDownloadUrl({
    @required int width,
    @required int height,
  }) {
    return downloadUrl.replaceFirst(RegExp(r'\d+/\d+$'), '$width/$height');
  }
}
