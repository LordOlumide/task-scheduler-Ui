// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_scheduler/constants.dart';
import 'package:task_scheduler/model/task_item.dart';
import 'package:task_scheduler/provider/task_provider.dart';
import 'package:task_scheduler/screens/statistics.dart';
import 'dart:math' as math;
import 'package:page_transition/page_transition.dart';
import 'package:task_scheduler/screens/task_screen.dart';
import '../components/add_task_circle.dart';
import '../components/task_card.dart';
import '../components/task_container.dart';
import '../components/task_heading.dart';
import '../size_config.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late AnimationController controller5;
  late AnimationController taskCardController;

  late Animation<double> numAnimation;
  late Animation<Offset> offsetThirdCircle;
  late Animation<Offset> offsetFirstCircle;
  late Animation<Offset> offsetSecCircle;
  late Animation<Offset> _animateTaskContainer;
  late Animation<Offset> _animateStatisticContainer;
  late Animation<Offset> _animateAppbar;
  late Animation<double> _animateTaskCardContainer;

  // Animation sizeAnimation;
  double height = 120;
  double width = 400;

  bool isContainerPressed = false;

  void ContainerPressed() {
    setState(() {
      if (isContainerPressed == false) {
        height = height - 8;
        width = width - 100;
        isContainerPressed = true;
      } else if (isContainerPressed == true) {
        height = 120;
        width = 400;
        isContainerPressed = false;
      }
    });
  }

  final _tasknamecontroller = TextEditingController();
  final _descriptioncontroller = TextEditingController();

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    numAnimation = Tween<double>(begin: 1, end: 34).animate(controller);

    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    offsetThirdCircle =
        Tween<Offset>(begin: Offset(4.0, 0.0), end: Offset(0, 0))
            .animate(controller2);

    offsetFirstCircle =
        Tween<Offset>(begin: Offset(5.0, 0.0), end: Offset(0, 0))
            .animate(controller2);

    offsetSecCircle = Tween<Offset>(begin: Offset(6.0, 0.0), end: Offset(0, 0))
        .animate(controller2);
    controller5 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animateTaskContainer =
        Tween<Offset>(begin: Offset(00, 5.0), end: Offset(00, 00))
            .animate(controller5);
    _animateStatisticContainer =
        Tween<Offset>(begin: Offset(00, -5.0), end: Offset(00, 00))
            .animate(controller5);

    _animateAppbar = Tween<Offset>(begin: Offset(00, -3.0), end: Offset(00, 00))
        .animate(controller5);

    taskCardController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _animateTaskCardContainer =
        CurvedAnimation(parent: taskCardController, curve: Curves.easeOut);

    controller.forward();
    controller2.forward();
    taskCardController.forward();
    controller5.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller;
    controller2;

    controller5;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // Calculate the size of the widget based on the screen width
    final tasksProvider = Provider.of<TaskProvider>(context);
    final tasks = tasksProvider.tasks;

    return Scaffold(
      backgroundColor: ksecondaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SlideTransition(
                position: _animateAppbar,
                child: Container(
                  decoration: BoxDecoration(
                    color: kwhiteColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 55,
                      ),
                      // circle avartar and notificaton icon
                      ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('images/SmileyFace.png'),
                            radius: 20,
                          ),
                          title: Text(
                            'Jay the Dev',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          trailing: Container(
                            height: 40,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20)),
                            child: IconButton(
                                onPressed: null,
                                icon: Icon(Icons.notifications)),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            ksmallSizedbox,

            // statistic container
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 700),
                          child: StatisticScreen()));

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StatisticScreen()));
                },
                child: SlideTransition(
                  position: _animateStatisticContainer,
                  child: Container(
                    height: SizeConfig.screenHeight * 0.2,
                    width: SizeConfig.screenWidth * 0.9,
                    decoration: BoxDecoration(
                        color: kprimaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              child: AnimatedBuilder(
                                  animation: numAnimation,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Text(
                                      numAnimation.value.toStringAsFixed(0),
                                      style: TextStyle(
                                          fontSize: 100,
                                          fontWeight: FontWeight.w900),
                                    );
                                  }),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: 35,
                                  ),
                                  kbigSizedbox,
                                  Text(
                                    'you have completed the task this month keep it up',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w100),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ksmallSizedbox,

            // Task circles

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //Show modal sheet

                        showModalBottomSheet(
                          elevation: 90,
                          backgroundColor: ktertiaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  kbigSizedbox,
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextField(
                                      maxLength: 20,
                                      maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                      style: TextStyle(
                                        color: kwhiteColor,
                                      ),
                                      controller: _tasknamecontroller,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kwhiteColor),
                                        ),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: kprimaryColor)),
                                        hintText: 'Add a new task',
                                        hintStyle: TextStyle(
                                          color: kwhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextField(
                                      style: TextStyle(
                                        color: kwhiteColor,
                                      ),
                                      controller: _descriptioncontroller,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kwhiteColor),
                                        ),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: kprimaryColor)),
                                        hintText: 'Add Description',
                                        hintStyle: TextStyle(
                                          color: kwhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          tasksProvider.addTask(
                                              // Task item
                                              TaskItem(
                                                  taskName:
                                                      _tasknamecontroller.text,
                                                  description:
                                                      _descriptioncontroller
                                                          .text,
                                                  timeLastModified:
                                                      DateTime.now()));
                                          Navigator.pop(context);
                                          _descriptioncontroller.clear();
                                          _tasknamecontroller.clear();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: kprimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          _descriptioncontroller.clear();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: kprimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                      },

                      // task circle
                      child: Addtaskcircle(
                        animation: offsetFirstCircle,
                        icon: Icon(
                          Icons.add,
                          color: kwhiteColor,
                        ),
                        circleText: Text(
                          "Add task",
                          style: TextStyle(color: kwhiteColor),
                        ),
                        circleColor: ktertiaryColor,
                      ),
                    ),
                    Addtaskcircle(
                      animation: offsetSecCircle,
                      icon: Icon(Icons.bookmark),
                      circleText: Text("Favourite"),
                      circleColor: kwhiteColor,
                    ),
                    Addtaskcircle(
                      animation: offsetThirdCircle,
                      icon: Icon(Icons.widgets),
                      circleText: Text("widgets"),
                      circleColor: kwhiteColor,
                    ),
                  ],
                ),
              ),
            ),

            // task container

            TaskContainer(
              taskContainerColor: kwhiteColor,
              containerAnimation: _animateTaskContainer,
              children: [
                TaskHeading(
                  headingName: 'Priorities',
                  leadingTextColor: ksecondaryColor,
                  traillingIconColor: ksecondaryColor,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Color cardColor =
                          index == 0 ? ksecondaryColor : Colors.grey;
                      String formattedDate = DateFormat.yMd()
                          .format(tasks[index].timeLastModified);
                      return Center(
                        child: TaskCard(
                          taskName: tasks[index].taskName,
                          cardcolor: cardColor,
                          numOfSubtacks: tasks[index].subTasks.length,
                          timeAdded: formattedDate,
                          deleteFunction: (context) {
                            tasksProvider.deleteTask(index);
                          },
                          // animation: _animateTaskCardContainer,
                          ontap: () {
                            Future.delayed(Duration(milliseconds: 200), () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskScreen(
                                      taskIndex: index,
                                    ),
                                  ));
                            });
                            // ContainerPressed();
                          },
                          height: height,
                          width: width, isContainerPressed: isContainerPressed,
                        ),
                      );
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
