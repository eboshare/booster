import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_starter_template/helper/composite_disposable.dart';

extension DisposableDisposeWithStateExtension<T extends StatefulWidget> on Disposable {
  void disposeWith(CompositeDisposable<T> state) => state.addDisposable(this);
}

extension ChangeNotifierDisposeWithStateExtension<T extends StatefulWidget> on ChangeNotifier {
  void disposeWith(CompositeDisposable<T> state) => state.addDisposableChangeNotifier(this);
}

extension ReactionDisposeWithStateExtension<T extends StatefulWidget> on ReactionDisposer {
  void disposeWith(CompositeDisposable<T> state) => state.addDisposableReaction(this);
}
