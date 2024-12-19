import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/controller/task_controller.dart';
import 'package:todo_m/view/add_task_screen.dart';
import 'package:todo_m/view/edit_task_screen.dart';
import 'package:todo_m/gen/assets.gen.dart';

import '../component/my_components.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());


  HomeScreen({super.key});

  void editButtonHandler() {
    Get.to(EditTaskScreen());
  }

  void addTaskButtonHandler() {
    Get.to(AddTaskScreen());
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.fromLTRB(size.width/13, size.height/13.61, size.width/13, 0),
        child: Column(
          children: [
            Center(
                child: Text(
              "HOME",
              style: textTheme.titleLarge,
            )),
             SizedBox(
              height: size.height/28,
            ),
            Row(
              children: [
                Container(
                  width: size.width/5.57,
                  height: size.height/21.1,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 95, 51, 225),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: InkWell(
                    onTap: editButtonHandler,
                    child: Center(
                        child: Text(
                      "Edit",
                      style: textTheme.labelSmall,
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: size.height/1.5,
              color: Colors.white,
              child: Obx(() {
                if (taskController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (taskController.tasks.isEmpty) {
                  return Center(
                    child: Text(
                      "List is empty",
                      style: textTheme.bodyLarge,
                    ),
                  );
                }
                return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      var apiTask = taskController.tasks[index];
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TaskTile(apiTask: apiTask,index: index));
                    });
              }),
            ),
             SizedBox(
              height: size.height/28,
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: size.height/28),
              child: Container(
                width: size.width / 1.17,
                height: size.height/15.62,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 95, 51, 225),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: InkWell(
                  onTap: addTaskButtonHandler,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(" "),
                        Text("Add Task", style: textTheme.labelMedium),
                        ImageIcon(
                          AssetImage(Assets.images.add.path),
                          size: 24,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
