import 'package:flutter_starter_template/networking/models/todo.dart';

abstract class ITodoClient {
  Future<List<Todo>> getTodos();
}
