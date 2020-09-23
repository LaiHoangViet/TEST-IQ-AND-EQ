import 'dart:async';

import 'package:demo1/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ListTopic.dart';
import 'Score.dart';

class ImageQuiz extends StatefulWidget {
  @override
  _ImageQuizState createState() => _ImageQuizState();
}

class _ImageQuizState extends State<ImageQuiz> {
  Timer _timer;
  int _counter = 270;
  int countTime;
  int k=0;
  var clientAns;
  bool disableAnswer = false;


  void _startTimer() {
    _counter = 270;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
          countTime = 10 - _counter;
        });
      } else {
        _timer.cancel();
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Notice'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('TIME OVER'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Submit'),
                  onPressed: () {},
                ),
              ],
            );
          },
        );
      }
    });
  }

  void chooseAnswer(int index) {
    setState(() {
      clientAns[k][0] = index ;
      disableAnswer = true;
    });
  }

  void submit(){

    // _timer.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Score(
            count: k+1,
            k: urls.length,
            timeCount: countTime,
          )
      ),
    );
  }


  void initState() {
    setState(() {
      // _startTimer();
      clientAns = List.generate(6, (i) => List(1), growable: false);
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Listopic()),
    );
    return Future.value(true); // return true if the route to be popped
  }



  List<String> urls = <String>[
    "https://testiq.vn//Images/Q1.png",
    "https://testiq.vn//Images/Q2.png",
    "https://testiq.vn//Images/Q3.png",
    "https://testiq.vn//Images/Q4.png",
    "https://testiq.vn//Images/Q5.png",
    "https://testiq.vn//Images/Q6.png",
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text('Test'),
          ),
          body: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Câu: ${k+1}/${urls.length}',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        '$_counter',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: SizeConfig.blockSizeHorizontal + 30,
                            top: SizeConfig.blockSizeVertical - 250,
                            child: Column(
                              children: [
                                Text(
                                  "QUESTION",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Image.network(urls[k]),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Expanded(
                    flex: 3,
                    child: GridView.count(
                      padding: const EdgeInsets.only(right: 10),
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 1.25,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Stack(
                            children: [
                              Positioned(
                                top: SizeConfig.blockSizeVertical ,
                                left: SizeConfig.blockSizeHorizontal + 10,
                                child: GestureDetector(
                                  onTap: () => chooseAnswer(1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0)
                                    ),
                                    // width: SizeConfig.blockSizeHorizontal * 90,
                                    // height: SizeConfig.blockSizeVertical * 90,
                                    child: Image.network(urls[k]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),

                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Stack(
                            children: [
                              Positioned(
                                top: SizeConfig.blockSizeVertical,
                                left: SizeConfig.blockSizeHorizontal - 110,
                                child: GestureDetector(
                                  onTap: () => chooseAnswer(2),
                                  child: Container(
                                    // width: SizeConfig.blockSizeHorizontal * 90,
                                    // height: SizeConfig.blockSizeVertical * 90,
                                    child: Image.network(urls[k]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Stack(
                            children: [
                              Positioned(
                                top: SizeConfig.blockSizeVertical,
                                left: SizeConfig.blockSizeHorizontal -210,
                                child: GestureDetector(
                                  onTap: () => chooseAnswer(3),
                                  child: Container(
                                    // width: SizeConfig.blockSizeHorizontal * 90,
                                    // height: SizeConfig.blockSizeVertical * 90,
                                    child: Image.network(urls[k]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Stack(
                            children: [
                              Positioned(
                                top: SizeConfig.blockSizeVertical -100,
                                left: SizeConfig.blockSizeHorizontal + 10,
                                child: GestureDetector(
                                  onTap: () => chooseAnswer(4),
                                  child: Container(
                                    // width: SizeConfig.blockSizeHorizontal * 90,
                                    // height: SizeConfig.blockSizeVertical * 90,
                                    child: Image.network(urls[k]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Stack(
                            children: [
                              Positioned(
                                top: SizeConfig.blockSizeVertical -100,
                                left: SizeConfig.blockSizeHorizontal -104,
                                child: GestureDetector(
                                  onTap: () => chooseAnswer(5),
                                  child: Container(
                                    // width: SizeConfig.blockSizeHorizontal * 90,
                                    // height: SizeConfig.blockSizeVertical * 90,
                                    child: Image.network(urls[k]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Stack(
                            children: [
                              Positioned(
                                top: SizeConfig.blockSizeVertical -100,
                                left: SizeConfig.blockSizeHorizontal -215,
                                child: GestureDetector(
                                  onTap: () => chooseAnswer(6),
                                  child: Container(
                                    // width: SizeConfig.blockSizeHorizontal * 90,
                                    // height: SizeConfig.blockSizeVertical * 90,
                                    child: Image.network(urls[k]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 0,
                    child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            k>0? IconButton(
                                icon: Icon(Icons.chevron_left),
                                color: Colors.white,
                                iconSize: 40,
                                onPressed: () {
                                  setState(() {
                                      k--;
                                      urls[k];
                                  });
                                }
                              ):Container(),
                            k<urls.length - 1 ? IconButton(
                                icon: Icon(Icons.chevron_right),
                                color: Colors.white,
                                iconSize: 40,
                                onPressed: () {
                                  setState(() {
                                    k++;
                                    urls[k];
                                  });
                                }
                              ):FlatButton(
                              textColor: Colors.lightBlue,
                              child: Text("Submit",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  submit();
                                  disableAnswer = false;
                                });
                              },
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
