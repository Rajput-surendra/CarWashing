
import 'dart:convert';

import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import 'Accessrioes.dart';

class EnquireScreen extends StatefulWidget {
  String? accessoriesId;
  EnquireScreen({Key? key,this.accessoriesId}) : super(key: key);
  @override
  State<EnquireScreen> createState() => _EnquireScreenState();
}

class _EnquireScreenState extends State<EnquireScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  initState() {
    getUserId();

  }
  String? userId;
  getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     userId = preferences.getString('userId');
  }
  submitEnquiryApi() async {

    var headers = {
      'Cookie': 'ci_session=d59b9b537f009903b38a8191c5e26131f89f20cd'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.submitEnquiryApi}'));
    request.fields.addAll({
      'name': nameController.text,
      'mobile': mobileController.text,
      'message': messageController.text,
      'user_id': userId.toString(),
      'accessories_id': widget.accessoriesId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult =  jsonDecode(result);
     Fluttertoast.showToast(msg: "${finalResult['message']}");
     Navigator.pop(context);
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Accessories()));
     setState(() {
     });
     nameController.clear();
     messageController.clear();
     mobileController.clear();
    }

    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.darkIcon,
      appBar: customAppBar(context: context, text:"Enquire", isTrue: true, ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Your Name",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )

                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color:
                      colors.whiteTemp,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    style: TextStyle(color: colors.black54),
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixText: "",
                        hintText: 'Enter Name',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, color: colors.primary,fontWeight: FontWeight.normal),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 5)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "name is required";
                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        const Text(
                          "Mobile No",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color:
                      colors.whiteTemp,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    style: TextStyle(color: colors.black54),
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counterText: "",
                        hintText: 'Enter Mobile',
                        hintStyle:
                        TextStyle(fontSize: 15.0, color: colors.secondary),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.length != 10) {
                        return "mobile number is required";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )

                ),
                Container(
                  decoration: BoxDecoration(
                      color:
                      colors.whiteTemp,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    maxLines: 6,
                    style: TextStyle(color: colors.black54),
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixText: "",
                        hintText: 'Enter description',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, color: colors.primary,fontWeight: FontWeight.normal),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "description is required";
                      }
                    },
                  ),
                ),


                SizedBox(height: 50,),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      submitEnquiryApi();
                    }
                    else{
                      Fluttertoast.showToast(msg: "All Field are required");
                    }
                  },
                  child: Container(

                    height: 45,
                    decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child:Text("Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,color: colors.whiteTemp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
