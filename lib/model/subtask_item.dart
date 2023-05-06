class SubTaskItem {
  String description;
  String subText;
  bool isDone;
  // DateTime timeAdded ;
  

  SubTaskItem({this.description = '', this.subText = '', this.isDone = false,});

  void toggleDone() {
    isDone = !isDone;
  }
}
