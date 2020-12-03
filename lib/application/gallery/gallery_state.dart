part of 'gallery_bloc.dart';

@freezed
abstract class GalleryState with _$GalleryState {
  const factory GalleryState.initial() = _Initial;
  const factory GalleryState.loading() = _Loading;
  const factory GalleryState.error() = _Error;
  const factory GalleryState.success(List<ImageEntity> images) = _Success;
}
