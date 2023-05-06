import 'package:flutter/material.dart';
import 'package:task_scheduler/model/subtask_item.dart';

import '../model/subtask_list.dart';


class SubTaskProvider extends ChangeNotifier {
  SubTasks _subtasks = SubTasks();

  List<SubTaskItem> get subtasks => _subtasks.task;

  void addSubTask(SubTaskItem subtask) {
    _subtasks.addTask(subtask);
    notifyListeners();
  }

  void updateSubTask(SubTaskItem subtask, int index) {
    _subtasks.updateTask(subtask, index);
    notifyListeners();
  }

  void deleteSubTask(int index) {
    _subtasks.deleteTask(index);
    notifyListeners();
  }
}
