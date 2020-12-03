import 'package:flutter_booster_kit/infrastructure/image_list/image_local_dto/image_local_dto.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_booster_kit/domain/image_list/image_entity/image_entity.dart';
import 'package:flutter_booster_kit/domain/image_list/i_image_repository.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';

part 'image_list_bloc.freezed.dart';
part 'image_list_bloc.g.dart';

@lazySingleton
class ImageListBloc extends HydratedBloc<ImageListEvent, ImageListState> {
  final IImageRepository _repository;

  ImageListBloc(this._repository) : super(const ImageListState.loading());

  @override
  Stream<ImageListState> mapEventToState(ImageListEvent event) {
    return event.map(loadImages: _loadImages);
  }

  @override
  ImageListState fromJson(Map<String, dynamic> json) => ImageListState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ImageListState state) => state.toJson();

  /// Fetches images from network only if there are no images already loaded.
  Stream<ImageListState> _loadImages(ImageListEvent _) async* {
    print(state);
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
