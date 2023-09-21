import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_gpt/services/open_ai_services.dart';

import '../widgets/body.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final OpenAIService openAIService = OpenAIService();
  final speechToText = SpeechToText(); //input through device microphone
  final FlutterTts flutterTts = FlutterTts();
  String lastWords = "";
  String generatedContent = "";
  String generatedImageUrl = "";
  bool isListen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  //method for generating text from speech through microphone
  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  //method to  generate speech through text after getting text result from api
  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  //system speak method
  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  Future<void> systemStopSpeaking() async {
    await flutterTts.pause();
  }

//method to listening while 1st tap on mic
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  /// method to stop listening
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  Future<void>? onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      lastWords = result.recognizedWords;
    });
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Voice GPT"),
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ),
        body: 
          
            SingleChildScrollView(
                child: BodyContent(
              generatedContent: generatedContent,
              generatedImageUrl: generatedImageUrl,
            )),
            
        

        floatingActionButton:
      FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              systemStopSpeaking();
              startListening();
              print("listening");
            } else if (speechToText.isListening) {
              Future.delayed(Duration(seconds: 2));
              stopListening();
              print(lastWords);
              final speech = await openAIService.isArtPromptApi(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = "";
                setState(() {});
              } else {
                generatedContent = speech;
                generatedImageUrl = "";
                setState(() {});
                await systemSpeak(speech);
              }

              print(speech);
              // print("stop");
              // print(lastWords);
            } else {
              //if we don't have permission
              initSpeechToText();
              print("allow permission");
            }
          },
          child: const Icon(Icons.mic)),

          
        );
  }
}
