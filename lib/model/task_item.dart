import 'package:task_scheduler/model/subtask_item.dart';

class TaskItem {
  String taskName;
  String description;
  DateTime timeAdded;
  int taskDone;
  List<SubTaskItem> subTasks;

  TaskItem(
      {this.taskName = '',
      this.description = '',
      required this.timeAdded,
      this.taskDone = 0,
      required this.subTasks});

  // void toggleDone() {
  //   isDone = !isDone;
  // }
}
