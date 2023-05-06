import 'package:flutter/material.dart';
import 'package:task_scheduler/model/subtask_item.dart';
import 'package:task_scheduler/model/task_item.dart';

class Tasks{
  // list of todo
  List<TaskItem> _tasklist = [];

  // get task
  List <TaskItem> get task => _tasklist;

  void addTask(TaskItem todo) {
    _tasklist.add(todo);
  }

  void updateTask(TaskItem todo, int index) {
    _tasklist[index] = todo;
  }

  void deleteTask(int index) {
    _tasklist.removeAt(index);
  }
}