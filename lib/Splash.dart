import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Splashscreen extends StatefulWidget{
  @override
  _SplashscreenState createState() => _SplashscreenState();
}


class _SplashscreenState extends State<Splashscreen>{

  var res, log;
  // Khai báo đường link api
  var api = "http://apiiq.bigorder.vn/api/v1/user/auto-login";


    fetchData() async {
      // Map data={
      //   'id':id,
      //   'token':token,
      // };
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      // Gọi đến link API
      res = await http.post(api);
      // print('Tra ve ${res}' );
      // print(res.toString());
      if(res.statusCode==200){
        log = jsonDecode(res.body);
        // print(log);
        // setState(() {
        //                                Key      value
          sharedPreferences.setInt("userId", log["data"]["id"]);
          sharedPreferences.setString("token", log["data"]["token"]);

          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Home()), (Route<dynamic> route) => false);
        // });
      }else{
        print(res.body);
      }
    }



  @override
  void initState(){
    super.initState();
    // _getData();
    fetchData();
    Timer(Duration(seconds: 1),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context)=>Home(),
      ));
    }
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.indigo,
      body:Center(
        child:Text(
          "Quiz Test",
          style: TextStyle(
            inherit: false,
            fontSize: 50.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
