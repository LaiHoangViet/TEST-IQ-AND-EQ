import 'dart:convert';

import 'package:demo1/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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
  var res,
      ans,
      question,
      resTopic1,
      // resTopic2,
      // resTopic3,
      // resTopic4,
      test1,
      test2,
      test3,
      test4;
  int count = 0;
  int k = 0;
  String getToken;
  int userId, topic1, topicId;
  bool disableAnswer = false;
  Color right = Colors.green;
  Color wrong = Colors.red;
  Color btnToShow = Colors.indigoAccent;
  var answer = List();


  quesTest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getToken = sharedPreferences.getString("token");
    userId = sharedPreferences.getInt("userId");
    // topic1 = sharedPreferences.getInt("level1");
    // topic2 = sharedPreferences.getInt("level2");
    // topic3 = sharedPreferences.getInt("level3");
    // topic4 = sharedPreferences.getInt("level4");
    /*===============================================*/
    topicId = topicTest[0]["id"];

    //Đổi link topic test thành link với link cate cho truoc và thêm 1 biến mới.
    //Lấy giá trị biến mới theo if else tab
    resTopic1 = await http.get(api.topicTest(topicId, userId, getToken));
    test1 = jsonDecode(resTopic1.body)["data"];

    // resTopic2 = await http.get(api.topicTest(topic2, userId, getToken));
    // test2 = jsonDecode(resTopic2.body)["data"];
    //
    // resTopic3 = await http.get(api.topicTest(topic3, userId, getToken));
    // test3 = jsonDecode(resTopic3.body)["data"];
    //
    // resTopic4 = await http.get(api.topicTest(topic4, userId, getToken));
    // test4 = jsonDecode(resTopic4.body)["data"];
    print(topicId);
    setState(() {});
  }

  void checkanswer(int index) {
    if (test1[k]["answer"][index]["success"] == 1) {
      btnToShow = right;
      count++;
    } else {
      btnToShow = wrong;
      count;
    }

    setState(() {
      btncolor[index] = btnToShow;
      disableAnswer = true;
      answer.insert(k, test1[k]["answer"][index]["answer"]);
    });
  }

  @override
  void initState() {
    quesTest();
    super.initState();
  }

  Map<int, Color> btncolor = {
    0: Colors.indigoAccent,
    1: Colors.indigoAccent,
    2: Colors.indigoAccent,
    3: Colors.indigoAccent,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: Material(
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
            child: test1 != null
                ? Column(
                    children: <Widget>[
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
                        child: AbsorbPointer(
                          absorbing: disableAnswer,
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
                                                checkanswer(index);
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
                              IconButton(
                                icon: Icon(Icons.chevron_right),
                                color: Colors.white,
                                iconSize: 40,
                                onPressed: () {
                                  setState(() {
                                    if (k < test1.length - 1) {
                                      k++;
                                      test1[k];
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Score(count: count, k: test1.length )),
                                      );
                                    }
                                    btncolor[0] = Colors.indigoAccent;
                                    btncolor[1] = Colors.indigoAccent;
                                    btncolor[2] = Colors.indigoAccent;
                                    btncolor[3] = Colors.indigoAccent;
                                    disableAnswer = false;
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
    );
  }
}
