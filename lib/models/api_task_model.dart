import 'package:flutter/material.dart';

class ApiTaskModel {
  int? id;
  String? title;
  String? description;
  bool? isCompleted;
  DateTime? createdAt;
  DateTime? endDate;
  String? taskGroup;
  String? name;
  Color? color;
  IconData? icon;

  ApiTaskModel(
      {this.id,
      this.title,
      this.description,
      this.isCompleted,
      this.createdAt,
      this.endDate,
      this.taskGroup,
      this.name, 
      this.color,
      this.icon});

  factory ApiTaskModel.fromJson(Map<String, dynamic> json) {
    return ApiTaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
