import 'dart:async';
import 'dart:math';

import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'ListTopic.dart';

setText(text, size, color) => Text(text,
    style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none));

pad(double left, double top) => EdgeInsets.fromLTRB(left, top, 0, 0);

class MemGame extends StatelessWidget {
  final Store<MemAppState> storeMemGame;

  MemGame(this.storeMemGame);

  bool restart = false;

  //Tạo bảng mới
  _createBoard(
      double size, List<List<int>> blocks, int click, MaterialColor color) {
    if (storeMemGame.state.rsCnt) storeMemGame.dispatch(Action.countFalse);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: blocks
            .map((cols) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: cols.map(
                  (item) {
                    // print("item in create borad: " + item.toString());
                    // AnimationController anim ;
                    return Flexible(
                        child: new Pieces(
                            item: item,
                            size: size,
                            store: storeMemGame,
                            isFlip: item == 1));
                  },
                ).toList()))
            .toList());
  }

  @override
  Widget build(BuildContext context) =>
      StoreConnector<MemAppState, MemAppState>(
          // onInit: (state) => ShakeDetector.autoStart(
          //     onPhoneShake: () => store.dispatch(Action.shake)),
          converter: (store) => store.state,
          builder: (context, state) {
            var w = MediaQuery.of(context).size.height / 16 * 7,
                size = w / (state.board.length + 1),
                click = 0,
                colors = Colors.blue;

            return Scaffold(
                appBar: AppBar(
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Listopic()),
                    ),
                  ),
                  title: Text('Memory Game'),
                  centerTitle: true,
                ),
                backgroundColor: Color(0xFFBCE1F6),
                body: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height / 16 * 9,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: state.page >= 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    Container(
                                      height: w * 0.355,
                                      // padding: pad(2, w * 0.15),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              'Score',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                          setText(state.score.toString(),
                                              w * 0.2, Colors.black),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //     // height: w * 0.60,
                                    //     // padding: pad(w * 0.74, state.page * 6.0),
                                    //     child: state.page < 1
                                    //         ? Timer(
                                    //             onEnd: () => storeMemGame
                                    //                 .dispatch(Action.end),
                                    //             width: w,
                                    //             rsCnt: state.rsCnt)
                                    //         : setText(
                                    //             'End', w * 0.08, Colors.red[500])),
                                    state.page < 1
                                        ? Flexible(
                                            child: Container(
                                                width: w + 50,
                                                height: w * 1.05,
                                                padding:
                                                    pad(w * 0.005, w * 0.1),
                                                child: _createBoard(
                                                    size,
                                                    state.board,
                                                    click,
                                                    colors)),
                                          )
                                        : Container(),
                                    // : Container(
                                    //     width: w,
                                    //     height: w,
                                    //     decoration:
                                    //         setBg(_grade(state.score) + '.png'))
                                  ])
                            : Container()),
                  ),
                ),
                floatingActionButton: state.page != 0
                    ? Container(
                        // width: w * 0.2,
                        // height: w * 0.2,
                        child: FloatingActionButton(
                          child: Icon(state.page < 1
                              ? Icons.play_arrow
                              : Icons.refresh),
                          onPressed: () {
                            storeMemGame.dispatch(Action.start);
                          },
                        ),
                      )
                    : Container());
          });
}

/* ============================================================= */

class Pieces extends StatefulWidget {
  final int item;
  final double size;
  final Store<MemAppState> store;
  bool isFlip;

  // AnimationController controller ;
  Pieces({this.item, this.size, this.store, this.isFlip});

  @override
  _PiecesState createState() => _PiecesState();
}

class _PiecesState extends State<Pieces> with TickerProviderStateMixin {
  bool canFlip = true;
  static int clicked = 0;
  static bool reset = false;
  bool isLoaded = false;
  AnimationController controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  int _value;

