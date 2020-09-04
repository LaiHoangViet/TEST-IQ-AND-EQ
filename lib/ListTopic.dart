import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Test.dart';
import 'package:http/http.dart' as http;
import 'links.dart';

class obCate {
  final String id;
  final String category;

  obCate.formJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.category = json['category'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'category': this.category,
      };
}

class Listopic extends StatefulWidget {
  @override
  _ListopicState createState() => _ListopicState();
}

class _ListopicState extends State<Listopic> {
  API api = new API();
  var res, topic, getTopic, resTopic, topiclevel;
  String gettoken;
  int userId, cateId;

  @override
  void initState() {
    super.initState();

    getToken();
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    gettoken = sharedPreferences.getString("token");
    userId = sharedPreferences.getInt("userId");
    res = await http.get(api.linkList(userId, gettoken));
    // sharedPreferences.setInt("cateId", res["categorys"]["id"]);
    // cateId = sharedPreferences.getInt("cateId");
    // resTopic = await http.get(api.Topic(cateId,userId, gettoken));
    topic = jsonDecode(res.body)["categorys"];
    // topiclevel = jsonDecode(resTopic.body)["data"];
    // print(gettoken);
    // print(userId);
    // print(cateId);
    setState(() {});
  }

  List<Widget> containers(BuildContext context) {
    return [
      /*IQ*/
      Center(
        child: topic != null ?
        ListView.builder(
            itemCount: topic.length,
            itemBuilder: (context, index) {
              var infoTopic = topic[index];
              return
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                /*Ảnh và tên bài test*/
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      ClipOval(
                                        child: Image.asset(
                                          'images/anh1.jpg',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15),
                                              child: Text(
                                                infoTopic["category"],
                                                // "Category",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '100 - ***',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*Thông tin bài test*/
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, bottom: 20, left: 20, right: 20),
                                  padding: EdgeInsets.all(5),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  child: Text(
                                    'Thông tin bài test. '
                                        'Chúc bạn làm bài đạt điểm số cao nhất',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                /*Nút test và nút rank*/
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      RaisedButton(
                                        onPressed: () => {
                                          getToken(),
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => new Test()),
                                          ),
                                        },
                                        color: Colors.blue,
                                        child: Text('Test'),
                                        textColor: Colors.white,
                                        highlightElevation: 4.0,
                                      ),
                                      RaisedButton(
                                        onPressed: () {},
                                        color: Colors.blue,
                                        child: Text('Rank'),
                                        textColor: Colors.white,
                                        highlightElevation: 4.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Card(
                          //   elevation: 5,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: <Widget>[
                          //       /*Ảnh và tên bài test*/
                          //       Container(
                          //         padding: const EdgeInsets.all(10),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //           children: <Widget>[
                          //             ClipOval(
                          //               child: Image.asset(
                          //                 'images/anh1.jpg',
                          //                 width: 100,
                          //                 height: 100,
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //             Container(
                          //               child: Column(
                          //                 children: <Widget>[
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         bottom: 15),
                          //                     child: Text(
                          //                       'Lại Hoàng Việt',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Text(
                          //                     '100 - ***',
                          //                     style: TextStyle(fontSize: 16),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       /*Thông tin bài test*/
                          //       Container(
                          //         margin: EdgeInsets.only(
                          //             top: 20, bottom: 20, left: 20, right: 20),
                          //         padding: EdgeInsets.all(5),
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //             width: 1,
                          //           ),
                          //           borderRadius:
                          //           BorderRadius.all(Radius.circular(4.0)),
                          //         ),
                          //         child: Text(
                          //           'Thông tin bài test. '
                          //               'Chúc bạn làm bài đạt điểm số cao nhất',
                          //           textAlign: TextAlign.center,
                          //         ),
                          //       ),
                          //       /*Nút test và nút rank*/
                          //       Container(
                          //         padding: const EdgeInsets.only(
                          //           bottom: 10,
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //           children: <Widget>[
                          //             RaisedButton(
                          //               onPressed: () {},
                          //               color: Colors.blue,
                          //               child: Text('Test'),
                          //               textColor: Colors.white,
                          //               highlightElevation: 4.0,
                          //             ),
                          //             RaisedButton(
                          //               onPressed: () {},
                          //               color: Colors.blue,
                          //               child: Text('Rank'),
                          //               textColor: Colors.white,
                          //               highlightElevation: 4.0,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Card(
                          //   elevation: 5,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: <Widget>[
                          //       /*Ảnh và tên bài test*/
                          //       Container(
                          //         padding: const EdgeInsets.all(10),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //           children: <Widget>[
                          //             ClipOval(
                          //               child: Image.asset(
                          //                 'images/anh1.jpg',
                          //                 width: 100,
                          //                 height: 100,
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //             Container(
                          //               child: Column(
                          //                 children: <Widget>[
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         bottom: 15),
                          //                     child: Text(
                          //                       'Lại Hoàng Việt',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Text(
                          //                     '100 - ***',
                          //                     style: TextStyle(fontSize: 16),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       /*Thông tin bài test*/
                          //       Container(
                          //         margin: EdgeInsets.only(
                          //             top: 20, bottom: 20, left: 20, right: 20),
                          //         padding: EdgeInsets.all(5),
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //             width: 1,
                          //           ),
                          //           borderRadius:
                          //           BorderRadius.all(Radius.circular(4.0)),
                          //         ),
                          //         child: Text(
                          //           'Thông tin bài test. '
                          //               'Chúc bạn làm bài đạt điểm số cao nhất',
                          //           textAlign: TextAlign.center,
                          //         ),
                          //       ),
                          //       /*Nút test và nút rank*/
                          //       Container(
                          //         padding: const EdgeInsets.only(
                          //           bottom: 10,
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //           children: <Widget>[
                          //             RaisedButton(
                          //               onPressed: () {},
                          //               color: Colors.blue,
                          //               child: Text('Test'),
                          //               textColor: Colors.white,
                          //               highlightElevation: 4.0,
                          //             ),
                          //             RaisedButton(
                          //               onPressed: () {},
                          //               color: Colors.blue,
                          //               child: Text('Rank'),
                          //               textColor: Colors.white,
                          //               highlightElevation: 4.0,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Card(
                          //   elevation: 5,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: <Widget>[
                          //       /*Ảnh và tên bài test*/
                          //       Container(
                          //         padding: const EdgeInsets.all(10),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //           children: <Widget>[
                          //             ClipOval(
                          //               child: Image.asset(
                          //                 'images/anh1.jpg',
                          //                 width: 100,
                          //                 height: 100,
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //             Container(
                          //               child: Column(
                          //                 children: <Widget>[
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         bottom: 15),
                          //                     child: Text(
                          //                       'Lại Hoàng Việt',
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Text(
                          //                     '100 - ***',
                          //                     style: TextStyle(fontSize: 16),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       /*Thông tin bài test*/
                          //       Container(
                          //         margin: EdgeInsets.only(
                          //             top: 20, bottom: 20, left: 20, right: 20),
                          //         padding: EdgeInsets.all(5),
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //           border: Border.all(
                          //             width: 1,
                          //           ),
                          //           borderRadius:
                          //           BorderRadius.all(Radius.circular(4.0)),
                          //         ),
                          //         child: Text(
                          //           'Thông tin bài test. '
                          //               'Chúc bạn làm bài đạt điểm số cao nhất',
                          //           textAlign: TextAlign.center,
                          //         ),
                          //       ),
                          //       /*Nút test và nút rank*/
                          //       Container(
                          //         padding: const EdgeInsets.only(
                          //           bottom: 10,
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //           children: <Widget>[
                          //             RaisedButton(
                          //               onPressed: () {},
                          //               color: Colors.blue,
                          //               child: Text('Test'),
                          //               textColor: Colors.white,
                          //               highlightElevation: 4.0,
                          //             ),
                          //             RaisedButton(
                          //               onPressed: () {},
                          //               color: Colors.blue,
                          //               child: Text('Rank'),
                          //               textColor: Colors.white,
                          //               highlightElevation: 4.0,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                );
            }
            ):Text("NULL"),
  ),
      // Container(
      //   margin: const EdgeInsets.all(10),
      //   child: Column(
      //     children: <Widget>[
      //       Card(
      //         elevation: 5,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: <Widget>[
      //             /*Ảnh và tên bài test*/
      //             Container(
      //               padding: const EdgeInsets.all(10),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: <Widget>[
      //                   ClipOval(
      //                     child: Image.asset(
      //                       'images/anh1.jpg',
      //                       width: 100,
      //                       height: 100,
      //                       fit: BoxFit.cover,
      //                     ),
      //                   ),
      //                   Container(
      //                     child: Column(
      //                       children: <Widget>[
      //                         Padding(
      //                           padding: const EdgeInsets.only(bottom: 15),
      //                           child: Text(
      //                             'Lại Hoàng Việt',
      //                             style: TextStyle(
      //                               fontSize: 18,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                         ),
      //                         Text(
      //                           '100 - ***',
      //                           style: TextStyle(fontSize: 16),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             /*Thông tin bài test*/
      //             Container(
      //               margin: EdgeInsets.only(
      //                   top: 20, bottom: 20, left: 20, right: 20),
      //               padding: EdgeInsets.all(5),
      //               width: double.infinity,
      //               decoration: BoxDecoration(
      //                 border: Border.all(
      //                   width: 1,
      //                 ),
      //                 borderRadius: BorderRadius.all(Radius.circular(4.0)),
      //               ),
      //               child: Text(
      //                 'Thông tin bài test. '
      //                     'Chúc bạn làm bài đạt điểm số cao nhất',
      //                 textAlign: TextAlign.center,
      //               ),
      //             ),
      //             /*Nút test và nút rank*/
      //             Container(
      //               padding: const EdgeInsets.only(
      //                 bottom: 10,
      //               ),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: <Widget>[
      //                   RaisedButton(
      //                     onPressed: () => {
      //                       Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => new Test()),
      //                       ),
      //                     },
      //                     color: Colors.blue,
      //                     child: Text('Test'),
      //                     textColor: Colors.white,
      //                     highlightElevation: 4.0,
      //                   ),
      //                   RaisedButton(
      //                     onPressed: () {},
      //                     color: Colors.blue,
      //                     child: Text('Rank'),
      //                     textColor: Colors.white,
      //                     highlightElevation: 4.0,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Card(
      //         elevation: 5,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: <Widget>[
      //             /*Ảnh và tên bài test*/
      //             Container(
      //               padding: const EdgeInsets.all(10),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: <Widget>[
      //                   ClipOval(
      //                     child: Image.asset(
      //                       'images/anh1.jpg',
      //                       width: 100,
      //                       height: 100,
      //                       fit: BoxFit.cover,
      //                     ),
      //                   ),
      //                   Container(
      //                     child: Column(
      //                       children: <Widget>[
      //                         Padding(
      //                           padding: const EdgeInsets.only(bottom: 15),
      //                           child: Text(
      //                             'Lại Hoàng Việt',
      //                             style: TextStyle(
      //                               fontSize: 18,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                         ),
      //                         Text(
      //                           '100 - ***',
      //                           style: TextStyle(fontSize: 16),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             /*Thông tin bài test*/
      //             Container(
      //               margin: EdgeInsets.only(
      //                   top: 20, bottom: 20, left: 20, right: 20),
      //               padding: EdgeInsets.all(5),
      //               width: double.infinity,
      //               decoration: BoxDecoration(
      //                 border: Border.all(
      //                   width: 1,
      //                 ),
      //                 borderRadius: BorderRadius.all(Radius.circular(4.0)),
      //               ),
      //               child: Text(
      //                 'Thông tin bài test. '
      //                     'Chúc bạn làm bài đạt điểm số cao nhất',
      //                 textAlign: TextAlign.center,
      //               ),
      //             ),
      //             /*Nút test và nút rank*/
      //             Container(
      //               padding: const EdgeInsets.only(
      //                 bottom: 10,
      //               ),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: <Widget>[
      //                   RaisedButton(
      //                     onPressed: () {},
      //                     color: Colors.blue,
      //                     child: Text('Test'),
      //                     textColor: Colors.white,
      //                     highlightElevation: 4.0,
      //                   ),
      //                   RaisedButton(
      //                     onPressed: () {},
      //                     color: Colors.blue,
      //                     child: Text('Rank'),
      //                     textColor: Colors.white,
      //                     highlightElevation: 4.0,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Container(
      //   child: Text('ngoc'),
      // ),
      // Container(
      //   child: Text('ngoc'),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Home'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                // ListView.builder(
                //     itemCount: topic.length,
                //     itemBuilder: (context, index){
                //       var tabCate = topic[index];
                //       return
                        Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "IQ",
                              // tabCate["Category"],
                              textScaleFactor: 2,
                            ),
                          ],
                        ),
                    //   );
                    // }
                    ),
                // Tab(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Text(
                //         'EQ',
                //         textScaleFactor: 2,
                //       ),
                //     ],
                //   ),
                // ),
                // Tab(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Text(
                //         'IQ',
                //         textScaleFactor: 2,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          body: TabBarView(
            children: containers(context),
          ),
        ),
      ),
    );
  }
}

