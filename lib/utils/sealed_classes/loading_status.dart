import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_status.freezed.dart';

@freezed
abstract class LoadingStatus with _$LoadingStatus {
  factory LoadingStatus.loading() = _Loading;
  factory LoadingStatus.error() = _Error;
  factory LoadingStatus.success() = _Success;
}
