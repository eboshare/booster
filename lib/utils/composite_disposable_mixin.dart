import 'package:flutter/widgets.dart';

abstract class Disposable {
  void dispose();
}

mixin CompositeDisposable<T extends StatefulWidget> on State<T> {
  final List<ChangeNotifier> _changeNotifiers = [];
  final List<Disposable> _disposableDisposers = [];

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
    for (final disposable in _disposableDisposers) {
      disposable.dispose();
    }
  }
}
