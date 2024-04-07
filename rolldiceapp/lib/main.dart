import 'package:flutter/material.dart';

import 'package:rolldiceapp/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer([Colors.blue, Colors.red, Colors.blue]),
      ),
    ),
  );
}
