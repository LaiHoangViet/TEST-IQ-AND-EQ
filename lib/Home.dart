import 'package:flutter/material.dart';
import 'ListTopic.dart';
import 'Rank.dart';
import 'SizeConfig.dart';


class Home extends StatelessWidget {
  List<String> HomeCate=[
    'List Topic',
    'Rank',
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home",
          style:TextStyle(
            fontSize: 24,
          ),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.home),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
          itemCount: HomeCate.length,
          itemBuilder: (context, index){
        return ListTile(
          onTap: (){
            if(index == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Listopic()));
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Ranks()));
            }
          },
          title: Container(
            height: SizeConfig.blockSizeVertical*30,
            width: SizeConfig.blockSizeHorizontal*90,
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical*8,
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
                    height: SizeConfig.blockSizeVertical*40,
                    width: SizeConfig.blockSizeHorizontal*60,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0), // border = widget Container
                        bottomLeft: Radius.circular(250.0), //boder corner
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: SizeConfig.blockSizeVertical*40,
                    width: SizeConfig.blockSizeHorizontal*60,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0), // border = widget Container
                        bottomRight: Radius.circular(200), //boder corner
                        bottomLeft: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: SizeConfig.blockSizeVertical*10,
                  left: SizeConfig.blockSizeHorizontal*16,
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    radius: SizeConfig.blockSizeHorizontal*2,
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.blockSizeVertical*5,
                  right: SizeConfig.blockSizeHorizontal*10,
                  child: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    radius: SizeConfig.blockSizeHorizontal*8,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(HomeCate[index],
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
      })
    );
  }
}
