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

  _grade(int score) => [10, 20, 30, 35, 40, 45, 99]
      .where((i) => i > score)
      .reduce(min)
      .toString();

  _createBoard(double size, List<List<int>> blocks, int depth, int click,
          MaterialColor color) =>
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: blocks
              .map((cols) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: cols
                      .map((item) => Flexible(
                            child: GestureDetector(
                                onTap: () {
                                  if (item == 1) store.dispatch(Action.next);
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

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, AppState>(
      // onInit: (state) => ShakeDetector.autoStart(
      //     onPhoneShake: () => store.dispatch(Action.shake)),
      converter: (store) => store.state,
      builder: (context, state) {
        var w = MediaQuery.of(context).size.height / 16 * 7,
            size = w / (state.board.length + 1),
            depth = [1 + state.score ~/ 5, 4].reduce(min) * 100,
            click = 0,
            colors = [
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
                                          'Sroce',
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
                                            width: w)
                                        : setText('End', w * 0.08, Colors.red)),
                                Container(
                                    width: w,
                                    height: w * 1.05,
                                    padding: pad(0, w * 0.05),
                                    child: _createBoard(
                                        size,
                                        state.board,
                                        depth,
                                        click,
                                        colors[state.count % colors.length]))
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
                      onPressed: () => store.dispatch(Action.start),
                    ),
                  )
                : Container());
      });
}

class Timer extends StatefulWidget {
  Timer({this.onEnd, this.width});

  final VoidCallback onEnd;
  final double width;

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  Animation _animate;
  int _sec = 10;

  @override
  void initState() {
    super.initState();
    _animate = StepTween(begin: _sec, end: 0).animate(
        AnimationController(duration: Duration(seconds: _sec), vsync: this)
          ..forward(from: 0.0))
      ..addStatusListener((AnimationStatus s) {
        if (s == AnimationStatus.completed) widget.onEnd();
      });
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _animate,
      builder: (BuildContext context, Widget child) => setText(
          _animate.value.toString().padLeft(2, '0'),
          widget.width * 0.12,
          Colors.green));
}

//REDUX
@immutable
class AppState {
  final int score, page, count

      // clickCnt
      ;

  final List<List<int>> board;

  AppState({
    this.score,
    this.page,
    this.board,
    this.count,
    // this.clickCnt
  });

  AppState.init()
      : score = 0,
        page = -1,
        count = 0,
        // clickCnt = 0,
        board = newBoard(0);
}

enum Action { next, end, start, shake, click }

AppState reducer(AppState s, act) {
  switch (act) {
    case Action.click:
      return AppState(
        score: s.score,
        page: s.page,
        count: s.count,
        board: s.board,
        // clickCnt: s.clickCnt + 1,
      );
    case Action.next:
      return AppState(
          score: s.score + 1,
          page: s.page,
          // clickCnt: 0,
          count: s.count,
          board: newBoard(s.score + 1));
    case Action.end:
      return AppState(
        score: s.score,
        page: 1,
        count: s.count + 1,
        board: s.board,
        //  clickCnt: 0
      );
    case Action.start:
      return AppState(
        score: 0, page: 0, count: s.count, board: newBoard(0),
        // clickCnt: 0
      );
    case Action.shake:
      return AppState(
        score: s.score,
        page: s.page,
        count: s.count + 1,
        board: s.board,
        // clickCnt: 0
      );
    default:
      return s;
  }
}

List<List<int>> newBoard(score) {
  var size = score < 7 ? score + 3 : 10,
      rng = Random(),
      bingoRow = rng.nextInt(size),
      bingoCol = rng.nextInt(size);
  // bingoRow1 = rng.nextInt(size),
  // bingoCol1 = rng.nextInt(size);
  List<List<int>> board = [];
  // while (bingoRow == bingoRow1 && bingoCol == bingoCol1) {
  //   bingoRow1 = rng.nextInt(size);
  //   bingoCol1 = rng.nextInt(size);
  // }
  for (var i = 0; i < size; i++) {
    List<int> row = [];
    for (var j = 0; j < size; j++) {
      if ((i == bingoRow && j == bingoCol)
          // || (i == bingoRow1 && j == bingoCol1)
          ) {
        row.add(1);
      } else {
        row.add(0);
      }
      // (i == bingoRow1 && j == bingoCol1 ? 1 : 0);
    }
    board.add(row);
  }

  return board;
}
