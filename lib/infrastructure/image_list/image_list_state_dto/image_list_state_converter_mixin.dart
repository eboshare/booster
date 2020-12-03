import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:flutter_booster_kit/application/image_list/image_list_bloc.dart';
import 'package:flutter_booster_kit/infrastructure/image_list/image_list_state_dto/image_list_state_dto.dart';

mixin ImageListStateConverterMixin on HydratedBloc<ImageListEvent, ImageListState> {
  @override
  ImageListState fromJson(Map<String, dynamic> json) {
    return ImageListStateDto.fromJson(json).toStateEntity();
  }

  @override
  Map<String, dynamic> toJson(ImageListState state) {
    return ImageListStateDto.fromStateEntity(state).toJson();
  }
}