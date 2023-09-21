import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class ContentBox extends StatelessWidget {
  ContentBox({
    super.key,
    required this.generatedContent,
    required this.generatedImageUrl,
  });
  String generatedContent = "";
  String generatedImageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: generatedContent == "" ? 20 : 10, vertical: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: const BorderRadius.all(Radius.circular(20))
              .copyWith(topLeft: Radius.zero)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          generatedContent == ""
              ? "Hi Kumod, What Task Can I Do For You ?"
              : generatedContent,
          style: TextStyle(
              fontSize: generatedContent == "" ? 25 : 18,
              fontFamily: "Cera Pro",
              color: AppColors.mainFontColor),
        ),
      ),
    );
  }
}
