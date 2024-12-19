// import 'package:flutter/material.dart';

// class TaskStyleService {
//   static String getNameForTask(int id) {
//     List<String> defaultNames = [
//       'work',
//       'gym',
//       'study',
//       'other'
//     ];
//     return defaultNames[id % defaultNames.length];
//   }

//   static Color getColorForTask(int id) {
//     List<Color> defaultColors = [
//       const Color(0xffF478B8),
//       const Color(0xff39fc03),
//       const Color(0xff5F33E1),
//       const Color(0xff4a544a)
//     ];
//     return defaultColors[id % defaultColors.length];
//   }

//   static IconData getIconForTask(int id) {
//     List<IconData> defaultIcons = [
//       Icons.work_outline,
//       Icons.fitness_center_outlined,
//       Icons.school_outlined,
//       Icons.list_alt_outlined
//     ];
//     return defaultIcons[id % defaultIcons.length];
//   }
// }

import 'package:flutter/material.dart';

class TaskStyleService {
  static final Map<int, String> _taskNames = {};
  static final Map<int, Color> _taskColors = {};
  static final Map<int, IconData> _taskIcons = {};

  static String getNameForTask(int id) {
    if (_taskNames.containsKey(id)) {
      return _taskNames[id]!;
    } else {
      List<String> defaultNames = ['work', 'gym', 'study', 'other'];
      String name = defaultNames[id % defaultNames.length];
      _taskNames[id] = name;
      return name;
    }
  }

  static Color getColorForTask(int id) {
    if (_taskColors.containsKey(id)) {
      return _taskColors[id]!;
    } else {
      List<Color> defaultColors = [
        const Color(0xffF478B8),
        const Color(0xff39fc03),
        const Color(0xff5F33E1),
        const Color(0xff4a544a),
      ];
      Color color = defaultColors[id % defaultColors.length];
      _taskColors[id] = color;
      return color;
    }
  }

  static IconData getIconForTask(int id) {
    if (_taskIcons.containsKey(id)) {
      return _taskIcons[id]!;
    } else {
      List<IconData> defaultIcons = [
        Icons.work_outline,
        Icons.fitness_center_outlined,
        Icons.school_outlined,
        Icons.list_alt_outlined,
      ];
      IconData icon = defaultIcons[id % defaultIcons.length];
      _taskIcons[id] = icon;
      return icon;
    }
  }
}
