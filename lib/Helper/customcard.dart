import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({Key? key,this.image, this.title, this.subtitle, this.Money, this.driver, this.rideTime,

  }) : super(key: key);

  final  String? image ;
  final String? title;
  final String? subtitle;
  final String? Money;
  final String? driver;
  final String? rideTime;

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/2 Pharma News.png',height: 100,width: 100,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1 News",style: TextStyle(fontWeight: FontWeight.bold),),
              Text("It needs to be punchy, \n facts and convey what\n the story is about.",)
            ],),
          Padding(
            padding: const EdgeInsets.only(top: 90,left: 40),
            child: Text("10 : 00",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),),
          )
        ],
      ),
    );
  }
}
