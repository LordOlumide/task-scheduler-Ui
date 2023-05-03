import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class TaskCard extends StatelessWidget {
  final String taskName;
  final Color cardcolor;

  const TaskCard({
    super.key,
    required this.taskName,
    required this.cardcolor,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0, top: 8, right: 8,),
      child: Container(
        height: 120,
        width: SizeConfig.screenWidth * 0.85,
        decoration: BoxDecoration(
            color: cardcolor, borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
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
                  const Text(
                    '15 subtask',
                    style: TextStyle(
                        color: kwhiteColor, fontWeight: FontWeight.w400),
                  ),
                  const Text(
                    '15,12,22',
                    style: TextStyle(
                      color: kwhiteColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}