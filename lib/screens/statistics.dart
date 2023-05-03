// ignore_for_file: prefer_const_constructors,, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_scheduler/constants.dart';

import '../bar gragh/bar_graph.dart';
import '../components/rotatin_circle.dart';
import '../components/task_container.dart';
import '../components/task_heading.dart';
import '../size_config.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<double> circleAnimation;
  late Animation<double> numAnimation;
  late Animation<Offset> offsetNumber;

  @override
  void initState() {
    super.initState();
    _controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 20))
          ..repeat();
    _controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    circleAnimation = Tween(begin: 0.0, end: 2 * pi).animate(_controller1);
    numAnimation = Tween<double>(begin: 1, end: 84).animate(_controller2);
    // _controller1.forward();
    _controller2.forward();

    _controller3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    offsetNumber = Tween<Offset>(begin: Offset(0.0, -3.0), end: Offset(0, 0))
        .animate(_controller3);
    _controller3.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  List<double> weeklySummary = [
    20.5,
    30.2,
    60.7,
    10.2,
    40.2,
    80.2,
    23.2,
    20.5,
    30.2,
  ];

  void popOff() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        elevation: 0,
        leading: GestureDetector(
            onTap: popOff,
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: ksecondaryColor,
            )),
        title: Text(
          'Statistics',
          style: TextStyle(color: ksecondaryColor, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              height: 30,
              width: SizeConfig.screenWidth * 0.3,
              decoration: BoxDecoration(
                  border: Border.all(color: ksecondaryColor),
                  color: kprimaryColor,
                  borderRadius: BorderRadius.circular(30)),
              // child here
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Month',
                    style: TextStyle(
                        color: ksecondaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: ksecondaryColor,
                    size: 35,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          // big circle
          Stack(
            children: [
              RotatingCircle(circleAnimation: circleAnimation),
              Positioned(
                left: 80,
                bottom: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 140,
                        width: 140,
                        child: SlideTransition(
                          position: offsetNumber,
                          child: Text(
                            '34',
                            style: TextStyle(
                                color: kwhiteColor,
                                fontSize: 120,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                    // Text(
                    //   '34',
                    //   style: TextStyle(
                    //       color: kwhiteColor,
                    //       fontSize: 140,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    ksmallSizedbox,
                    Text(
                      'Completed task',
                      style: TextStyle(color: kwhiteColor, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
          kbigSizedbox,
          Container(
            height: 70,
            width: SizeConfig.screenWidth * 0.8,
            decoration: BoxDecoration(
                color: ktertiaryColor, borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                'Share the result',
                style: TextStyle(
                    color: kwhiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),

          //     Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Container(
          //     height: SizeConfig.screenHeight * 0.25,
          //     width: SizeConfig.screenWidth,
          //     decoration: BoxDecoration(
          //         color: ksecondaryColor, borderRadius: BorderRadius.circular(30)),
          //     child: Column(
          //       children: [

          //       ],
          //     ),
          //   ),
          // ),
          kbigSizedbox,
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
                height: SizeConfig.screenHeight * 0.1,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    color: ksecondaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily',
                        style: TextStyle(
                            color: kwhiteColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Challenge',
                            style: TextStyle(
                                color: kwhiteColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          ),
                          AnimatedBuilder(
                              animation: numAnimation,
                              builder: (BuildContext context, Widget? child) {
                                return Text(
                                  numAnimation.value.toStringAsFixed(0) + '%',
                                  style: TextStyle(
                                    color: kwhiteColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                  ),
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Container(
                height: SizeConfig.screenHeight * 0.15,
                decoration: BoxDecoration(
                    color: ksecondaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: MyBarGraph(
                  WeeklyExpense: weeklySummary,
                )),
          )
        ],
      ),
    );
  }
}
