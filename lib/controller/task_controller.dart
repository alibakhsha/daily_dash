import 'package:get/get.dart';
import 'package:todo_m/models/api_task_model.dart';
import 'package:todo_m/service/api_service.dart';
import 'package:todo_m/service/task_style_service.dart';

class TaskController extends GetxController {
  final ApiService _apiService = ApiService();

  var tasks = <ApiTaskModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  // Fetch all tasks from the API
  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetchedTasks = await _apiService.getTasks();
      tasks.assignAll(fetchedTasks);
      tasks.assignAll(
        fetchedTasks.map((task) => ApiTaskModel(
              id: task.id,
              title: task.title,
              createdAt: task.createdAt,
              isCompleted: task.isCompleted,
              name: TaskStyleService.getNameForTask(task.id!),
              color: TaskStyleService.getColorForTask(task.id!),
              icon: TaskStyleService.getIconForTask(task.id!),
            )),
      );
    } catch (e) {
      errorMessage.value = 'Failed to load tasks: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<ApiTaskModel?> fetchTaskById(String taskId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      return await _apiService.getTaskById(taskId);
    } catch (e) {
      errorMessage.value = 'Failed to fetch task: $e';
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTask(ApiTaskModel task) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _apiService.createTask(task);
      tasks.add(task);
    } catch (e) {
      errorMessage.value = 'Failed to create task: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(String taskId, ApiTaskModel updatedTask) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _apiService.updateTask(taskId, updatedTask);
      int index = tasks.indexWhere((task) => task.id.toString() == taskId);
      if (index != -1) {
        tasks[index] = updatedTask;
      }
    } catch (e) {
      errorMessage.value = 'Failed to update task: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _apiService.deleteTask(taskId);
      tasks.removeWhere((task) => task.id.toString() == taskId);
    } catch (e) {
      errorMessage.value = 'Failed to delete task: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleTask(String taskId) async {
    try {
      int index = tasks.indexWhere((task) => task.id.toString() == taskId);
      if (index != -1) {
        var task = tasks[index];
        task.isCompleted = !(task.isCompleted ?? false);
        tasks[index] = task;
        final updatedTask = ApiTaskModel(
          id: task.id,
          title: task.title,
          createdAt: task.createdAt,
          isCompleted: false, // مقدار پیش‌فرض را به سرور ارسال می‌کنیم
          name: task.name,
          color: task.color,
          icon: task.icon,
        );
        await _apiService.updateTask(taskId, updatedTask);
      }
    } catch (e) {
      errorMessage.value = 'Failed to toggle task: $e';
    }
  }

  // String _getNameForTask(int id) {
  //   List<String> defaultNames = [
  //     'work',
  //     'gym',
  //     'study',
  //     'other'
  //   ];
  //   return defaultNames[id % defaultNames.length];
  // }

  // Color _getColorForTask(int id) {
  //   List<Color> defaultColors = [
  //     const Color(0xffF478B8),
  //     const Color(0xff39fc03),
  //     const Color(0xff5F33E1),
  //     const Color(0xff4a544a)
  //   ];
  //   return defaultColors[id % defaultColors.length];
  // }

  // IconData _getIconForTask(int id) {
  //   List<IconData> defaultIcons = [
  //     Icons.work_outline,
  //     Icons.fitness_center_outlined,
  //     Icons.school_outlined,
  //     Icons.list_alt_outlined
  //   ];
  //   return defaultIcons[id % defaultIcons.length];
  // }
}
