import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/controller/task_controller.dart';
import 'package:todo_m/models/api_task_model.dart';

import '../gen/assets.gen.dart';

class TaskTile extends StatelessWidget {
  final ApiTaskModel apiTask;
  final int index;

  const TaskTile({super.key, required this.apiTask, required this.index});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();
    return Container(
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 4, color: apiTask.color!)),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          // ignore: deprecated_member_use
          color: apiTask.color!.withOpacity(0.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          apiTask.icon,
                          size: 14,
                          color: apiTask.color,
                        ),
                        Text(
                          apiTask.title!,
                          style: TextStyle(color: apiTask.color),
                        ),
                        Text(
                          '${apiTask.createdAt!.year.toString()}/${apiTask.createdAt!.month.toString()}/${apiTask.createdAt!.day.toString()}',
                          style:
                              // ignore: deprecated_member_use
                              TextStyle(color: apiTask.color!.withOpacity(0.3)),
                        ),
                      ]),
                ),
                InkWell(
                    onTap: () => taskController.toggleTask(apiTask.id.toString()),
                    child: apiTask.isCompleted == true
                        ? Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1000)),
                                color: Colors.white),
                            child: Center(
                                child: ImageIcon(
                              AssetImage(Assets.images.checkTask.path),
                              size: 13,
                              color: apiTask.color,
                            )),
                          )
                        : Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1000)),
                                color: Colors.white),
                          )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
