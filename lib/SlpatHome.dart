import 'dart:async';
import 'Home.dart';
import 'package:flutter/material.dart';

class SlpatHome extends StatefulWidget {
  @override
  SlpatHomeState createState() => SlpatHomeState();
}

class SlpatHomeState extends State<SlpatHome> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Center(
          child: Text('LET\'S TEST YOUR BRAIN'),
        ),
      ),
    );
  }


}
