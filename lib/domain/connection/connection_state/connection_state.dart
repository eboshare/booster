import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_state.freezed.dart';

@freezed
abstract class ConnectionState with _$ConnectionState {
  const factory ConnectionState.initial() = _Initial;
  const factory ConnectionState.connected() = _Connected;
  const factory ConnectionState.disconnected() = _Disconnected;
}
