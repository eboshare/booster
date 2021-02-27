import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_event.freezed.dart';

@freezed
abstract class ConnectionEvent with _$ConnectionEvent {
  const factory ConnectionEvent.connected() = ConnectionConnectedEvent;
  const factory ConnectionEvent.disconnected() = ConnectionDisconnectedEvent;
  const factory ConnectionEvent.check() = ConnectionCheckEvent;
}
