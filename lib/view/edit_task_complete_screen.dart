import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_m/controller/task_controller.dart';
import 'package:todo_m/models/api_task_model.dart';
import 'package:todo_m/gen/assets.gen.dart';
import 'package:todo_m/models/task_model.dart';

class EditPageCompleteScreen extends StatelessWidget {
  final ApiTaskModel apiTaskModel;
  final TaskController taskController = Get.put(TaskController());
  final Rx<String?> _selectedTaskGroup = Rx<String?>(null);
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Rx<DateTime?> _startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> _endDate = Rx<DateTime?>(null);
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  EditPageCompleteScreen({super.key, required this.apiTaskModel}) {
    _selectedTaskGroup.value = apiTaskModel.taskGroup;
    _taskNameController.text = apiTaskModel.title ?? '';
    _descriptionController.text = apiTaskModel.description ?? '';
    _startDate.value = _parseDate(apiTaskModel.createdAt.toString());
    _endDate.value = _parseDate(apiTaskModel.endDate.toString());
  }

  DateTime _parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return DateTime.now();
    }
  }

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
        _startDateController.text =
            '${_startDate.value!.day}/${_startDate.value!.month}/${_startDate.value!.year}';
      } else {
        _endDate.value = picked;
        _endDateController.text =
            '${_endDate.value!.day}/${_endDate.value!.month}/${_endDate.value!.year}';
      }
    }
  }

  void editTaskButtonHandler() {
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
    } else {
      apiTaskModel.title = _taskNameController.text;
      apiTaskModel.description = _descriptionController.text;
      apiTaskModel.taskGroup = _selectedTaskGroup.value;
      apiTaskModel.createdAt = _startDate.value;
      apiTaskModel.endDate = _endDate.value;

      final selectedGroup = TaskData.taskGroup
          .firstWhere((group) => group.name == _selectedTaskGroup.value);

      apiTaskModel.icon = selectedGroup.icon;
      apiTaskModel.color = selectedGroup.color;

      taskController.updateTask(apiTaskModel.id.toString(), apiTaskModel);
      taskController.fetchTaskById(apiTaskModel.id.toString());
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              size.width / 13, size.height / 13.61, size.width / 13, 0),
          child: Column(
            children: [
              Center(
                  child: Text(
                "EDIT TASK",
                style: textTheme.titleLarge,
              )),
              SizedBox(
                height: size.height / 14,
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: size.height / 13.39,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 95, 51, 225)
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: const Offset(0, 7))
                          ]),

                      // dropdown for task group
                      child: DropdownButtonFormField<String>(
                        iconSize: 0,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 48,
                          ),
                          labelText: 'Task Group',
                          labelStyle: textTheme.bodySmall,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                        value: _selectedTaskGroup.value,
                        items: TaskData.taskGroup.map((group) {
                          return DropdownMenuItem<String>(
                            value: group.name,
                            child: Row(
                              children: [
                                Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      // ignore: deprecated_member_use
                                      color: group.color!.withOpacity(0.2),
                                    ),
                                    child: Icon(group.icon,
                                        size: 14, color: group.color)),
                                const SizedBox(width: 8),
                                Text(group.name!),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _selectedTaskGroup.value = value;

                          // Update the icon and color in the model
                          final selectedGroup = TaskData.taskGroup.firstWhere(
                            (group) => group.name == value,
                          );
                          apiTaskModel.icon = selectedGroup.icon;
                          apiTaskModel.color = selectedGroup.color;

                          // Optional: Trigger a UI update if needed
                          // taskController.update();
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: size.height / 13.39,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 95, 51, 225)
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: const Offset(0, 7))
                          ]),
                      child: TextField(
                        controller: _taskNameController,
                        decoration: InputDecoration(
                          labelText: 'Task Name',
                          labelStyle: textTheme.bodySmall,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: size.height / 5.94,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 95, 51, 225)
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: const Offset(0, 7))
                          ]),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: textTheme.bodySmall,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: size.height / 13.39,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 95, 51, 225)
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: const Offset(0, 7))
                          ]),
                      child: GestureDetector(
                        onTap: () => _pickDate(context, true),
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Start Date',
                                labelStyle: textTheme.bodySmall,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                prefixIcon: ImageIcon(
                                  AssetImage(Assets.images.calendar.path),
                                  color: const Color.fromARGB(255, 95, 51, 225),
                                ),
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 48,
                                )),
                            controller: _startDateController,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: size.height / 13.39,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 95, 51, 225)
                                    // ignore: deprecated_member_use
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: const Offset(0, 7))
                          ]),
                      child: GestureDetector(
                        onTap: () => _pickDate(context, false),
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'End Date',
                                labelStyle: textTheme.bodySmall,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                prefixIcon: ImageIcon(
                                  AssetImage(Assets.images.calendar.path),
                                  color: const Color.fromARGB(255, 95, 51, 225),
                                ),
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 48,
                                )),
                            controller: _endDateController,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height / 8.6),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height / 30),
                      child: Container(
                        width: size.width / 1.17,
                        height: size.height / 15.62,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 95, 51, 225),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: InkWell(
                          onTap: editTaskButtonHandler,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Edit", style: textTheme.labelMedium),
                                const SizedBox(
                                  width: 8,
                                ),
                                ImageIcon(
                                  AssetImage(Assets.images.tablerEdit.path),
                                  size: 24,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
