import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  List<Widget> containers = [
    Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),

    ),
    Container(
      child: Text('hoang'),
    ),
    Container(
      child: Text('ngoc'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'IQ',
                        textScaleFactor: 2,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'EQ',
                        textScaleFactor: 2,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'IQ',
                        textScaleFactor: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: containers,
          ),
        ),
      ),
    );
  }
}
