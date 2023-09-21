import 'package:flutter/material.dart';
import 'package:voice_gpt/constants/color_constant.dart';

import 'assistant_profile.dart';
import 'content_box.dart';
import 'features_heading.dart';

class BodyContent extends StatelessWidget {
  const BodyContent(
      {super.key,
      required this.generatedContent,
      required this.generatedImageUrl});
  final String generatedContent;
  final String generatedImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AssistantProfile(),
        ContentBox(
          generatedContent: generatedContent,
          generatedImageUrl: generatedImageUrl,
        ),
        FeaturesHeading(),
        ModelCard(
          color: AppColors.firstSuggestionBoxColor,
          title: "ChatGPT",
          description:
              "A smarter way to stay organized and informed with ChatGPT",
        ),
        ModelCard(
          color: AppColors.secondSuggestionBoxColor,
          title: "Dall-E",
          description:
              "Get inspired and stay creative with your personal assistant power by Dall-E",
        ),
        ModelCard(
          color: AppColors.thirdSuggestionBoxColor,
          title: "Smart Voice Assistant",
          description:
              "Get the best of both worlds with a voice assistant power  by Dall-E and ChatGPT",
        ),
      ],
    );
  }
}

class ModelCard extends StatelessWidget {
  const ModelCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: AppColors.mainFontColor,
                  fontSize: 20,
                  fontFamily: "Cera Pro",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 16, fontFamily: "Cera Pro"),
            )
          ],
        ),
      ),
    );
  }
}
