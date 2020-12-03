import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_failure.freezed.dart';

@freezed
abstract class GalleryFailure with _$GalleryFailure {
  factory GalleryFailure.unknown() = UnknownGalleryFailure;
}
