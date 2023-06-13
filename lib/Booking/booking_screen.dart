import 'dart:convert';
import 'package:doctorapp/New_model/booking_model.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../Helper/Appbar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  BookingModel? bookingData;
  getBooking() async {
    var headers = {
      'Cookie': 'ci_session=cdb936dc30ae5e18b6f47686df46d292c59302e6'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getBooking}'));
    request.fields.addAll({
      'user_id': '430'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var   Result = await response.stream.bytesToString();
      final finalResult = BookingModel.fromJson(json.decode(Result));
      setState(() {
        bookingData = finalResult;
        //print('My booking name is---------${bookingData?.data.first.name}');
      });
    }
    else {
    print(response.reasonPhrase);
    }
    

  }
  @override
  void initState() {
    // TODO: implement initState
    getBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Booking", isTrue: true, ),
      body: Column(
        children: [
           Container(
             height: 230
             ,
             child: ListView.builder(
               itemCount: bookingData?.data!.length,
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemBuilder:(context, index) {
               return Card(
                 elevation: 3,
                 child: Column(
                     children: [
                      Text('${bookingData!.data![index].name}'),
                       Text('${bookingData!.data![index].doctorId}'),
                       Text('${bookingData!.data![index].description}',overflow: TextOverflow.ellipsis,maxLines:3,style: TextStyle(fontSize: 15),),
                       Text('${bookingData!.data![index].timeslotText}'),
                 ]),
               );
             },),
           )
        ],
      )
    );
  }
}
