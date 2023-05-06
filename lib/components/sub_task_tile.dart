
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constants.dart';
import '../size_config.dart';

class SubTaskCard extends StatelessWidget {
  SubTaskCard({
    super.key,
    required this.subTaskName,
    required this.subTaskDetails,
    required this.taskCompleted,
    required this.ontap,
    required this.deleteFunction, 
    // required this.saveSubTask,
  });

  final String subTaskName;
  final String subTaskDetails;
  bool taskCompleted = false;
  final Function() ontap;
  Function(BuildContext)? deleteFunction;
  // final Function() saveSubTask;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
          onTap: null,
          child: Container(
            height: 120,
            width: SizeConfig.screenWidth * 0.85,
            decoration: BoxDecoration(
                color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: ontap ,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: taskCompleted
                                  ? ktertiaryColor
                                  : Colors.grey[400]),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  size: 15.0,
                                  color: taskCompleted
                                      ? Colors.white
                                      : Colors.grey[400],
                                ),
                              )),
                        ),
                      ),
                      //    Icon(
                      //    Icons.check_circle_rounded,
                      //   color: ktertiaryColor,
                      // ),
                      kbigSizedbox,
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          subTaskName,
                          style: const TextStyle(
                              color: ksecondaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 51.0),
                  child: Text(
                    subTaskDetails,
                    style:  TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
