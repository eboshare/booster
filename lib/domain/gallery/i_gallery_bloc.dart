import 'package:bloc/bloc.dart';

import 'package:booster/domain/gallery/gallery_event/gallery_event.dart';
import 'package:booster/domain/gallery/gallery_state_entity/gallery_state_entity.dart';

abstract class IGalleryBloc implements Bloc<GalleryEvent, GalleryStateEntity> {}
