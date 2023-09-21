
import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class FeaturesHeading extends StatelessWidget {
  const FeaturesHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        "Try These Features",
        style: TextStyle(
            fontSize: 20,
            fontFamily: "Cera Pro",
            color: AppColors.mainFontColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
