import 'package:flutter/material.dart';
import 'ListTopic.dart';

class Score extends StatefulWidget {
  int count, k;

  Score({Key key, @required this.count, @required this.k}) : super(key: key);

  @override
  _ScoreState createState() => _ScoreState(count, k);
}

class _ScoreState extends State<Score> {
  var count;
  var k;

  _ScoreState(this.count, this.k);

  Future<bool> _onWillPop() async {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Listopic()),);
    // await showDialog or Show add banners or whatever
    // then
    return Future.value(true); // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
        child:MaterialApp(
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
                    Expanded(
                      flex: 5,
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}


