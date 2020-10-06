import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
abstract class Image with _$Image {
  factory Image({
    @JsonKey(name: 'id') @required String result,
    @JsonKey(name: 'author') @required String author,
    @JsonKey(name: 'width') @required int width,
    @JsonKey(name: 'height') @required int height,
    @JsonKey(name: 'url') @required String url,
    @JsonKey(name: 'download_url') @required String downloadUrl,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
