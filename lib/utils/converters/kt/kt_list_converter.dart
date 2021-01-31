import 'package:json_annotation/json_annotation.dart';
import 'package:kt_dart/collection.dart';

typedef FromJson<T, S> = T Function(S json);
typedef ToJson<T, S> = S Function(T json);

class KtListConverter<T, S> implements JsonConverter<KtList<T>, List<S>> {
  final FromJson<T, S> _fromJson;
  final ToJson<T, S> _toJson;

  const KtListConverter(this._fromJson, this._toJson);

  @override
  KtList<T> fromJson(List<S> list) => KtList.from(list.map(_fromJson));

  @override
  List<S> toJson(KtList<T> ktList) => ktList.asList().map(_toJson).toList(growable: true);
}
