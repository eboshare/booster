import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:flutter_starter_template/layers/domain/repositories/i_todo_repository.dart';
import 'package:flutter_starter_template/layers/domain/entities/todo.dart';

part 'json_placeholder_todo_repository.g.dart';

@Singleton(as: ITodoRepository)
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class JsonPlaceholderTodoRepository implements ITodoRepository {
  @factoryMethod
  factory JsonPlaceholderTodoRepository(Dio dio) = _JsonPlaceholderTodoRepository;

  @override
  @GET('/todos')
  Future<List<Todo>> getTodos();
}
