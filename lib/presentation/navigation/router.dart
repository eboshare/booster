import 'package:auto_route/auto_route_annotations.dart';

import 'package:flutter_booster_kit/presentation/pages/detailed_image_page.dart';
import 'package:flutter_booster_kit/presentation/pages/gallery_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: [
    MaterialRoute(page: GalleryPage, initial: true),
    MaterialRoute(page: DetailedImagePage),
  ],
)
abstract class $Router {}
