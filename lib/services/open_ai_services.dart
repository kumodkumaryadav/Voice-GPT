import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voice_gpt/secrets/secrets.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];
  isArtPromptApi(String prompt) async {
    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Secrets.apiKeyChatGPT}'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Does this message want to generate AI picture,image, art or anything similar ? $prompt.  Simply answer with a yes or no."
              }
            ],
          }));

      print(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]["message"]["content"];
        content = content.trim();

        if (content == "Yes." ||
            content == "Yes" ||
            content == "yes." ||
            content == "yes" ||
            content == "YES") {
          return await dallEAPI(prompt);
        } else {
          return await chatGPTAPI(prompt);
        }
      }
      ;
    } catch (e) {
      return (e.toString());
    }
  }
//chatpgt api method

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Secrets.apiKeyChatGPT}',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      } else {
        return 'An internal error occurred';
      }
    } catch (e) {
      return e.toString();
    }
  }

  //Dall-E Method

  dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Secrets.apiKeyChatGPT}',
        },
        body: jsonEncode({"promt": prompt, "n": 1}),
      );

      if (res.statusCode == 200) {
        String imageString = jsonDecode(res.body)['data'][0]['url'];
        imageString = imageString.trim();

        messages.add({
          'role': 'assistant',
          'content': imageString,
        });
        return imageString;
      } else {
        return 'An internal error occurred';
      }
    } catch (e) {
      return e.toString();
    }
  }

//Dall-E api method
}
