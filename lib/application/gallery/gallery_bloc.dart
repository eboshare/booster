import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:booster/domain/gallery/gallery.dart';
import 'package:booster/infrastructure/gallery/gallery.dart';

// implements keyword is required for injectable to match interface to this class implementation.
@LazySingleton(as: IGalleryBloc)
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
