import 'package:flutter/material.dart';

import 'package:booster/presentation/core/design_system/design_system_data/design_system_data.dart';

class DesignSystem extends InheritedWidget {
  final DesignSystemData data;

  const DesignSystem({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(DesignSystem oldWidget) => data != oldWidget.data;

  static DesignSystemData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<DesignSystem>();
    return data.data;
  }
}
