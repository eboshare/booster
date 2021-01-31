import 'package:kt_dart/collection.dart';

extension KtListX<T> on KtList<T> {
  T get firstElement => get(0);

  T get lastElement => get(lastIndex);
}
