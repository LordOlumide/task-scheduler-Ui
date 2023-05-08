// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:task_scheduler/model/subtask_item.dart';
import 'package:task_scheduler/model/task_item.dart';
import 'package:task_scheduler/provider/task_provider.dart';
import '../components/sub_task_tile.dart';
import '../components/task_card.dart';
import '../components/task_container.dart';
import '../components/task_heading.dart';
import '../constants.dart';
import '../size_config.dart';

class TaskScreen extends StatefulWidget {
  final int taskIndex;

  const TaskScreen({
    super.key,
    required this.taskIndex,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _subTaskDescriptionController = TextEditingController();
  final _subTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final tasksProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: ksecondaryColor,
      appBar: AppBar(
        backgroundColor: ksecondaryColor,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.grey,
            )),
        // title: Text(
        //   'Statistics',
        //   style: TextStyle(color: ksecondaryColor, fontWeight: FontWeight.w700),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              height: 30,
              width: SizeConfig.screenWidth * 0.3,
              decoration: BoxDecoration(
                  border: Border.all(color: kprimaryColor),
                  color: ksecondaryColor,
                  borderRadius: BorderRadius.circular(30)),
              // child here
              child: Center(
                child: Text(
                  'In process',
                  style: TextStyle(
                      color: kprimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          )
        ],
      ),

      //Floating Action Button
      floatingActionButton: FloatingActionButton(
          backgroundColor: ktertiaryColor,
          child: Icon(
            Icons.add,
            color: kwhiteColor,
          ),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: ktertiaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: TextField(
                          controller: _subTaskController,
                          decoration:InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                           color: kwhiteColor),
                                        ),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                                BorderSide(
                                                  width: 3,
                                                  color: kprimaryColor)
                                                  ),
                                        hintText: '',
                                        hintStyle: TextStyle(
                                          color: kwhiteColor,
                                        ),
                                      ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: TextField(
                          controller: _subTaskDescriptionController,
                          decoration:InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                           color: kwhiteColor),
                                        ),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                                BorderSide(
                                                  width: 3,
                                                  color: kprimaryColor)
                                                  ),
                                        hintText: 'Add a sub task',
                                        hintStyle: TextStyle(
                                          color: kwhiteColor,
                                        ),
                                      ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              tasksProvider.addSubTaskToTask(
                                  taskIndex: widget.taskIndex,
                                  subTask: SubTaskItem(
                                    subTaskName:
                                        _subTaskDescriptionController.text,
                                    subText: _subTaskController.text,
                                    timeLastModified: DateTime.now(),
                                  ));
                              Navigator.pop(context);
                              _subTaskController.clear();
                              _subTaskDescriptionController.clear();
                            },
                            child: Container(
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: kprimaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Add Sub-Task',
                                  style: TextStyle(
                                      color: ksecondaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              _subTaskController.clear();
                              _subTaskDescriptionController.clear();
                            },
                            child: Container(
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: kprimaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: ksecondaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                );
              },
            );
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                tasksProvider.tasks[widget.taskIndex].taskName,
                style: TextStyle(color: kwhiteColor, fontSize: 30),
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            // text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                '${tasksProvider.noOfCompletedSubTasksInTask(taskIndex: widget.taskIndex)}/'
                '${tasksProvider.noOfSubTasksInTask(taskIndex: widget.taskIndex)} subtask done',
                style: TextStyle(color: kwhiteColor, fontSize: 19),
              ),
            ),

            //animated loading bar
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: FAProgressBar(
                backgroundColor: Colors.grey,
                progressColor: kprimaryColor,
                currentValue: 70,
                displayText: '%',
                displayTextStyle: TextStyle(
                  color: ksecondaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              )),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),

            // another text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Description',
                style: TextStyle(color: kwhiteColor, fontSize: 20),
              ),
            ),

            ksmallSizedbox,

            // little text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                tasksProvider.tasks[widget.taskIndex].description,
                style: TextStyle(
                  color: kwhiteColor,
                ),
              ),
            ),

            kbigSizedbox,

            // animated container
            TaskContainer(
              taskContainerColor: kwhiteColor,
              children: [
                TaskHeading(
                  headingName: 'All subtasks',
                  leadingTextColor: ksecondaryColor,
                  traillingIconColor: ksecondaryColor,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        tasksProvider.tasks[widget.taskIndex].subTasks.length,
                    itemBuilder: ((context, index) {
                      print(tasksProvider
                          .tasks[widget.taskIndex].subTasks.length);
                      final SubTaskItem subTask =
                          tasksProvider.tasks[widget.taskIndex].subTasks[index];
                      return SubTaskCard(
                        subTaskName: subTask.subTaskName,
                        subTaskDetails: subTask.subText,
                        taskCompleted: subTask.isDone,
                        ontap: () {
                          tasksProvider.toggleSubTaskStatusInTask(
                            taskIndex: widget.taskIndex,
                            subTaskIndex: index,
                          );
                        },
                        deleteFunction: (context) {
                          tasksProvider.deleteSubTaskInTask(
                            taskIndex: widget.taskIndex,
                            subTaskIndex: index,
                          );
                        },
                        // saveSubTask: () {
                        //   Null;
                        // },
                      );
                    }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
