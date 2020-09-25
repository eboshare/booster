import 'package:auto_route/auto_route_annotations.dart';

import 'package:flutter_starter_template/layers/presentation/pages/counter/counter_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: [
    MaterialRoute(page: CounterPage, initial: true),
  ],
)
abstract class $Router {}
