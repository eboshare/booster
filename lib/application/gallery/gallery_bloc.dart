import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/domain/gallery/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/domain/gallery/i_image_repository.dart';
import 'package:flutter_booster_kit/infrastructure/gallery/gallery_state_dto/gallery_state_converter_mixin.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

part 'gallery_bloc.freezed.dart';

@lazySingleton
class GalleryBloc extends HydratedBloc<GalleryEvent, GalleryState> with GalleryStateConverterMixin {
  final IImageRepository _repository;

  GalleryBloc(this._repository) : super(const GalleryState.initial());

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) {
    return event.map(loadImages: _loadImages);
  }

  /// Fetches images from network only if there are no images already loaded.
  Stream<GalleryState> _loadImages(GalleryEvent _) async* {
    yield* state.maybeMap(
      success: (_) => const Stream.empty(),
      orElse: () async* {
        yield const GalleryState.loading();

        final failureOrImages = await _repository.getImages();
        yield failureOrImages.fold(
          (_) => const GalleryState.error(),
          (images) => GalleryState.success(images),
        );
      },
    );
  }
}
