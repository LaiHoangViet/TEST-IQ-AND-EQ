import 'dart:convert';
import 'dart:io';

import 'package:demo1/ImageTest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ListTopic.dart';
import 'Rank.dart';
import 'SizeConfig.dart';
import 'Test.dart';
import 'links.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  API api = new API();
  String gettoken, IQ;
  int userId;
  var res, cate;

  @override
  void initState(){
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
    cate = jsonDecode(res.body)["categorys"];
    // print(cate);
    sharedPreferences.setInt("IQ", cate[0]["id"]);
    sharedPreferences.setInt("EQ", cate[1]["id"]);
    sharedPreferences.setInt("MEM", cate[2]["id"]);
    sharedPreferences.setInt("EYE", cate[3]["id"]);
    setState(() {});
  }

  List<String> HomeCate = [
    'List Topic',
    'Rank',
  ];

  void logout(){

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountEmail: new Text("hoang99tm@gmail.com", style: TextStyle(color: Colors.black),),
                accountName: new Text("Manh Hoang", style: TextStyle(color: Colors.black),),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new AssetImage("images/anh1.jpg"),
                  ),
                  onTap: () => print("This is your current account."),
                ),
                decoration: new BoxDecoration(),
              ),
              new Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: FlatButton(
                    onPressed: ()=>exit(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Logout",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        IconButton(
                          icon: new Icon(Icons.exit_to_app),
                        )
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: HomeCate.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Listopic()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Ranks()));
                  }
                },
                title: Container(
                  height: SizeConfig.blockSizeVertical * 30,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 40,
                          width: SizeConfig.blockSizeHorizontal * 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.amberAccent,
                                Colors.deepPurpleAccent
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              // border = widget Container
                              bottomLeft: Radius.circular(250.0),
                              //boder corner
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 40,
                          width: SizeConfig.blockSizeHorizontal * 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.cyanAccent, Colors.pinkAccent],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              // border = widget Container
                              bottomRight: Radius.circular(200),
                              //boder corner
                              bottomLeft: Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: SizeConfig.blockSizeVertical * 10,
                        left: SizeConfig.blockSizeHorizontal * 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.deepPurpleAccent,
                          radius: SizeConfig.blockSizeHorizontal * 2,
                        ),
                      ),
                      Positioned(
                        bottom: SizeConfig.blockSizeVertical * 5,
                        right: SizeConfig.blockSizeHorizontal * 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.deepPurpleAccent,
                          radius: SizeConfig.blockSizeHorizontal * 8,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          HomeCate[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}


