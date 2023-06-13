import 'dart:convert';

import 'package:doctorapp/New_model/CarWashing/Get_Service_List_Model.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../SubscriptionPlan/subscription_plan.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {

  // String dropdownvalue = 'Model 1';
  // // List of items in our dropdown menu
  // var items = [
  //   'Model 1',
  //   'Model 2',
  //   'Model 3',
  //   'Model 4',
  //   'Model 5',
  // ];

  List<String> timeList = [
    '11:00 - 11:30',
    '11:30 - 12:00',
    "12:00 - 12:30",
    "12:30 - 1:00",
  ];

  String selectedTime = '';
  List<ServiceListData> serviceListData =  [];
  ServiceListData? serviceListDataDrop;
  GetServiceListModel? getServiceListModel;

  @override
  initState() {
    getModelServiceListApi();
  }

  getModelServiceListApi() async {
    var headers = {
      'Cookie': 'ci_session=f438175ef6ad68874e77f6f77da2999a044d2e59'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${ApiService.getModelApi}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = GetServiceListModel.fromJson(jsonDecode(result));
      print("this is =============>${finalResult}");
      setState(() {
        getServiceListModel = finalResult;
        // diseaseListDataDrop =  finalResult.data![];
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
        backgroundColor: colors.darkIcon,
        appBar: customAppBar(context: context, text:"Service", isTrue: true, ),
        body: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  getServiceListModel == null ? Center(child: CircularProgressIndicator()): getServiceListModel!.data == null ? Center(child: Text("No data Found!!"),):Container(
                    height: MediaQuery.of(context).size.height/1.2,
                    child: GridView.builder(
                      itemCount: getServiceListModel!.data!.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionPlan(modelId: getServiceListModel!.data![index].id,)));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      height: 120,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network("${getServiceListModel!.data![index].image}",fit: BoxFit.fill,))),
                                  SizedBox(height: 15,),
                                  Text("${getServiceListModel!.data![index].cName}")
                                ],
                              )
                          ),
                        );
                      },
                    ),
                  )
                ]
            ),
          ),

          // Form(
          //   key: _formKey,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         Padding(
          //             padding: EdgeInsets.all(5.0),
          //             child:Row(
          //               children: [
          //                 Text(
          //                   "Your Name",
          //                   style: TextStyle(
          //                       color: colors.black54, fontWeight: FontWeight.bold),
          //                 ),
          //                 Text(
          //                   "*",
          //                   style: TextStyle(
          //                       color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
          //                 ),
          //               ],
          //             )
          //
          //
          //         ),
          //         Container(
          //           height: 55,
          //           decoration: BoxDecoration(
          //             color:
          //               colors.whiteTemp,
          //             borderRadius: BorderRadius.circular(10)
          //           ),
          //           child: TextFormField(
          //             style: TextStyle(color: colors.black54),
          //             controller: nameController,
          //             keyboardType: TextInputType.text,
          //             decoration: InputDecoration(
          //                 prefixText: "",
          //                 hintText: 'Enter Name',
          //                 hintStyle: const TextStyle(
          //                     fontSize: 15.0, color: colors.primary,fontWeight: FontWeight.normal),
          //                 border: InputBorder.none,
          //                 contentPadding: EdgeInsets.only(left: 10, top: 5)),
          //             validator: (v) {
          //               if (v!.isEmpty) {
          //                 return "name is required";
          //               }
          //             },
          //           ),
          //         ),
          //         SizedBox(height: 10,),
          //         Padding(
          //             padding: const EdgeInsets.all(5.0),
          //             child:Row(
          //               children: [
          //                 const Text(
          //                   "Mobile No",
          //                   style: TextStyle(
          //                       color: colors.black54, fontWeight: FontWeight.bold),
          //                 ),
          //                 const Text(
          //                   "*",
          //                   style: TextStyle(
          //                       color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
          //                 ),
          //               ],
          //             )
          //         ),
          //         Container(
          //           height: 55,
          //           decoration: BoxDecoration(
          //               color:
          //               colors.whiteTemp,
          //               borderRadius: BorderRadius.circular(10)
          //           ),
          //           child: TextFormField(
          //             style: TextStyle(color: colors.black54),
          //             controller: mobileController,
          //             keyboardType: TextInputType.number,
          //             maxLength: 10,
          //             decoration: InputDecoration(
          //                 counterText: "",
          //                 hintText: 'Enter Mobile',
          //                 hintStyle:
          //                 TextStyle(fontSize: 15.0, color: colors.secondary),
          //                 border: InputBorder.none,
          //                 contentPadding: EdgeInsets.only(left: 10, top: 10)),
          //             validator: (v) {
          //               if (v!.length != 10) {
          //                 return "mobile number is required";
          //               }
          //             },
          //           ),
          //         ),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         Padding(
          //             padding: EdgeInsets.all(5.0),
          //             child:Row(
          //               children: [
          //                 Text(
          //                   "Address",
          //                   style: TextStyle(
          //                       color: colors.black54, fontWeight: FontWeight.bold),
          //                 ),
          //                 Text(
          //                   "*",
          //                   style: TextStyle(
          //                       color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
          //                 ),
          //               ],
          //             )
          //
          //
          //         ),
          //         Container(
          //           height: 55,
          //           decoration: BoxDecoration(
          //               color:
          //               colors.whiteTemp,
          //               borderRadius: BorderRadius.circular(10)
          //           ),
          //           child: TextFormField(
          //             style: TextStyle(color: colors.black54),
          //             controller: nameController,
          //             keyboardType: TextInputType.text,
          //             decoration: InputDecoration(
          //                 prefixText: "",
          //                 hintText: 'Enter Address',
          //                 hintStyle: const TextStyle(
          //                     fontSize: 15.0, color: colors.primary,fontWeight: FontWeight.normal),
          //                 border: InputBorder.none,
          //                 contentPadding: EdgeInsets.only(left: 10, top: 10)),
          //             validator: (v) {
          //               if (v!.isEmpty) {
          //                 return "address is required";
          //               }
          //             },
          //           ),
          //         ),
          //         SizedBox(height: 10,),
          //         Padding(
          //             padding: EdgeInsets.all(5.0),
          //             child:Row(
          //               children: [
          //                 Text(
          //                   "Model",
          //                   style: TextStyle(
          //                       color: colors.black54, fontWeight: FontWeight.bold),
          //                 ),
          //                 Text(
          //                   "*",
          //                   style: TextStyle(
          //                       color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
          //                 ),
          //               ],
          //             )
          //
          //
          //         ),
          //
          //         getServiceListModel == null ? CircularProgressIndicator() :
          //         Container(
          //           height: 55,
          //             padding: EdgeInsets.only(right: 5, top: 0),
          //             width: MediaQuery.of(context).size.width,
          //             decoration: BoxDecoration(
          //               color: colors.whiteTemp,
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             child:  DropdownButtonHideUnderline(
          //               child: DropdownButton2(
          //                 hint: Padding(
          //                   padding: const EdgeInsets.only(left: 8),
          //                   child: Text("Select Model",
          //                     style: TextStyle(
          //                         color: colors.primary,fontWeight: FontWeight.normal
          //                     ),),
          //                 ),
          //                 // dropdownColor: colors.primary,
          //                 value: serviceListDataDrop,
          //                 icon:  Padding(
          //                   padding: const EdgeInsets.only(bottom: 0),
          //                   child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
          //                 ),
          //                 // elevation: 16,
          //                 style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
          //                 underline: Padding(
          //                   padding: const EdgeInsets.only(left: 0,right: 0),
          //                   child: Container(
          //                     // height: 2,
          //                     color:  colors.whiteTemp,
          //                   ),
          //                 ),
          //                 onChanged: (ServiceListData? newValue) {
          //                   // This is called when the user selects an item.
          //                   setState(() {
          //                     serviceListDataDrop = newValue!;
          //                   });
          //                 },
          //
          //                 items:getServiceListModel!.data!.map((items) {
          //                   return DropdownMenuItem(
          //                     value: items,
          //                     child:   Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Text(items.cName??'',style: TextStyle(color:colors.primary,fontWeight: FontWeight.normal),),
          //                         // Divider(
          //                         //   thickness: 0.2,
          //                         //   color: colors.black54,
          //                         // )
          //                       ],
          //                     ),
          //
          //                   );
          //                 })
          //                     .toList(),
          //
          //               ),
          //
          //             )
          //
          //         ),
          //         // Container(
          //         //   height: 55,
          //         //   decoration: BoxDecoration(color: colors.whiteTemp,
          //         //     borderRadius: BorderRadius.circular(10),
          //         //   ),
          //         //   child: DropdownButtonHideUnderline(
          //         //     child: DropdownButton2(
          //         //       isExpanded: true,
          //         //       value: dropdownvalue,
          //         //       icon: Padding(
          //         //         padding: EdgeInsets.only(right: 10),
          //         //           child: const Icon(Icons.keyboard_arrow_down,color: colors.primary)),
          //         //       items: items.map((String items) {
          //         //         return DropdownMenuItem(
          //         //           value: items,
          //         //           child: Text(items,style: TextStyle(color: colors.primary),),
          //         //         );
          //         //       }).toList(),
          //         //       onChanged: (String? newValue) {
          //         //         setState(() {
          //         //           dropdownvalue = newValue!;
          //         //         });
          //         //       },
          //         //     ),
          //         //   ),
          //         // ),
          //         SizedBox(height: 10,),
          //         Padding(
          //             padding: EdgeInsets.all(5.0),
          //             child:Row(
          //               children: [
          //                 Text(
          //                   "Time",
          //                   style: TextStyle(
          //                       color: colors.black54, fontWeight: FontWeight.bold),
          //                 ),
          //                 Text(
          //                   "*",
          //                   style: TextStyle(
          //                       color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
          //                 ),
          //               ],
          //             )
          //
          //         ),
          //         Container(
          //           height: 50,
          //           width: MediaQuery.of(context).size.width,
          //           child: ListView.builder(
          //               shrinkWrap: true,
          //               itemCount: timeList.length,
          //               physics: ScrollPhysics(),
          //               scrollDirection: Axis.horizontal,
          //               itemBuilder: (c,i){
          //             return InkWell(
          //               onTap: (){
          //                 setState(() {
          //                   selectedTime = timeList[i];
          //                 });
          //                 print("selected time here  ${selectedTime}");
          //               },
          //               child: Container(
          //               alignment: Alignment.center,
          //                 padding: EdgeInsets.symmetric(horizontal: 5),
          //                 margin: EdgeInsets.only(right: 10),
          //                 decoration: BoxDecoration(
          //                    color: selectedTime == timeList[i] ? colors.primary : colors.whiteTemp,
          //                     // width: selectedTime == timeList[i] ? 2 :1
          //
          //                   borderRadius: BorderRadius.circular(9),
          //                 ),
          //                 child: Text("${timeList[i]}", style: TextStyle(color:selectedTime == timeList[i] ? colors.whiteTemp : colors.primary),),
          //               ),
          //             );
          //           }),
          //         ),
          //         SizedBox(height: 50,),
          //         InkWell(
          //           onTap: (){
          //             if(_formKey.currentState!.validate()){
          //
          //             }
          //             else{
          //               Fluttertoast.showToast(msg: "All Field are required");
          //             }
          //           },
          //           child: Container(
          //
          //             height: 45,
          //             decoration: BoxDecoration(
          //               color: colors.primary,
          //                 borderRadius: BorderRadius.circular(10)),
          //             child: Center(
          //               child:Text("Submit",
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,color: colors.whiteTemp,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
