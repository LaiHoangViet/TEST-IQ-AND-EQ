import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'ListTopic.dart';
import 'Score.dart';
import 'links.dart';

class Test extends StatefulWidget {
  var topicTest;

  Test({Key key, @required this.topicTest}) : super(key: key);

  @override
  _TestState createState() => _TestState(topicTest);
}

class _TestState extends State<Test> {
  API api = new API();

  var topicTest;

  _TestState(this.topicTest);

  var res, ans, question, resTopic, test1, test2, test3, test4;
  int count=0;
  int k = 0, t = 0;
  String getToken;
  int userId, topic1, topicId;
  bool disableAnswer = false;
  Color btnToShow = Colors.yellow;
  var answer = List();
  bool showButton = false;
  var tList, tIndex, tAnswer;
  int countQues, countTime;

  @override
  void initState() {
    quesTest();

    setState(() {
      _startTimer();
    });
    super.initState();
  }

  quesTest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getToken = sharedPreferences.getString("token");
    userId = sharedPreferences.getInt("userId");
    topicId = topicTest[0]["id"];
    resTopic = await http.get(api.topicTest(topicId, userId, getToken));
    test1 = jsonDecode(resTopic.body)["data"];
    countQues = test1.length;
    setState(() {
      tList = List.generate(test1.length, (i) => List(1), growable: false);
      tIndex = List.generate(test1.length, (i) => List(1), growable: false);
      tAnswer = List.generate(test1.length, (i) => List(1), growable: false);
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Listopic()),

    );
    return Future.value(true); // return true if the route to be popped
  }

  int _counter;
  Timer _timer;

  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_counter > 0){
        setState(() {
          _counter--;
          countTime = 30 - _counter;
        });
      }else{
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

  void setAnswer(int index) {
    setState(() {
      for(int i=0; i<4; i++){
        btncolor[i] = btnColorReset[i];
      }
      tList[k][0] = test1[k]["answer"][index]["answer"];
      tIndex[k][0] = index;
      // print(tIndex);
      btncolor[index] = btnToShow;
      disableAnswer = true;
    });
  }
  void checkAnswer(){
    for(t=0; t<test1.length; t++){
      for(int index =0; index < test1[t]["answer"].length; index++)
        if(test1[t]["answer"][index]["success"]==1){
          tAnswer[t][0] = test1[t]["answer"][index]["answer"];
        }
    }
  }
  void submit(){
    checkAnswer();
    for(t=0; t<test1.length; t++){
      if(tList[t][0] == tAnswer[t][0]){
        count++;
      }
    }
    _timer.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Score(
            count: count,
            k: test1.length,
            timeCount: countTime,
          )
      ),
    );
  }

  Map<int, Color> btncolor = {
    0: Colors.indigoAccent,
    1: Colors.indigoAccent,
    2: Colors.indigoAccent,
    3: Colors.indigoAccent,
  };
  Map<int, Color> btnColorReset = {
    0: Colors.indigoAccent,
    1: Colors.indigoAccent,
    2: Colors.indigoAccent,
    3: Colors.indigoAccent,
  };
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: MaterialApp(
        title: '',
        home: Material(
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
              child: test1 != null
                  ? Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Câu: ${k+1}/$countQues',
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
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: Text(
                              test1[k]["question"],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          // child: AbsorbPointer(
                          //   absorbing: disableAnswer,
                          child: Container(
                            child: ListView.builder(
                                itemCount: test1[k]["answer"].length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 20,
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                showButton = true;
                                                setAnswer(index);
                                                // print(answer);
                                              });
                                            },
                                            child: Text(
                                              test1[k]["answer"][index]
                                                  ["answer"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            color: btncolor[index],
                                            minWidth: 200,
                                            height: 45.0,
                                            splashColor: Colors.blueAccent[700],
                                            highlightColor:
                                                Colors.blueAccent[700],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          )),
                                    ],
                                  );
                                }),
                          ),
                          // ),
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
                                k > 0
                                    ? IconButton(
                                        icon: Icon(Icons.chevron_left),
                                        color: Colors.white,
                                        iconSize: 40,
                                        onPressed: () {
                                          setState(() {
                                            btncolor = {
                                              0: Colors.indigoAccent,
                                              1: Colors.indigoAccent,
                                              2: Colors.indigoAccent,
                                              3: Colors.indigoAccent,
                                            };
                                            // tList[k][0] = test1[k]["answer"][index]["answer"];
                                            // tIndex[k][0]= index;

                                            // disableAnswer = true;
                                              k--;
                                              btncolor[tIndex[k][0]] = btnToShow;
                                              test1[k];
                                            disableAnswer = false;
                                            showButton = false;
                                          });
                                        },
                                      )
                                    : Container(),
                                //If else submit
                                k < test1.length - 1
                                    ? IconButton(
                                  icon: Icon(Icons.chevron_right),
                                  color: Colors.white,
                                  iconSize: 40,
                                  onPressed: () {
                                    setState(() {
                                      for(int i=0; i<4; i++){
                                        btncolor[i] = btnColorReset[i];
                                      }
                                      k++;
                                      btncolor[tIndex[k][0]] = btnToShow;
                                      test1[k];
                                      disableAnswer = false;
                                      showButton = false;
                                    });
                                  },
                                )
                                    :FlatButton(
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
                                      showButton = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      // ignore: missing_return
                    )
                  : CircularProgressIndicator(backgroundColor: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

}
