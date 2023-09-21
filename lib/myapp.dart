import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:voice_gpt/constants/color_constant.dart';
import 'package:voice_gpt/screens/main_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: AppColors.whiteColor,
          appBarTheme:
              const AppBarTheme(backgroundColor: AppColors.whiteColor)),
      title: "voiceGPT",
      initialRoute: "/",
      routes: {"/": (context) => const MainPage()},
    );
  }
}
