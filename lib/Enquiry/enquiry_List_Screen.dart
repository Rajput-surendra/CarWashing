import 'dart:convert';

import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../New_model/CarWashing/Get_Enquiry_List_model.dart';

class SubmitEnquiryListScreen extends StatefulWidget {
  const SubmitEnquiryListScreen({Key? key}) : super(key: key);

  @override
  State<SubmitEnquiryListScreen> createState() => _SubmitEnquiryListScreenState();
}

class _SubmitEnquiryListScreenState extends State<SubmitEnquiryListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getEnquiryListApi();
    getUserId();
    super.initState();

  }
  String? userId;
  getUserId() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    userId = preferences.getString('userId');
  print('_____surendra_____${userId}_________');
  }

  GetEnquiryListModel?getEnquiryListModel;
  getEnquiryListApi() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=d59b9b537f009903b38a8191c5e26131f89f20cd'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getEnquiryListApi}'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    print('______request.fields____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     var finalResult = GetEnquiryListModel.fromJson(json.decode(result));
     setState(() {
       getEnquiryListModel = finalResult;
     });
     print('_____finalResult_____${finalResult}_________');
    }
    else {
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.darkIcon,
      appBar: customAppBar(context: context, text:"Enquiry List", isTrue: true, ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              getEnquiryListModel == null ? Center(child: CircularProgressIndicator()): getEnquiryListModel!.data!.length == 0 ?
              Center(child: Text("No data Found!!"),):Container(
                height: MediaQuery.of(context).size.height/1.2,
                child: ListView.builder(
                  itemCount: getEnquiryListModel!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Accessories()));
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network("${getEnquiryListModel!.data![index].logo}",fit: BoxFit.fill,))),
                                  ),
                                  SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${getEnquiryListModel!.data![index].accessoriesName}",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 5,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Container(
                                              width: 200,
                                              child: Text("${getEnquiryListModel!.data![index].accessoriesDescription}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                        )
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text("Name",overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: colors.blackTemp),),
                                         SizedBox(height: 3,),
                                         Text("Mobile",overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: colors.blackTemp),),
                                         SizedBox(height: 3,),
                                         Text("Description",overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: colors.blackTemp),),
                                       ],
                                     ),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.only(left: 5),
                                           child: Container(
                                               width: 200,
                                               child: Text("${getEnquiryListModel!.data![index].name}",overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: colors.blackTemp),)),
                                         ),
                                         SizedBox(height: 3,),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 5),
                                           child: Container(
                                               width: 200,
                                               child: Text("${getEnquiryListModel!.data![index].mobile}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                         ),
                                         SizedBox(height: 3,),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 5),
                                           child: Container(
                                               width: 150,
                                               child: Text("${getEnquiryListModel!.data![index].message}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                         ),
                                       ],
                                     )
                                   ],
                                 ),
                               ),
                              SizedBox(height: 10,)
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
    );
  }
}
