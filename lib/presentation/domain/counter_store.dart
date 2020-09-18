import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'counter_store.g.dart';

@singleton
class CounterPageStore = CounterPageStoreBase with _$CounterPageStore;

abstract class CounterPageStoreBase with Store {
  @observable
  int count = 0;

  @action
  void increment() {
    count++;
  }
}
