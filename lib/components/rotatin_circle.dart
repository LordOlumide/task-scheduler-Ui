import 'package:flutter/material.dart';

import '../constants.dart';

class RotatingCircle extends StatelessWidget {
  const RotatingCircle({
    super.key,
    required this.circleAnimation,
  });

  final Animation<double> circleAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: circleAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: circleAnimation.value,
          child: GestureDetector(
            
            child: Container(
              height: 300,
              width: 300,
              // height: SizeConfig.screenHeight * 0.5,
              // width: SizeConfig.screenWidth * 0.9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ktertiaryColor,
                  width: 30,
                ),
                borderRadius: BorderRadius.circular(100),
                // shape: BoxShape.rectangle,
                color: ksecondaryColor,
              ),
              child: Container(
                height: 100,
          
                // height: SizeConfig.screenHeight * 0.3,
                // width: SizeConfig.screenWidth * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kwhiteColor,
                    width: 10,
                  ),
                  shape: BoxShape.circle,
                  color: ksecondaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
