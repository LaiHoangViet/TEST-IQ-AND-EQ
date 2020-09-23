import 'package:flutter/material.dart';
import 'Home.dart';
import 'ListTopic.dart';

class Score extends StatefulWidget {
  int count;
  int k;
  int timeCount;

  Score({Key key, @required this.count,   @required this.k, @required this.timeCount}) : super(key: key);

  @override
  _ScoreState createState() => _ScoreState(count, k, timeCount);
}

class _ScoreState extends State<Score> {
  int count;
  int k;
  int timeCount;

  _ScoreState( this.count, this.k,  this.timeCount);

  Future<bool> _onWillPop() async {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Listopic()),);
    // await showDialog or Show add banners or whatever
    // then
    return Future.value(true); // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
      onWillPop: () => _onWillPop(),
        child:
        MaterialApp(
          title: '',
          home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Ranking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 200.0,
                      height: 30.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Thời Gian: $timeCount s",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "SCORE",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "$count/ $k ĐIỂM",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child:FlatButton(
                        padding: EdgeInsets.all(8.0),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          ),
                        },
                        child: Icon(Icons.home,
                          size: 40,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}


