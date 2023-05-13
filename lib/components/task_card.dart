// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants.dart';
import '../size_config.dart';

class TaskCard extends StatelessWidget {
  final String taskName;
  final Color cardcolor;
  final int numOfSubtacks;
  final String timeAdded;
  final Function() ontap;
  // Animation<double> animation;
  double height;
  double width;
  bool isContainerPressed;
  Function(BuildContext)? deleteFunction;


  TaskCard(
      {super.key,
      required this.taskName,
      required this.cardcolor,
      required this.numOfSubtacks,
      required this.timeAdded,
      required this.ontap,
      // required this.animation,
      required this.height,
      required this.width,
      required this.isContainerPressed,
      required this.deleteFunction
      
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 8.0,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: GestureDetector(
          onTap: ontap,
          child: Center(
            child: Container(
              height: height,
              width: width,
              // height: 120,
              // width: SizeConfig.screenWidth * 0.85,
              decoration: BoxDecoration(
                  color: cardcolor, borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  kbigSizedbox,
                  ListTile(
                    // leading: Icon(
                    //   Icons.fireplace,
                    //   color: kwhiteColor,
                    // ),
                    title: Text(
                      taskName,
                      style: const TextStyle(
                          color: kwhiteColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    trailing: const Icon(
                      Icons.done,
                      color: kwhiteColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          numOfSubtacks > 1
                              ? '${numOfSubtacks.toString()} Subtasks'
                              : '${numOfSubtacks.toString()} Subtask',
                          style: TextStyle(
                              color: kwhiteColor, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          timeAdded.toString(),
                          style: const TextStyle(
                            color: kwhiteColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
