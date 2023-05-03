import 'package:flutter/material.dart';
import 'dart:math' as math;

class TaskHeading extends StatelessWidget {
  
  
  const TaskHeading({
    super.key,
    required this.leadingTextColor, required this.traillingIconColor,
  });

    final Color leadingTextColor;
    final Color traillingIconColor;
    
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(
          'Priority tasks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: leadingTextColor,
          ),
        ),
        trailing: Transform.rotate(
            angle: 180 * math.pi / 120,
            child: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.tune,
                color: traillingIconColor,
              ),
            )));
  }
}
