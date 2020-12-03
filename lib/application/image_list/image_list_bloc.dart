import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/domain/image_list/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/domain/image_list/i_image_repository.dart';
import 'package:flutter_booster_kit/infrastructure/image_list/image_list_state_dto/image_list_state_converter_mixin.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';

part 'image_list_bloc.freezed.dart';

@lazySingleton
class ImageListBloc extends HydratedBloc<ImageListEvent, ImageListState> with ImageListStateConverterMixin {
  final IImageRepository _repository;

  ImageListBloc(this._repository) : super(const ImageListState.initial());

  @override
  Stream<ImageListState> mapEventToState(ImageListEvent event) {
    return event.map(loadImages: _loadImages);
  }

  /// Fetches images from network only if there are no images already loaded.
  Stream<ImageListState> _loadImages(ImageListEvent _) async* {
    yield* state.maybeMap(
      success: (_) => const Stream.empty(),
      orElse: () async* {
        yield const ImageListState.loading();

        final failureOrImages = await _repository.getImageList();
        yield failureOrImages.fold(
          (_) => const ImageListState.error(),
          (images) => ImageListState.success(images),
        );
      },
    );
  }
}
