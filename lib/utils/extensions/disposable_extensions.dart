import 'package:flutter/widgets.dart';

import 'package:flutter_booster_kit/utils/composite_disposable_mixin.dart';

extension DisposableDisposeWithStateExtension<T extends StatefulWidget> on Disposable {
  void disposeWith(CompositeDisposable<T> state) => state.addDisposable(this);
}

extension ChangeNotifierDisposeWithStateExtension<T extends StatefulWidget> on ChangeNotifier {
  void disposeWith(CompositeDisposable<T> state) => state.addDisposableChangeNotifier(this);
}
