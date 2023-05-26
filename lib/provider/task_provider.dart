import 'package:flutter/material.dart';
import 'package:task_scheduler/model/subtask_item.dart';
import 'package:task_scheduler/model/task_item.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskItem> _tasks = [];

  List<TaskItem> get tasks => _tasks;

  int noOfCompletedSubTasksInTask({required int taskIndex}) {
    return _tasks[taskIndex]
        .subTasks
        .where((subTask) => subTask.isDone == true)
        .length;
  }

  int noOfSubTasksInTask({required int taskIndex}) {
    return _tasks[taskIndex].subTasks.length;
  }

  // This function will initialize the database from local or remote storage.
  void initialize() {}

  // Add functions
  void addTask(TaskItem task) {
    _tasks.add(task);
    notifyListeners();
  }

  void addSubTaskToTask({
    required int taskIndex,
    required SubTaskItem subTask,
  }) {
    _tasks[taskIndex].subTasks.add(subTask);
    _tasks[taskIndex].timeLastModified = DateTime.now();
    notifyListeners();
  }

  // Toggle functions
  void toggleSubTaskStatusInTask({
    required int taskIndex,
    required int subTaskIndex,
  }) {
    _tasks[taskIndex].subTasks[subTaskIndex].toggleDoneStatus();
    _tasks[taskIndex].timeLastModified = DateTime.now();
    notifyListeners();
  }

  // Edit functions
  void editTask({
    required int taskIndex,
    required TaskItem newTask,
  }) {
    _tasks[taskIndex].taskName = newTask.taskName;
    _tasks[taskIndex].description = newTask.description;
    _tasks[taskIndex].timeLastModified = DateTime.now();
    notifyListeners();
  }

  void editSubTaskInTask({
    required int taskIndex,
    required int subTaskIndex,
    required SubTaskItem newSubTask,
  }) {
    _tasks[taskIndex].subTasks[subTaskIndex].updateSubTask(newSubTask);
    _tasks[taskIndex].timeLastModified = DateTime.now();
    notifyListeners();
  }

  // Delete functions
  void deleteTask(int taskIndex) {
    _tasks.removeAt(taskIndex);
    notifyListeners();
  }

  void deleteSubTaskInTask({
    required int taskIndex,
    required int subTaskIndex,
  }) {
    _tasks[taskIndex].subTasks.removeAt(subTaskIndex);
    _tasks[taskIndex].timeLastModified = DateTime.now();
    notifyListeners();
  }
}
