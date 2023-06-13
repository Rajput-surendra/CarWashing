import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: colors.darkIcon,
          appBar: customAppBar(context: context, text:"Notification", isTrue: true, ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/1.2,
                    child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Accessories()));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text("Surendra !!!!",style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.w600),),
                                 )
                                ],
                              )
                          ),
                        );
                      },
                    ),
                  )
                ]
            ),
          )
      ),
    );
  }
}
