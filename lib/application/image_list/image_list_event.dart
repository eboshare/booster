part of 'image_list_bloc.dart';

@freezed
abstract class ImageListEvent with _$ImageListEvent {
  const factory ImageListEvent.loadImages() = _LoadImages;
}
