import 'package:flutter_starter_template/core/domain/entities/todo.dart';

abstract class ITodoClient {
  Future<List<Todo>> getTodos();
}
