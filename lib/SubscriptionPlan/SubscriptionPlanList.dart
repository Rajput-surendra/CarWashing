import 'dart:convert';

import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/CarWashing/Subscribed_plans_List_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import 'package:http/http.dart'as http;

import '../api/api_services.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubscriptionPlanApi();
  }

  SubscribedPlansListModel? subscribedPlansListModel;
  getSubscriptionPlanApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=fd488e599591e4d13d6ae441c1876300c07b77d5'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${ApiService.getSubsriptionListApi}"));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    print('_____Surendra_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print('_____result_____${result}_________');
      var finalResult = SubscribedPlansListModel.fromJson(jsonDecode(result));
      setState(() {
        subscribedPlansListModel = finalResult;
      });

    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"My Subscription Plan", isTrue: true, ),
      backgroundColor: colors.darkIcon,
        body: Column(
          children: [
            subscribedPlansListModel == null || subscribedPlansListModel!.data  == null ?
            Center(child: CircularProgressIndicator()):subscribedPlansListModel!.data!.length == 0 ? Center(child: Text("No Data Found!!"),):Container(
              height: MediaQuery.of(context).size.height/1.4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: subscribedPlansListModel!.data!.length,
                  itemBuilder: (c,i){
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/bacImages.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child:  Column(
                            children: [

                              SizedBox(height: 80,),
                              Text(
                                "${subscribedPlansListModel!.data![i].name}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: colors.whiteTemp),
                              ),
                              SizedBox(height: 60,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("₹ ${subscribedPlansListModel!.data![i].amount}",style: TextStyle(color: colors.secondary,fontWeight: FontWeight.bold,fontSize: 20,
                                  decorationThickness: 2, height: 2.5,),),
                              ),
                              SizedBox(height: 8),
                              Text( "Time: ${subscribedPlansListModel!.data![i].timeSlot}",style: TextStyle(color: colors.blackTemp),),
                              SizedBox(height: 8),
                              Text( "EndDate: ${subscribedPlansListModel!.data![i].endDate}"),
                              SizedBox(height: 8),

                            ],
                          ),
                        ),
                      ),


                    )
                );
              }
              ),
            )
          ],
        ),
    );
  }
}
