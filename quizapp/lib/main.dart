import 'package:flutter/material.dart';
import 'package:quizapp/start_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue, 
                Colors.red, 
                Colors.blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
            ),
          ),
          child: const StartScreen(),
        ),
      ),
    ),
  );
}
