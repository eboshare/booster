import 'package:flutter/cupertino.dart';

import 'package:flutter_starter_template/presentation/theme/theme_data.dart';

class Thm extends InheritedWidget {
  final ThmData themeData;

  const Thm({
    Key key,
    @required this.themeData,
    @required Widget child,
  })  : assert(child != null),
        assert(themeData != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(Thm oldWidget) => themeData != oldWidget.themeData;

  static ThmData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<Thm>();
    return theme.themeData;
  }
}
