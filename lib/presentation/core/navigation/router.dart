import 'package:auto_route/auto_route_annotations.dart';

import 'package:booster/presentation/gallery/detailed_image_page.dart';
import 'package:booster/presentation/gallery/gallery_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: [
    MaterialRoute(page: GalleryPage, initial: true),
    MaterialRoute(page: DetailedImagePage),
  ],
)
abstract class $Router {}
