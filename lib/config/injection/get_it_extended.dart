import 'dart:async';

import 'package:get_it/get_it.dart';

typedef OnDispose<T> = FutureOr<void> Function(T value);

class GetItExtended {
  final GetIt getItInstance;
  final Map<dynamic, Function> _typeToCallback = {};

  GetItExtended(this.getItInstance);

  T call<T>({
    String instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return getItInstance.call<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
  }

  OnDispose<T> _getOnDispose<T>() {
    return _typeToCallback[T] as OnDispose<T>;
  }

  void _saveOnDispose<T>(OnDispose<T> onDispose) {
    _typeToCallback[T] = onDispose;
  }

  Future<void> dispose<T>(T instance) async {
    final onDispose = _getOnDispose<T>();
    if (onDispose != null) {
      return onDispose(instance);
    }
  }

  void registerFactory<T>(
    FactoryFunc<T> func, {
    String instanceName,
    OnDispose<T> onDispose,
  }) {
    getItInstance.registerFactory(func, instanceName: instanceName);
    _saveOnDispose<T>(onDispose);
  }

  void registerSingleton<T>(
    T instance, {
    String instanceName,
    bool signalsReady,
    OnDispose<T> onDispose,
  }) {
    getItInstance.registerSingleton(
      instance,
      instanceName: instanceName,
      signalsReady: signalsReady,
    );
    _saveOnDispose<T>(onDispose);
  }

  void registerLazySingleton<T>(
    FactoryFunc<T> func, {
    String instanceName,
    OnDispose<T> onDispose,
  }) {
    getItInstance.registerLazySingleton(func, instanceName: instanceName);
    _saveOnDispose<T>(onDispose);
  }
}
