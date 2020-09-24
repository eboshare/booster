import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import 'package:flutter_starter_template/interfaces/counter_page_store.dart';

part 'counter_store.g.dart';


@Singleton(as: ICounterPageStore)
class CounterPageStore = CounterPageStoreBase with _$CounterPageStore;

abstract class CounterPageStoreBase with Store implements ICounterPageStore {
  @override
  @observable
  int count = 0;

  @override
  @action
  void increment() {
    count++;
  }
}
