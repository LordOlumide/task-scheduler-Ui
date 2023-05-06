import 'package:flutter/material.dart';
import 'package:task_scheduler/model/subtask_item.dart';
import 'package:task_scheduler/model/subtask_list.dart';
import 'package:task_scheduler/model/task_item.dart';
import 'package:task_scheduler/model/task_list.dart';



class TaskProvider extends ChangeNotifier {
  Tasks _tasks = Tasks();

  List<TaskItem> get tasks => _tasks.task;
  

  void addTask(TaskItem task) {
    _tasks.addTask(task);
    notifyListeners();
  }

  void updateTask(TaskItem task, int index) {
    _tasks.updateTask(task, index);
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.deleteTask(index);
    notifyListeners();
  }

  

  // List<SubTaskItem> get subtasks => _subtasks.task;

  // void addSubTask(SubTaskItem subtask) {
  //   _subtasks.addTask(subtask);
  //   notifyListeners();
  // }

  // void updateSubTask(SubTaskItem subtask, int index) {
  //   _subtasks.updateTask(subtask, index);
  //   notifyListeners();
  // }

  // void deleteSubTask(int index) {
  //   _subtasks.deleteTask(index);
  //   notifyListeners();
  // }
}
