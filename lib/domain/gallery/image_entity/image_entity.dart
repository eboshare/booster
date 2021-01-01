import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_entity.freezed.dart';

final _urlRegExp = RegExp(r'\d+/\d+$');

@freezed
abstract class ImageEntity implements _$ImageEntity {
  const ImageEntity._();
  const factory ImageEntity({
    @required String id,
    @required String author,
    @required int width,
    @required int height,
    @required String url,
    @required String downloadUrl,
  }) = _ImageEntity;

  String constructDownloadUrl({
    @required int width,
    @required int height,
  }) {
    return downloadUrl.replaceFirst(_urlRegExp, '$width/$height');
  }
}
