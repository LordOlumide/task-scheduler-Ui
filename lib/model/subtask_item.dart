class SubTaskItem {
  String subTaskName;
  String subText;
  bool isDone;
  DateTime timeLastModified;

  SubTaskItem({
    this.subTaskName = '',
    this.subText = '',
    this.isDone = false,
    required this.timeLastModified,
  });

  void toggleDoneStatus() {
    isDone = !isDone;
  }

  void updateSubTask(SubTaskItem newSubTask) {
    subTaskName = newSubTask.subTaskName;
    subText = newSubTask.subText;
    timeLastModified = DateTime.now();
  }
}
