import 'package:mobx/mobx.dart';

part 'counter_store.g.dart';

class CounterStore = CounterStoreBase with _$CounterStore;

abstract class CounterStoreBase with Store {
  CounterStoreBase({this.count = 0});

  @observable
  int count;

  @action
  void increment() {
    count++;
  }
}
