// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TaskModel {
//   String taskName;
//   String taskStartDate;
//   String taskEndDate;
//   String description;
//   RxBool isDone;
//   Color color;
//   IconData icon;
//   String taskGroup;

//   TaskModel({
//     required this.taskName,
//     required this.taskStartDate,
//     required this.taskEndDate,
//     required this.description,
//     required this.isDone,
//     required this.color,
//     required this.icon,
//     required this.taskGroup,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'title': taskName,
//       'createdAt': taskStartDate,
//       'taskEndDate': taskEndDate,
//       'description': description,
//       'isCompleted': isDone.value,
//       'color': color.value,
//       'icon': icon.codePoint,
//       'taskGroup': taskGroup,
//     };
//   }

//   factory TaskModel.fromJson(Map<String, dynamic> json) {
//     return TaskModel(
//         taskName: json['title'],
//         taskStartDate: json['createdAt'].toString(),
//         taskEndDate: json['taskEndDate'].toString(),
//         description: json['description'].toString(),
//         isDone: RxBool(json['isCompleted']),
//         color: Color(json['color']),
//         icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
//         taskGroup: json['taskGroup']);
//   }
// }
