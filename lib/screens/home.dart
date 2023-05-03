// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_scheduler/constants.dart';
import 'package:task_scheduler/screens/statistics.dart';
import 'dart:math' as math;
import 'package:page_transition/page_transition.dart';
import '../components/task_card.dart';
import '../components/task_container.dart';
import '../components/task_heading.dart';
import '../size_config.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late AnimationController controller3;
  late AnimationController controller4;
  late Animation<double> numAnimation;
  late Animation<Offset> offsetContainer;
  late Animation<Offset> offsetFirstContainer;
  late Animation<Offset> offsetSecContainer;
  // Animation sizeAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    numAnimation = Tween<double>(begin: 1, end: 34).animate(controller);

    controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    offsetContainer = Tween<Offset>(begin: Offset(4.0, 0.0), end: Offset(0, 0))
        .animate(controller2);

    controller3 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    offsetFirstContainer =
        Tween<Offset>(begin: Offset(5.0, 0.0), end: Offset(0, 0))
            .animate(controller3);

    controller4 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    offsetSecContainer =
        Tween<Offset>(begin: Offset(6.0, 0.0), end: Offset(0, 0))
            .animate(controller4);

    controller.forward();
    controller2.forward();
    controller3.forward();
    controller4.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller;
    controller2;
    controller3;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // Calculate the size of the widget based on the screen width
    final double widgetWidth = SizeConfig.screenWidth * 0.8;

    return Scaffold(
      backgroundColor: ksecondaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: SizeConfig.screenHeight * 0.15,
                width: SizeConfig.screenWidth * 0.9,
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
                          backgroundImage: AssetImage('images/SmileyFace.png'),
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
                              onPressed: null, icon: Icon(Icons.notifications)),
                        )),
                  ],
                ),
              ),
            ),
            ksmallSizedbox,

            // statistic card
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(
                    type: PageTransitionType.scale,
                    alignment: Alignment.center, 
                    duration: Duration(milliseconds: 700),
                    child: StatisticScreen()));

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StatisticScreen()));
                },
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
                                builder: (BuildContext context, Widget? child) {
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
            ksmallSizedbox,

            // Task circles

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Addtaskcircle(
                      animation: offsetFirstContainer,
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
                    Addtaskcircle(
                      animation: offsetSecContainer,
                      icon: Icon(Icons.bookmark),
                      circleText: Text("Favourite"),
                      circleColor: kwhiteColor,
                    ),
                    Addtaskcircle(
                      animation: offsetContainer,
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
              children: [
                TaskHeading(
                  leadingTextColor: ksecondaryColor,
                  traillingIconColor: ksecondaryColor,
                ),
                TaskCard(
                  taskName: 'Design review',
                  cardcolor: ksecondaryColor,
                ),
                ksmallSizedbox,
                TaskCard(taskName: 'Interview', cardcolor: Colors.grey),
                TaskCard(taskName: 'finish the chapter', cardcolor: Colors.grey)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Addtaskcircle extends StatelessWidget {
  final Icon icon;
  final Text circleText;
  final Color circleColor;
  final Animation<Offset> animation;
  const Addtaskcircle({
    super.key,
    required this.icon,
    required this.circleText,
    required this.circleColor,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            circleText,
          ],
        ),
      ),
    );
  }
}
