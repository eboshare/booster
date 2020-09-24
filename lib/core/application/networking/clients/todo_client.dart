import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:flutter_starter_template/core/domain/clients/i_todo_client.dart';
import 'package:flutter_starter_template/core/domain/entities/todo.dart';

part 'todo_client.g.dart';

@Singleton(as: ITodoClient)
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class TodoClient implements ITodoClient {
  @factoryMethod
  factory TodoClient(Dio dio) = _TodoClient;

  @override
  @GET('/todos')
  Future<List<Todo>> getTodos();
}
