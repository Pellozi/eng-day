import 'package:eng_day/chat/chat_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatIaApp());
}

class ChatIaApp extends StatelessWidget {
  const ChatIaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatPage(),
    );
  }
}

