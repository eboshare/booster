import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:booster/domain/gallery/gallery_event/gallery_event.dart';
import 'package:booster/domain/gallery/gallery_state_entity/gallery_state_entity.dart';
import 'package:booster/infrastructure/gallery/gallery_state_dto/gallery_state_dto.dart';

mixin GalleryStateConverterMixin on HydratedBloc<GalleryEvent, GalleryStateEntity> {
  @override
  GalleryStateEntity fromJson(Map<String, dynamic> json) => GalleryStateDto.fromJson(json).toEntity();

  @override
  Map<String, dynamic> toJson(GalleryStateEntity state) => GalleryStateDto.fromEntity(state).toJson();
}
