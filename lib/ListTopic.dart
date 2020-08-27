import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Listopic extends StatelessWidget {
  List<Widget> containers = [
    /*IQ*/
    Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                /*Ảnh và tên bài test*/
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          'images/anh1.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                'Lại Hoàng Việt',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '100 - ***',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /*Thông tin bài test*/
                Container(
                  margin:
                      EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Text(
                    'Thông tin bài test. '
                    'Chúc bạn làm bài đạt điểm số cao nhất',
                    textAlign: TextAlign.center,
                  ),
                ),
                /*Nút test và nút rank*/
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.blue,
                        child: Text('Test'),
                        textColor: Colors.white,
                        highlightElevation: 4.0,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.blue,
                        child: Text('Rank'),
                        textColor: Colors.white,
                        highlightElevation: 4.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                /*Ảnh và tên bài test*/
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          'images/anh1.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                'Lại Hoàng Việt',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '100 - ***',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /*Thông tin bài test*/
                Container(
                  margin:
                  EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Text(
                    'Thông tin bài test. '
                        'Chúc bạn làm bài đạt điểm số cao nhất',
                    textAlign: TextAlign.center,
                  ),
                ),
                /*Nút test và nút rank*/
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.blue,
                        child: Text('Test'),
                        textColor: Colors.white,
                        highlightElevation: 4.0,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.blue,
                        child: Text('Rank'),
                        textColor: Colors.white,
                        highlightElevation: 4.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
