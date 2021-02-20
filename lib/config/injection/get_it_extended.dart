import 'dart:async';

import 'package:get_it/get_it.dart';

typedef OnDispose<T> = FutureOr<void> Function(T value);

class GetItExtended {
  final GetIt _getItInstance;
  final Map<dynamic, Function> _typeToCallback = {};

  GetItExtended(this._getItInstance);

  Future<void> reset({
    bool dispose = true,
  }) {
    return _getItInstance.reset(dispose: dispose);
  }

  Future<void> allReady({
    Duration timeout,
    bool ignorePendingAsyncCreation = false,
  }) {
    return _getItInstance.allReady(
      timeout: timeout,
      ignorePendingAsyncCreation: ignorePendingAsyncCreation,
    );
  }

  Future<T> getAsync<T>({
    String instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return _getItInstance.getAsync<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
  }

  void registerFactoryAsync<T>(
    FactoryFuncAsync<T> asyncFunc, {
    String instanceName,
    OnDispose<T> onDispose,
  }) {
    _getItInstance.registerFactoryAsync<T>(
      asyncFunc,
      instanceName: instanceName,
    );
    _saveOnDispose(onDispose);
  }

  void registerSingletonAsync<T>(
    FactoryFuncAsync<T> providerFunc, {
    String instanceName,
    Iterable<Type> dependsOn,
    bool signalsReady,
    OnDispose<T> onDispose,
  }) {
    _getItInstance.registerSingletonAsync<T>(
      providerFunc,
      instanceName: instanceName,
      dependsOn: dependsOn,
      signalsReady: signalsReady,
    );
    _saveOnDispose(onDispose);
  }

  void registerLazySingletonAsync<T>(
    FactoryFuncAsync<T> func, {
    String instanceName,
    OnDispose<T> onDispose,
  }) {
    _getItInstance.registerLazySingletonAsync<T>(
      func,
      instanceName: instanceName,
    );
    _saveOnDispose(onDispose);
  }

  T call<T>({
    String instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return _getItInstance.call<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
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
    _getItInstance.registerFactory(func, instanceName: instanceName);
    _saveOnDispose<T>(onDispose);
  }

  void registerSingleton<T>(
    T instance, {
    String instanceName,
    bool signalsReady,
    OnDispose<T> onDispose,
  }) {
    _getItInstance.registerSingleton(
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
    _getItInstance.registerLazySingleton(func, instanceName: instanceName);
    _saveOnDispose<T>(onDispose);
  }

  OnDispose<T> _getOnDispose<T>() {
    return _typeToCallback[T] as OnDispose<T>;
  }

  void _saveOnDispose<T>(OnDispose<T> onDispose) {
    _typeToCallback[T] = onDispose;
  }
}
