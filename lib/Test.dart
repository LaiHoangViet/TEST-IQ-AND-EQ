import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Test extends StatelessWidget {
  Widget choosethequestion() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Text(
          'option 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        color: Colors.blueAccent,
        minWidth: 200,
        height: 45.0,
        splashColor: Colors.blueAccent[700],
        highlightColor: Colors.blueAccent[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

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
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: Text(
                      'Con trai và con gái của vua Hùng và vua Thục được gọi là gì?',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        choosethequestion(),
                        choosethequestion(),
                        choosethequestion(),
                        choosethequestion(),
                      ],
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
                          icon: Icon(Icons.chevron_left),
                          color: Colors.white,
                          iconSize: 40,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          color: Colors.white,
                          iconSize: 40,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
