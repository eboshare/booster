import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:flutter_booster_kit/domain/gallery/gallery.dart';
import 'package:flutter_booster_kit/infrastructure/gallery/gallery.dart';

mixin GalleryStateConverterMixin on HydratedBloc<GalleryEvent, GalleryStateEntity> {
  @override
  GalleryStateEntity fromJson(Map<String, dynamic> json) {
    return GalleryStateDto.fromJson(json).toStateEntity();
  }

  @override
  Map<String, dynamic> toJson(GalleryStateEntity state) {
    return GalleryStateDto.fromStateEntity(state).toJson();
  }
}
