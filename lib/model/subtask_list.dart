import 'package:flutter/material.dart';
import 'package:task_scheduler/model/subtask_item.dart';

class SubTasks{
  // list of Subtodo
  List<SubTaskItem> _subtasklist = [];

  // get task
  List <SubTaskItem> get task => _subtasklist;

  void addTask(SubTaskItem todo) {
    _subtasklist.add(todo);
  }

  void updateTask(SubTaskItem todo, int index) {
    _subtasklist[index] = todo;
  }

  void deleteTask(int index) {
    _subtasklist.removeAt(index);
  }
}
