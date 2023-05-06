import 'package:flutter/material.dart';

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
