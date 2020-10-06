import 'package:auto_route/auto_route_annotations.dart';

import 'package:flutter_starter_template/layers/presentation/pages/detailed_image_page.dart';
import 'package:flutter_starter_template/layers/presentation/pages/image_list_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: [
    MaterialRoute(page: ImageListPage, initial: true),
    MaterialRoute(page: DetailedImagePage),
  ],
)
abstract class $Router {}
