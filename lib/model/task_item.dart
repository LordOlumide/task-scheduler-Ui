import 'package:task_scheduler/model/subtask_item.dart';

class TaskItem {
  String taskName;
  String description;
  DateTime timeLastModified;

  final DateTime timeCreated = DateTime.now();
  final List<SubTaskItem> subTasks = [];

  TaskItem({
    required this.taskName,
    this.description = '',
    required this.timeLastModified,
  });

  int get tasksDone =>
      subTasks.where((subTask) => subTask.isDone == true).length;
}
