import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:booster/domain/gallery/gallery_event/gallery_event.dart';
import 'package:booster/domain/gallery/gallery_state_entity/gallery_state_entity.dart';
import 'package:booster/domain/gallery/i_gallery_bloc.dart';
import 'package:booster/domain/gallery/i_image_repository.dart';
import 'package:booster/infrastructure/gallery/gallery_state_converter_mixin.dart';

class GalleryBloc extends HydratedBloc<GalleryEvent, GalleryStateEntity>
    with GalleryStateConverterMixin
    implements IGalleryBloc {
  final IImageRepository _repository;

  GalleryBloc(this._repository) : super(const GalleryStateEntity.initial());

  @override
  Stream<GalleryStateEntity> mapEventToState(GalleryEvent event) {
    return event.map(loadImages: _loadImages);
  }

  /// Fetches images from network only if there are no images already loaded.
  Stream<GalleryStateEntity> _loadImages(GalleryEvent _) async* {
    yield* state.maybeMap(
      success: (_) => const Stream.empty(),
      orElse: () async* {
        yield const GalleryStateEntity.loading();

        final failureOrImages = await _repository.getImages();
        yield failureOrImages.fold(
          (_) => const GalleryStateEntity.error(),
          (images) => GalleryStateEntity.success(images),
        );
      },
    );
  }
}