  @override
  void initState() {
    // TODO: implement initState
    // _controller.reset();
    print("item: " + widget.item.toString());
    // canFlip = widget.item == 1;
    // while (widget.item != 0 && widget.item != 1) {}
    if (controller == null)
      controller = new AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );
    _frontScale = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: controller,
      curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = new CurvedAnimation(
      parent: controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
    );
    clicked = 0;
    super.initState();
    loop();
  }

  void loop() {
    if (widget.isFlip == true) {
      controller.forward();
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          print("3 seconds done");
          controller.reverse();
          reset = false;
        });
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool restart = false;

  @override
  Widget build(BuildContext context) {
    if (reset) {
      controller.reset();
    }
    // canFlip = widget.item ==1;
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.item == 0) {}

              print('canFlip' + widget.isFlip.toString());
              print('item in piece: ' + widget.item.toString());
              print("click num: " + clicked.toString());

              if (widget.item == 1) {
                if (controller.isCompleted || controller.velocity > 0) {
                  controller.reverse();
                  this.setState(() {
                    // print("Before $canFlip");
                    // print(clicked);
                    widget.isFlip = false;

                    print("After reverse " + widget.isFlip.toString());
                    // widget.store.dispatch(Action.click);
                  });
                } else {
                  clicked += 1;
                  controller.forward();
                  widget.isFlip = false;
                  print("After forward " + widget.isFlip.toString());
                }
              }
              if (clicked == widget.store.state.board.length) {
                clicked = 0;
                widget.store.dispatch(Action.countTrue);
                Future.delayed(Duration(seconds: 1), () {
                  // reset = true;
                  setState(() {
                    reset = true;
                  });
                });
                Future.delayed(Duration(seconds: 2), () {
                  widget.store.dispatch(Action.next);
                  // this.setState(() {
                  reset = false;
                  // });
                  print("After next " + widget.isFlip.toString());
                });
              }
            },
            child: Animator(
              resetAnimationOnRebuild: true,
              duration: Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: pi),
              repeats: 1,
              // anim là Animator thêm _, ,__ thì nó sẽ không quan tâm là cái gì nữa
              builder: (_, anim, __) => Transform(
                transform: Matrix4.rotationY(anim.value),
                alignment: Alignment.center,
                child: new Card(
                    child: Container(
                        width: widget.size,
                        height: widget.size,
                        color: Colors.blue)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.reverse();
            },
            child: new AnimatedBuilder(
              child: new Card(
                  child: Container(
                      width: widget.size,
                      height: widget.size,
                      color: (widget.isFlip) ? Colors.red : Colors.blue)),
              animation: _backScale,
              builder: (BuildContext context, Widget child) {
                final Matrix4 transform = new Matrix4.identity()
                  ..scale(_backScale.value, 1.0, 1.0);
                return new Transform(
                  transform: transform,
                  alignment: FractionalOffset.center,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Timer extends StatefulWidget {
  Timer({this.onEnd, this.width, this.controller, this.rsCnt});

  final VoidCallback onEnd;
  final double width;
  final AnimationController controller;
  final bool rsCnt;

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  Animation _animate;
  int _sec = 15;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        new AnimationController(duration: Duration(seconds: _sec), vsync: this);
    _animate =
        StepTween(begin: _sec, end: 0).animate(controller..forward(from: 0.0))
          ..addStatusListener((AnimationStatus s) {
            if (s == AnimationStatus.completed) widget.onEnd();
          })
          ..addListener(() {});
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _animate,
      builder: (BuildContext context, Widget child) {
        if (widget.rsCnt) controller.forward(from: 0.0);
        return setText(_animate.value.toString().padLeft(2, '0'),
            widget.width * 0.12, Colors.green);
      });
}
// class restartCard extends StatefulWidget {
//   @override
//   _restartCardState createState() => _restartCardState();
// }
//
// class _restartCardState extends State<restartCard> {
//   void reStart() {
//     Future.delayed(const Duration(seconds: 5), () {
//       setState(() {
//         print("5 seconds done");
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     setState(() {
//       reStart();
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

@immutable
class MemAppState {
  final int score, page, count, clickToNext, clicked;
  final List<List<int>> board;
  bool rsCnt;

  MemAppState({
    this.score,
    this.page,
    this.board,
    this.count,
    this.rsCnt,
    this.clicked,
    this.clickToNext,
  });

  MemAppState.init()
      : score = 0,
        page = -1,
        count = 0,
        board = newBoard(0),
        clickToNext = 0,
        clicked = 0,
        rsCnt = false;
}

enum Action { next, end, start, click, countFalse, countTrue }

MemAppState reduce(MemAppState s, act) {
  switch (act) {
    case Action.next:
      return MemAppState(
          score: s.score + 1,
          page: s.page,
          count: s.count,
          board: newBoard(s.score + 1),
          clickToNext: 0,
          clicked: 0,
          rsCnt: s.rsCnt);

    case Action.end:
      return MemAppState(
          score: s.score,
          page: 1,
          count: s.count + 1,
          board: s.board,
          clickToNext: s.clickToNext,
          clicked: s.clicked,
          rsCnt: s.rsCnt);
    case Action.start:
      return MemAppState(
          score: 0,
          page: 0,
          count: s.count,
          board: newBoard(0),
          clickToNext: 0,
          clicked: 0,
          rsCnt: s.rsCnt);
    // case Action.click:
    //   return MemAppState(
    //       score: s.score,
    //       page: s.page,
    //       count: s.count,
    //       board: s.board,
    //       clickToNext: s.clickToNext + 1,
    //       clicked: 1,
    //       rsCnt: s.rsCnt);
    case Action.countFalse:
      return MemAppState(
          score: s.score,
          page: s.page,
          count: s.count,
          board: s.board,
          clickToNext: s.clickToNext,
          clicked: 0,
          rsCnt: false);
    case Action.countTrue:
      return MemAppState(
          score: s.score,
          page: s.page,
          count: s.count,
          clickToNext: 0,
          board: s.board,
          clicked: 0,
          rsCnt: true);
    default:
      return s;
  }
}

// Tao bang moi

List<List<int>> newBoard(score) {
  var size;
  List<List<int>> board = [];
  var rng = Random();
  int bingoRow, bingoCol;
  for (int k = 2; k < 10; k++) {
    // Xét màu
    if (score < 1) {
      size = 2;
    } else if (score < 4) {
      size = 3;
    } else if (score < 8) {
      size = 4;
    } else if (score < 13) {
      size = 5;
    } else if (score < 22) {
      size = 6;
    } else if (score < 32) {
      size = 7;
    } else if (score >= 32) {
      size = 8;
    }
  }
  for (var i = 0; i < size; i++) {
    List<int> row = [];
    for (var j = 0; j < size; j++) {
      row.add(0);
    }
    board.add(row);
  }
  void randomArr() {
    bingoRow = rng.nextInt(size);
    bingoCol = rng.nextInt(size);
    if (board[bingoRow][bingoCol] == 0) {
      board[bingoRow][bingoCol] = 1;
    } else {
      randomArr();
    }
  }

  for (var i = 0; i < size; i++) {
    randomArr();
  }
  print(board);
  return board;
}
