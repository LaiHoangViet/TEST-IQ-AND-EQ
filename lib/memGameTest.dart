import 'package:flutter/material.dart';


import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/rendering.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Game demo'),
        ),
        body: Contentgame(),
      ),
    );
  }
}

class Contentgame extends StatefulWidget {
  @override
  Contentgamestateful createState() => new Contentgamestateful();
}

class Contentgamestateful extends State<Contentgame> {
  var specialColor,
      numbers,
      numbers1,
      arr,
      selected,
      colors1,
      colors2,
      selectedred;
  List<int> number1;

  @override
  // khởi tạo giá trị đầu biến
  void initState() {
    // TODO: implement initState
    super.initState();
    colors1 = Colors.red;
    colors2 = Colors.green;

    // Mảng chứa khối đỏ
    selected = [];

    // Mảng số ô
    numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    number1 = new List(8);
    // Biến dùng để tạo ô đỏ
    arr = numbers;

    // Vòng for để lấy 3 ô đỏ
    for (var i = 0; i < 3; i++) {
      // 9
      var num = arr[(new Random()).nextInt(arr.length)]; // random ra 0->8
      // i sẽ chạy từ 0 đến 8 rồi lấy 1 số ngẫu nhiên
      // add vào selected rồi remove số đó ở vòng lặp tiếp theo
      // cho đủ 3 lần thì kết thúc
      selected.add(num);
      arr.remove(num);
    }
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        // selected= [];
        colors1 = Colors.green;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                // scrollDirection: Axis.horizontal,
                children: numbers.map<Widget>((i) {
                  var currColor = Colors.red;
                  return (Animator(
                    resetAnimationOnRebuild: true,
                    duration: Duration(seconds: 1),
                    tween: Tween<double>(begin: 0, end: pi),
                    repeats: 1,
                    // anim là Animator thêm _, ,__ thì nó sẽ không quan tâm là cái gì nữa
                    builder: (_, anim, __) => Transform(
                      transform: Matrix4.rotationY(anim.value),
                      alignment: Alignment.center,
                      child: (RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Animator(
                          resetAnimationOnRebuild: true,
                          duration: Duration(seconds: 1),
                          tween: Tween<double>(begin: 0, end: pi),
                          builder: (_, anim, __) => Transform(
                            transform: Matrix4.rotationY(anim.value),
                            alignment: Alignment.center,
                          ),
                        ),
                        color: selected.contains(i) ? colors1 : colors2,
                        onPressed: () {
                          if (selected.contains(i)) {
                            currColor = Colors.red;
                          }
                        },
                      )),
                    ),
                  ));
                }).toList()),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                selected = [];
              });
              selected = [];
              numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
              arr = numbers;
              for (var i = 0; i < 3; i++) {
                var num = arr[(new Random()).nextInt(arr.length)];
                selected.add(num);
                arr.remove(num);
              }
              print(selected);

              // This is the trick
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(pageBuilder: (_, __, ___) => Myapp()
                  // transitionDuration: Duration.zero,
                ),
              );
            },
            color: Colors.blue,
            child: Text('Test'),
            textColor: Colors.white,
            highlightElevation: 4.0,
          ),
        ],
      ),
    );
  }
}
