import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class AssistantProfile extends StatelessWidget {
  const AssistantProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 160,
            width: 160,
            decoration: const BoxDecoration(
                color: AppColors.assistantCircleColor, shape: BoxShape.circle),
          ),
          Container(
            height: 170,
            width: 170,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                  "assets/images/virtualAssistant.png",
                ))),
          ),
        ],
      ),
    );
  }
}
