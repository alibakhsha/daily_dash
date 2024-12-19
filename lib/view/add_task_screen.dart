import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/models/api_task_model.dart';
import 'package:todo_m/controller/task_controller.dart';
import 'package:todo_m/gen/assets.gen.dart';
import 'package:todo_m/models/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  final Rx<String?> _selectedTaskGroup = Rx<String?>(null);
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Rx<DateTime?> _startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> _endDate = Rx<DateTime?>(null);

  AddTaskScreen({super.key});

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isStartDate) {
        _startDate.value = picked;
      } else {
        _endDate.value = picked;
      }
    }
  }

  void addTaskButtonHandler() {
    if (_selectedTaskGroup.value == null ||
        _taskNameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _startDate.value == null ||
        _endDate.value == null) {
      Get.snackbar(
        'Snackbar',
        'Please complete the fields correctly.',
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
      return;
    }
    final selectedGroup = TaskData.taskGroup.firstWhereOrNull(
      (group) => group.name == _selectedTaskGroup.value,
    );

    if (selectedGroup == null || selectedGroup.name!.isEmpty) {
      Get.snackbar(
        'Snackbar',
        'Invalid Task Group selection.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

 
    final task = ApiTaskModel(
      title: _taskNameController.text,
      description: _descriptionController.text,
      isCompleted: false,
      createdAt: _startDate
          .value,
      color: selectedGroup.color!, 
      icon: selectedGroup.icon!,
    );



    taskController.createTask(task);
    taskController.fetchTasks();

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding:  EdgeInsets.fromLTRB(size.width/13, size.height/13.61, size.width/13, 0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "ADD TASK",
                    style: textTheme.titleLarge,
                  ),
                ),
                 SizedBox(
                  height: size.height/14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    addTaskSection(
                      size,
                        textTheme,
                        context,
                        _selectedTaskGroup,
                        _taskNameController,
                        _descriptionController,
                        _startDate,
                        _endDate),
                     SizedBox(height: size.height/8.6),
                    Padding(
                      padding:  EdgeInsets.only(bottom: size.height/30),
                      child: Container(
                        width: size.width / 1.17,
                        height: size.height/15.62,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 95, 51, 225),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: InkWell(
                          onTap: addTaskButtonHandler,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add Task", style: textTheme.labelMedium),
                                const SizedBox(width: 8),
                                ImageIcon(
                                  AssetImage(Assets.images.add.path),
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addTaskSection(
      Size size,
      TextTheme textTheme,
      BuildContext context,
      Rx<String?> selectedTaskGroup,
      final TextEditingController taskNameController,
      TextEditingController descriptionController,
      Rx<DateTime?> startDate,
      Rx<DateTime?> endDate) {
    return Column(
      children: [
        Container(
          height: size.height/13.39,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color:
                        // ignore: deprecated_member_use
                        const Color.fromARGB(255, 95, 51, 225).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 7))
              ]),
          child: DropdownButtonFormField<String>(
            iconSize: 0,
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.arrow_drop_down_rounded,
                size: 48,
              ),
              labelText: 'Task Group',
              labelStyle: textTheme.bodySmall,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            value: selectedTaskGroup.value,
            items: TaskData.taskGroup.map((group) {
              return DropdownMenuItem<String>(
                value: group.name,
                child: Row(
                  children: [
                    Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          // ignore: deprecated_member_use
                          color: group.color!.withOpacity(0.2),
                        ),
                        child: Icon(group.icon, size: 14, color: group.color)),
                    const SizedBox(width: 8),
                    Text(group.name!),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              selectedTaskGroup.value = value;
            },
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: size.height/13.39,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color:
                        // ignore: deprecated_member_use
                        const Color.fromARGB(255, 95, 51, 225).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 7))
              ]),
          child: TextField(
            controller: taskNameController,
            decoration: InputDecoration(
              labelText: 'Task Name',
              labelStyle: textTheme.bodySmall,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: size.height/5.94,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color:
                        // ignore: deprecated_member_use
                        const Color.fromARGB(255, 95, 51, 225).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 7))
              ]),
          child: TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: textTheme.bodySmall,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(height: 16),
        dateContainer(context,size, textTheme, true, 'Start Date', startDate),
        const SizedBox(height: 16),
        dateContainer(context,size, textTheme, false, 'End Date', endDate),
      ],
    );
  }

  Widget dateContainer(BuildContext context,Size size, TextTheme textTheme, bool pickDate,
      String s, Rx<DateTime?> dateTime) {
    return Container(
      height: size.height/13.39,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                // ignore: deprecated_member_use
                color: const Color.fromARGB(255, 95, 51, 225).withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 15,
                offset: const Offset(0, 7))
          ]),
      child: GestureDetector(
        onTap: () => _pickDate(context, pickDate),
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
                labelText: s,
                labelStyle: textTheme.bodySmall,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: ImageIcon(
                  AssetImage(Assets.images.calendar.path),
                  size: 14,
                  color: const Color(0xff5F33E1),
                ),
                suffixIcon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 48,
                )),
            controller: TextEditingController(
              text: dateTime.value != null
                  ? '${dateTime.value!.day}/${dateTime.value!.month}/${dateTime.value!.year}'
                  : '',
            ),
          ),
        ),
      ),
    );
  }
}
