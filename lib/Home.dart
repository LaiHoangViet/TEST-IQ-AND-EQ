import 'package:flutter/material.dart';
import 'ListTopic.dart';
import 'Rank.dart';
import 'SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Home extends StatelessWidget {
  String gettoken;
  String userId;
  _getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    gettoken = sharedPreferences.getString("token");
    userId = sharedPreferences.getString("userId");
    print(gettoken);
  }
  List<String> HomeCate = [
    'List Topic',
    'Rank',
  ];

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
        body: ListView.builder(
            itemCount: HomeCate.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  if (index == 0) {
                    _getToken();
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
