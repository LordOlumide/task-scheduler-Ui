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
import '../provider/subtask_provider.dart';
import '../size_config.dart';

class TaskScreen extends StatefulWidget {
  final String taskName;
  final List<SubTaskItem> subtasks;
  final String description;

  const TaskScreen(
      {super.key,
      required this.taskName,
      required this.subtasks,
      required this.description});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _subTaskDescriptioncontroller = TextEditingController();
  final _subTaskcontroller = TextEditingController();

  // void addSubTask(int index, TodoItem todoItem) {
  //   setState(() {
  //     todoList[index] = todoItem;
  //     // todoList.add(TodoItem('', _subTaskcontroller.text, false));
  //     _subTaskcontroller.clear();
  //     Navigator.of(context).pop();
  //   });
  // }

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

    final subtasksProvider = Provider.of<SubTaskProvider>(context);
    final subtasks = subtasksProvider.subtasks;

    final tasksProvider = Provider.of<TaskProvider>(context);
    final tasks = tasksProvider.tasks;

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
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextField(
                        controller: _subTaskcontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Add a new description',
                            focusColor: ktertiaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextField(
                        controller: _subTaskDescriptioncontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Add a sub task',
                            focusColor: ktertiaryColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            //  tasks[int].description
                            subtasksProvider.addSubTask(SubTaskItem(
                                description: _subTaskDescriptioncontroller.text,
                                subText: _subTaskcontroller.text));
                            Provider.of<SubTaskProvider>(context,
                                listen: false);
                            Navigator.pop(context);
                            _subTaskcontroller.clear();
                            _subTaskDescriptioncontroller.clear();
                          },
                          child: Container(
                            height: 50,
                            width: 90,
                            decoration: BoxDecoration(
                                color: kprimaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Add Task',
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
                            subtasksProvider.addSubTask(SubTaskItem(
                                description: _subTaskDescriptioncontroller.text,
                                subText: _subTaskcontroller.text));
                            Provider.of<SubTaskProvider>(context,
                                listen: false);
                            Navigator.pop(context);
                            _subTaskcontroller.clear();
                            _subTaskDescriptioncontroller.clear();
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
                  ],
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
                widget.taskName,
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
                '3/15 subtask done',
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
                currentValue: 20,
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
                widget.description,
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
                    itemCount: widget.subtasks.length,
                    itemBuilder: ((context, index) {
                      print(subtasks.length);
                      final subtask = widget.subtasks[index];
                      return Consumer<SubTaskProvider>(
                        builder: (context, subTaskProvider, child) =>
                            SubTaskCard(
                          subTaskName: subtask.description,
                          subTaskDetails: subtask.subText,
                          taskCompleted: subtask.isDone,
                          ontap: () {
                            setState(() {
                              subtasks[index].isDone = !subtasks[index].isDone;
                            });
                          },
                          deleteFunction: (BuildContext) {
                            subtasksProvider.deleteSubTask(index);
                          },
                          // saveSubTask: () {
                          //   Null;
                          // },
                        ),
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
