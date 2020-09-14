import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Test.dart';
import 'package:http/http.dart' as http;
import 'links.dart';

class Listopic extends StatefulWidget {
  @override
  _ListopicState createState() => _ListopicState();
}

class _ListopicState extends State<Listopic> {
  API api = new API();
  var resIQ, resEQ, resMEM, resEYE, topicEQ, topicMEM, topicEYE, getTopic, resTopic;
  var topicIQ  ;
 // var topicIQ = new List<Map<String, dynamic>>();
  String gettoken;
  int userId, cateId, IQ, EQ, MEM, EYE;

  @override
  void initState() {
    super.initState();

    getToken();
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    gettoken = sharedPreferences.getString("token");
    userId = sharedPreferences.getInt("userId");
    IQ = sharedPreferences.getInt("IQ");
    EQ = sharedPreferences.getInt("EQ");
    MEM = sharedPreferences.getInt("MEM");
    EYE = sharedPreferences.getInt("EYE");
    resIQ = await http.get(api.Topic(IQ, userId, gettoken));
    topicIQ = jsonDecode(resIQ.body)["data"];
    sharedPreferences.setInt("level1", topicIQ[0]["id"]);

    resEQ = await http.get(api.Topic(EQ, userId, gettoken));
    topicEQ = jsonDecode(resEQ.body)["data"];
    sharedPreferences.setInt("level2", topicEQ[0]["id"]);

    resMEM = await http.get(api.Topic(MEM, userId, gettoken));
    topicMEM = jsonDecode(resMEM.body)["data"];
    sharedPreferences.setInt("level3", topicMEM[0]["id"]);

    resEYE = await http.get(api.Topic(EYE, userId, gettoken));
    topicEYE = jsonDecode(resEYE.body)["data"];
    sharedPreferences.setInt("level4", topicEYE[0]["id"]);
    setState(() {});
  }

  List<Widget> containers(BuildContext context) {
    return [
      /*IQ*/
      Center(
        child:
        Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /*Ảnh và tên bài test*/
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: topicIQ!= null?
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
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
                                      padding: const EdgeInsets.only(
                                          bottom: 15),
                                      child: Text(
                                        topicIQ[0]["content"],
                                        // "Category",
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
                          ):  CircularProgressIndicator(backgroundColor: Colors.white),
                        ),
                        /*Thông tin bài test*/
                        Container(
                          margin: EdgeInsets.only(
                              top: 20, bottom: 20, left: 20, right: 20),
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new Test(topicTest: topicIQ,)),
                                  ),
                                },
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
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
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
                          child: topicEQ!=null?
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  topicEQ[0]["content"],
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
                          ) : CircularProgressIndicator(backgroundColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  /*Thông tin bài test*/
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 20, left: 20, right: 20),
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
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new Test(topicTest: topicEQ)),
                            ),
                          },
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
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
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
                          child: topicMEM !=null?
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  topicMEM[0]["content"],
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
                          ): CircularProgressIndicator(backgroundColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  /*Thông tin bài test*/
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 20, left: 20, right: 20),
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
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new Test(topicTest: 0,)),
                            ),
                          },
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
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
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
                          child: topicEYE!=null?
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  topicEYE[0]["content"] ,
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
                          ):  CircularProgressIndicator(backgroundColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  /*Thông tin bài test*/
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 20, left: 20, right: 20),
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
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new Test()),
                            ),
                          },
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Home'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                // ListView.builder(
                //     itemCount: topic.length,
                //     itemBuilder: (context, index){
                //       var tabCate = topic[index];
                //       return
                        Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "IQ",
                              // tabCate["Category"],
                              textScaleFactor: 2,
                            ),
                          ],
                        ),
                    //   );
                    // }
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
                        'Mem',
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
                        'Eye',
                        textScaleFactor: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: containers(context),
          ),
        ),
      ),
    );
  }
}

