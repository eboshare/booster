import 'package:auto_route/auto_route_annotations.dart';

import 'package:booster/presentation/pages/detailed_image_page.dart';
import 'package:booster/presentation/pages/gallery_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: [
    MaterialRoute(page: GalleryPage, initial: true),
    MaterialRoute(page: DetailedImagePage),
  ],
)
abstract class $Router {}
