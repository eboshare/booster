part of 'image_list_bloc.dart';

@freezed
abstract class ImageListState with _$ImageListState {
  const factory ImageListState.initial() = _Initial;
  const factory ImageListState.loading() = _Loading;
  const factory ImageListState.error() = _Error;
  const factory ImageListState.success(List<ImageEntity> images) = _Success;
}
