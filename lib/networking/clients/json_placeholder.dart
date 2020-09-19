import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:flutter_starter_template/networking/models/todo.dart';

part 'json_placeholder.g.dart';

@singleton
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class JsonPlaceholderClient {
  @factoryMethod
  factory JsonPlaceholderClient(Dio dio) = _JsonPlaceholderClient;

  @GET('/todos')
  Future<List<Todo>> getTodos();
}
