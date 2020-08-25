import 'package:flutter/material.dart';
import 'ListTopic.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          contentPadding:  EdgeInsets.symmetric(vertical: 50, horizontal: 100),
          title: Text("Listopic"),
          onTap:(){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>Listopic())
            );
          }
        ),
      )
    );
  }
}
