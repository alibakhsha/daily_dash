import 'package:flutter/material.dart';


class TaskGroup {
   String? name;
   IconData? icon;
   Color? color;

  TaskGroup(this.name, this.icon, this.color);
}

class TaskData {
  static List<TaskGroup> taskGroup =[
    TaskGroup('Work', Icons.work_outline, const Color(0xffF478B8)),
    TaskGroup('Gym', Icons.fitness_center_outlined, const Color(0xff39fc03)),
    TaskGroup('Study', Icons.school_outlined, const Color(0xff5F33E1)),
    TaskGroup('Other', Icons.list_alt_outlined, const Color(0xff4a544a)),
  ];
}
