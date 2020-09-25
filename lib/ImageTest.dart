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
  int k = 0;
  var clientAns, serverAns, stateSet;
  bool disableAnswer = false;

  Map<String, dynamic> images = {
    "Data": [
      {
        "id": 1,
        "Ques": "images/Ques1.png",
        "Ans": [
          {
            "id": 1,
            "Answer": "images/Ans1.png",
            "success": 0,
          },
          {
            "id": 2,
            "Answer": "images/Ans2.png",
            "success": 0,
          },
          {
            "id": 3,
            "Answer": "images/Ans3.png",
            "success": 0,
          },
          {
            "id": 4,
            "Answer": "images/Ans4.png",
            "success": 0,
          },
          {
            "id": 5,
            "Answer": "images/Ans5.png",
            "success": 0,
          },
          {
            "id": 6,
            "Answer": "images/Ans6.png",
            "success": 1,
          },
        ]
      },
      {
        "id": 1,
        "Ques": "images/crown.png",
        "Ans": [
          {
            "id": 1,
            "Answer": "images/Ans1.png",
            "success": 0,
          },
          {
            "id": 2,
            "Answer": "images/Ans2.png",
            "success": 0,
          },
          {
            "id": 3,
            "Answer": "images/Ans3.png",
            "success": 0,
          },
          {
            "id": 4,
            "Answer": "images/Ans4.png",
            "success": 0,
          },
          {
            "id": 5,
            "Answer": "images/Ans5.png",
            "success": 0,
          },
          {
            "id": 6,
            "Answer": "images/Ans6.png",
            "success": 1,
          },
        ]
      },
      {
        "id": 1,
        "Ques": "images/Ques1.png",
        "Ans": [
          {
            "id": 1,
            "Answer": "images/Ans1.png",
            "success": 0,
          },
          {
            "id": 2,
            "Answer": "images/Ans2.png",
            "success": 0,
          },
          {
            "id": 3,
            "Answer": "images/Ans3.png",
            "success": 0,
          },
          {
            "id": 4,
            "Answer": "images/Ans4.png",
            "success": 0,
          },
          {
            "id": 5,
            "Answer": "images/Ans5.png",
            "success": 0,
          },
          {
            "id": 6,
            "Answer": "images/Ans6.png",
            "success": 1,
          },
        ]
      },
    ]
  };


  void initState() {
    setState(() {
      _startTimer();
      clientAns = List.generate(images["Data"].length, (i) => List(1), growable: false);
      serverAns = List.generate(images["Data"].length, (i) => List(1), growable: false);
      stateSet = List.generate(images["Data"].length, (i) => List(1), growable: false);

    });
    super.initState();
  }

  void _startTimer() {
    _counter = 10;
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
                  onPressed: () {
                    submit();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.red,
        width: 5.0,
      ),
    );
  }

  var state;

  void chooseAnswer(int index) {
    setState(() {
      state = index;
      stateSet[k][0] = index;
      print(stateSet);
      clientAns[k][0]=images["Data"][k]["Ans"][index]["Answer"];
      print(clientAns[k][0]);
    });
  }
  void checkAnswer(){
    for(int t=0; t<images["Data"].length; t++){
      for(int index =0; index < images["Data"][t]["Ans"].length; index++)
        if(images["Data"][t]["Ans"][index]["success"]==1){
          serverAns[t][0] = images["Data"][t]["Ans"][index]["Answer"];
          print(serverAns[t][0]);
        }
    }
  }

  void submit() {
    int count=0;
    checkAnswer();
    for(int t=0; t<images["Data"].length; t++){
      if(clientAns[t][0] == serverAns[t][0]){
        count++;
      }
    }
    _timer.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Score(
            count: count,
            k: images["Data"].length,
            timeCount: countTime,
          )
      ),
    );
  }



  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Listopic()),
    );
    return Future.value(true); // return true if the route to be popped
  }




  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(_timer.cancel()),
          ),
          centerTitle: true,
          title: Text('Test'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Câu: 1/10",
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
              ),
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          margin: EdgeInsets.all(10),
                          child: Image.asset(
                            images["Data"][k]["Ques"],
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                          )),
                    ),
                    Expanded(
                      flex: 4,
                      child: GridView.count(
                        padding: const EdgeInsets.all(20),
                        crossAxisCount: 3,
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                        childAspectRatio: 1.25,
                        children:List.generate(images["Data"][k]["Ans"].length, (index) {
                          return GestureDetector(
                            onTap: () => chooseAnswer(index),
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 100,
                              height: SizeConfig.blockSizeVertical * 100,
                              decoration: state == index
                                  ? myBoxDecoration()
                                  : BoxDecoration(
                                border: Border.all(width: 0),
                              ),
                              child: Image.asset(
                                images["Data"][k]["Ans"][index]["Answer"],
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight,
                              ),
                            ),
                          );
                        })
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      k > 0 ? IconButton(
                        icon: Icon(Icons.chevron_left),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          setState(() {
                            k--;
                            state = stateSet[k][0];
                            images["Data"][k];
                          });
                        },
                      ):Container(),
                      k < images["Data"].length -1 ? IconButton(
                        icon: Icon(Icons.chevron_right),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {

                          setState(() {
                            k++;
                            images["Data"][k];
                            state =-1;
                          });
                        },
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
