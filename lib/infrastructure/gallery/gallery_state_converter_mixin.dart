import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:booster/domain/gallery/gallery.dart';
import 'package:booster/infrastructure/gallery/gallery.dart';

mixin GalleryStateConverterMixin on HydratedBloc<GalleryEvent, GalleryStateEntity> {
  @override
  GalleryStateEntity fromJson(Map<String, dynamic> json) => GalleryStateDto.fromJson(json).toEntity();

  @override
  Map<String, dynamic> toJson(GalleryStateEntity state) => GalleryStateDto.fromEntity(state).toJson();
}
