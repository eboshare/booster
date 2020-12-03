import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:flutter_booster_kit/application/gallery/gallery_bloc.dart';
import 'package:flutter_booster_kit/infrastructure/gallery/gallery_state_dto/gallery_state_dto.dart';

mixin GalleryStateConverterMixin on HydratedBloc<GalleryEvent, GalleryState> {
  @override
  GalleryState fromJson(Map<String, dynamic> json) {
    return GalleryStateDto.fromJson(json).toStateEntity();
  }

  @override
  Map<String, dynamic> toJson(GalleryState state) {
    return GalleryStateDto.fromStateEntity(state).toJson();
  }
}
