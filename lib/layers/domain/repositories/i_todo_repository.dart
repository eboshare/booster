import 'package:flutter_starter_template/layers/domain/entities/todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getTodos();
}
