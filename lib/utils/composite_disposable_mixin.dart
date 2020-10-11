import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

abstract class Disposable {
  void dispose();
}

mixin CompositeDisposable<T extends StatefulWidget> on State<T> {
  final List<ChangeNotifier> _changeNotifiers = [];
  final List<ReactionDisposer> _reactionDisposers = [];
  final List<Disposable> _disposableDisposers = [];

  void addDisposableReaction<K extends ReactionDisposer>(K reactionDisposer) {
    _reactionDisposers.add(reactionDisposer);
  }

  void addDisposableChangeNotifier<K extends ChangeNotifier>(K notifier) {
    _changeNotifiers.add(notifier);
  }

  void addDisposable<K extends Disposable>(K disposable) {
    _disposableDisposers.add(disposable);
  }

  @override
  void dispose() {
    super.dispose();
    for (final notifier in _changeNotifiers) {
      notifier.dispose();
    }
    for (final reactionDisposer in _reactionDisposers) {
      reactionDisposer();
    }
    for (final disposable in _disposableDisposers) {
      disposable.dispose();
    }
  }
}
