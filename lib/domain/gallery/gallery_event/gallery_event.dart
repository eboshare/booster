import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_event.freezed.dart';

@freezed
abstract class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.loadImages() = _LoadImages;
}
