import 'package:hydrated_bloc/hydrated_bloc.dart';

class FakeStorage implements Storage {
  @override
  Future<void> clear() => Future.value();

  @override
  Future<void> delete(String key) => Future.value();

  @override
  void read(String key) {}

  @override
  Future<void> write(String key, value) => Future.value();
}
