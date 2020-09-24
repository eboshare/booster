import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:flutter_starter_template/networking/models/todo.dart';
import 'package:flutter_starter_template/interfaces/json_placeholder_client.dart';

part 'json_placeholder.g.dart';

@Singleton(as: ITodoClient)
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class TodoClient implements ITodoClient {
  @factoryMethod
  factory TodoClient(Dio dio) = _TodoClient;

  @override
  @GET('/todos')
  Future<List<Todo>> getTodos();
}
