import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class BarContainer extends StatelessWidget {
  final List<Widget> children;
  final Color BarContainerColor;
  BarContainer({
    super.key,
    required this.children, required this.BarContainerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: SizeConfig.screenHeight * 0.25,
        // width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: BarContainerColor, borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
