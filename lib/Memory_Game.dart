import 'dart:async';
import 'dart:math';

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

// setBg(name) => BoxDecoration(
//     image: DecorationImage(
//         fit: BoxFit.cover,
//         alignment: Alignment.topLeft,
//         image: AssetImage(name)));

class Game extends StatelessWidget {
  final Store<AppState> store;

  Game(this.store);

  bool restart = false;

  _grade(int score) => [10, 20, 30, 35, 40, 45, 99]
      .where((i) => i > score)
      .reduce(min)
      .toString();

  //Tạo bảng mới
  _createBoard(double size, List<List<int>> blocks, int depth, int click,
      MaterialColor color) {
    if (store.state.rsCnt) store.dispatch(Action.countFalse);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: blocks
            .map((cols) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: cols
                    .map((item) => Flexible(
                          child: GestureDetector(
                              onTap: () {
                                if (item == 1) {
                                  store.dispatch(Action.countTrue);
                                  store.dispatch(Action.next);
                                  store.dispatch(Action.shake);
                                }
                                // if (store.state.clickCnt == 2)
                                //   store.dispatch(Action.next);
                              },
                              child: Container(
                                  width: size,
                                  height: size,
                                  color: item > 0 ? color[depth] : color)),
                        ))
                    .toList()))
            .toList());
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, AppState>(
      // onInit: (state) => ShakeDetector.autoStart(
      //     onPhoneShake: () => store.dispatch(Action.shake)),
      converter: (store) => store.state,
      builder: (context, state) {
        var w = MediaQuery.of(context).size.height / 16 * 7,
            size = w / (state.board.length + 1),
            depth = [(1 + state.score ~/ 4) * 100, 400].reduce(min),
            click = 0,
            colors = [
              Colors.yellow,
              Colors.blue,
              Colors.orange,
              Colors.pink,
              Colors.purple,
              Colors.cyan
            ];

        return Scaffold(
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Listopic()),
                ),
              ),
              title: Text('Eyes Game'),
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
                                      setText(state.score.toString(), w * 0.2,
                                          Colors.black),
                                    ],
                                  ),
                                ),
                                Container(
                                    // height: w * 0.60,
                                    // padding: pad(w * 0.74, state.page * 6.0),
                                    child: state.page < 1
                                        ? Timer(
                                            onEnd: () =>
                                                store.dispatch(Action.end),
                                            width: w,
                                            rsCnt: state.rsCnt)
                                        : setText(
                                            'End', w * 0.08, Colors.red[500])),
                                state.page < 1
                                    ? Container(
                                        width: w,
                                        height: w * 1.05,
                                        padding: pad(0, w * 0.05),
                                        child: _createBoard(
                                            size,
                                            state.board,
                                            depth,
                                            click,
                                            colors[
                                                state.count % colors.length]))
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
                      child: Icon(
                          state.page < 1 ? Icons.play_arrow : Icons.refresh),
                      onPressed: () {
                        store.dispatch(Action.start);
                      },
                    ),
                  )
                : Container());
      });
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

@immutable
class AppState {
  final int score, page, count;
  final List<List<int>> board;
  bool rsCnt;

  AppState({this.score, this.page, this.board, this.count, this.rsCnt});

  AppState.init()
      : score = 0,
        page = -1,
        count = 0,
        board = newBoard(0),
        rsCnt = false;
}

enum Action { next, end, start, shake, countFalse, countTrue }

AppState reducer(AppState s, act) {
  switch (act) {
    case Action.next:
      return AppState(
          score: s.score + 1,
          page: s.page,
          count: s.count,
          board: newBoard(s.score + 1),
          rsCnt: s.rsCnt);

    case Action.end:
      return AppState(
          score: s.score,
          page: 1,
          count: s.count + 1,
          board: s.board,
          rsCnt: s.rsCnt);
    case Action.start:
      return AppState(
          score: 0,
          page: 0,
          count: s.count,
          board: newBoard(0),
          rsCnt: s.rsCnt);
    case Action.shake:
      return AppState(
          score: s.score,
          page: s.page,
          count: s.count + 1,
          board: s.board,
          rsCnt: s.rsCnt);
    case Action.countFalse:
      return AppState(
          score: s.score,
          page: s.page,
          count: s.count,
          board: s.board,
          rsCnt: false);
    case Action.countTrue:
      return AppState(
          score: s.score,
          page: s.page,
          count: s.count,
          board: s.board,
          rsCnt: true);
    default:
      return s;
  }
}

// Tao bang moi

List<List<int>> newBoard(score) {
  for (int k = 2; k < 10; k++) {
    var size;
    // bingoRow1 = rng.nextInt(size),
    // bingoCol1 = rng.nextInt(size);

    List<List<int>> board = [];
    // while (bingoRow == bingoRow1 && bingoCol == bingoCol1) {
    //   bingoRow1 = rng.nextInt(size);
    //   bingoCol1 = rng.nextInt(size);
    // }

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
    int count = size;
    var rng = Random(),
        bingoRow = rng.nextInt(size),
        bingoCol = rng.nextInt(size);
    for (var i = 0; i < size; i++) {
      List<int> row = [];
      for (var j = 0; j < size; j++) {
        if ((i == bingoRow && j == bingoCol)) {
          row.add(1);
        } else {
          row.add(0);
        }
        // (i == bingoRow1 && j == bingoCol1 ? 1 : 0);
      }
      board.add(row);

      // print(board);

    }
    return board;
  }
}
