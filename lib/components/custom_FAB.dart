import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../model/subtask_item.dart';
import '../provider/task_provider.dart';
import '../screens/task_screen.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
    required TextEditingController subTaskDescriptionController,
    required TextEditingController subTaskController,
    required this.tasksProvider,
    required this.widget,
  })  : _subTaskDescriptionController = subTaskDescriptionController,
        _subTaskController = subTaskController;

  final TextEditingController _subTaskDescriptionController;
  final TextEditingController _subTaskController;
  final TaskProvider tasksProvider;
  final TaskScreen widget;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        highlightElevation: 50,
        tooltip: 'Add sub task',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: kprimaryColor,
        child: const Icon(
          Icons.add,
          color: ksecondaryColor,
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
                        maxLength: 20,
                        maxLengthEnforcement:  MaxLengthEnforcement.enforced,
                        style: const TextStyle(
                          color: kwhiteColor,
                        ),
                        controller: _subTaskDescriptionController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kwhiteColor),
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(width: 3, color: kprimaryColor)),
                          hintText: 'Add a sub task',
                          hintStyle: TextStyle(
                            color: kwhiteColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: TextField(
                        style: const TextStyle(
                          color: kwhiteColor,
                        ),
                        controller: _subTaskController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kwhiteColor),
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(width: 3, color: kprimaryColor)),
                          hintText: 'Add Description',
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
                            child: const Center(
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
                            child: const Center(
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
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
