import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_list_failure.freezed.dart';

@freezed
abstract class ImageListFailure with _$ImageListFailure {
  factory ImageListFailure.unknown() = UnknownImageListFailure;
}
