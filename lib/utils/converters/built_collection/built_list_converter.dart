import 'package:built_collection/built_collection.dart';
import 'package:json_annotation/json_annotation.dart';

typedef FromJson<T, S> = T Function(S json);
typedef ToJson<T, S> = S Function(T json);

class BuiltListConverter<T, S> implements JsonConverter<BuiltList<T>, List<S>> {
  final FromJson<T, S> _fromJson;
  final ToJson<T, S> _toJson;

  const BuiltListConverter(this._fromJson, this._toJson);

  @override
  BuiltList<T> fromJson(List<S> list) => list.map(_fromJson).toBuiltList();

  @override
  List<S> toJson(BuiltList<T> builtList) => builtList.map(_toJson).toList(growable: true);
}
