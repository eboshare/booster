import 'package:freezed_annotation/freezed_annotation.dart';

part 'environment.freezed.dart';

@freezed
abstract class Environment with _$Environment {
  const factory Environment.dev() = _Development;
  const factory Environment.prod() = _Production;
  const factory Environment.test() = _Testing;
}
