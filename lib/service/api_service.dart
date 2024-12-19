import 'package:dio/dio.dart';
import 'package:todo_m/models/api_task_model.dart';

class ApiService {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://gandom-shjpr9s-projects.vercel.app'));

  Future<List<ApiTaskModel>> getTasks() async {
    final response = await _dio.get('/api/tasks');
    return (response.data['tasks'] as List)
        .map((json) => ApiTaskModel.fromJson(json))
        .toList();
  }

  Future<ApiTaskModel> getTaskById(String taskId) async {
    final response = await _dio.get('/api/task/$taskId');
    return ApiTaskModel.fromJson(response.data);
  }

  Future<void> createTask(ApiTaskModel task) async {
    // await _dio.post('/api/task/create', data: task.toJson());
     await _dio.post('/api/task/create', data: task.toJson());
    // print(post);
  }

  Future<void> updateTask(String taskId, ApiTaskModel task) async {
    await _dio.put('/api/task/$taskId', data: task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _dio.delete('/api/task/$taskId');
  }
}
