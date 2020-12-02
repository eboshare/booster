import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/domain/image_list/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/domain/image_list/i_image_repository.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';
part 'image_list_bloc.freezed.dart';

@lazySingleton
class ImageListBloc extends Bloc<ImageListEvent, ImageListState> {
  final IImageRepository _repository;

  ImageListBloc(this._repository) : super(const ImageListState.loading());

  @override
  Stream<ImageListState> mapEventToState(ImageListEvent event) {
    return event.map(loadImages: _loadImages);
  }

  Stream<ImageListState> _loadImages(ImageListEvent _) async* {
    yield const ImageListState.loading();

    final failureOrImages = await _repository.getImageList();
    yield failureOrImages.fold(
      (_) => const ImageListState.error(),
      (images) => ImageListState.success(images),
    );
  }
}
