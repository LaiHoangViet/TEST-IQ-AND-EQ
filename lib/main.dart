import 'package:flutter/material.dart';
import 'Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test IQ and EQ',
      theme: ThemeData(
        primaryColorDark: Colors.green,
      ),
      home: Splashscreen(),
    );
  }
}
