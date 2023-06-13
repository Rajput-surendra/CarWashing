import 'dart:convert';
import 'dart:io';
import 'package:doctorapp/AuthenticationView/LoginScreen.dart';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/registration_model2.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import 'package:http/http.dart' as http;

import '../Registration/drverification.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key,}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();

  bool isLoading = false;
  File? imageFile;
  File? newImageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  RegistrationModel2? detailsData;
  registrationApi() async {
 setState(() {
   isLoading == true;
 });
    var headers = {
      'Cookie': 'ci_session=dd50c278f09355c16fbac67ed21dae08884302f4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.userRegister}'));
    request.fields.addAll({
      'name': nameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
      'address': 'Indore Madhya Pradesh',
      'lat': '',
      'lng': ''
    });
    print('____request.fields______${request.fields}_________');

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult =  jsonDecode(result);
     Fluttertoast.showToast(msg: finalResult['message']);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
     setState(() {
       isLoading = false;
     });
     nameController.clear();
     emailController.clear();
     mobileController.clear();
    }
    else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          color: colors.darkIcon,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?",style: TextStyle(color: colors.blackTemp,fontSize: 14,fontWeight: FontWeight.bold),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }, child: Text("Login",style: TextStyle(color: colors.secondary,fontSize: 16,fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      backgroundColor: colors.darkIcon,
        appBar: customAppBar(text: "SignUp", isTrue: true, context: context),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Your Name",
                                      style: TextStyle(
                                          color: colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ],
                                )),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: colors.whiteTemp,),

                              child: TextFormField(
                                style: TextStyle(color: colors.black54),
                                controller: nameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter name',
                                    hintStyle: const TextStyle(
                                        fontSize: 15.0, color: colors.secondary),
                                    contentPadding:
                                        EdgeInsets.only(left: 10, top: 5)),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "name is required";
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Mobile No",
                                      style: TextStyle(
                                          color: colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "*",
                                      style: TextStyle(
                                          color: colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ],
                                )),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: colors.whiteTemp,),
                              child: TextFormField(
                                style: TextStyle(color: colors.black54),
                                controller: mobileController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                    counterText: "",
                                    hintText: 'Enter mobile',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0, color: colors.secondary),
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 10, top: 5)),
                                validator: (v) {
                                  if (v!.length < 10) {
                                    return "mobile number is required";
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Email Id",
                                      style: TextStyle(
                                          color: colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ],
                                )),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: colors.whiteTemp,),
                              child: TextFormField(
                                style: TextStyle(color: colors.black54),
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'Enter email',
                                    hintStyle: const TextStyle(
                                        fontSize: 15.0, color: colors.secondary),
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 10, top: 5)),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Email is required";
                                  }
                                  if (!v.contains("@")) {
                                    return "Enter Valid Email Id";
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Location",
                                      style: TextStyle(
                                          color: colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ],
                                )),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: colors.whiteTemp,),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter location',
                                    hintStyle: const TextStyle(
                                        fontSize: 15.0, color: colors.secondary),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10,top: 5)
                                ),
                                onTap:(){
                                  _getLocation();
                                },
                              ),
                            ),
                            SizedBox(height: 50,),
                            Center(
                              child: Btn(
                                  height: 50,
                                  width: 320,
                                  title:
                                      isLoading ? "Please wait......" : 'Submit',
                                  color: colors.secondary,
                                  onPress: () {
                                    if (_formKey.currentState!.validate()) {
                                      registrationApi();
                                    } else {
                                      const snackBar = SnackBar(
                                        content: Text('All Fields are required!'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                    }
                                  }),
                            )
                          ]
                      )
                  ),
                )
            )
        )
    );
  }
  _getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
        )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} and ${result.postalCode.toString()} ");
    currentLocationController.text = result.postalCode.toString();
    print("this is a pincode==========>${currentLocationController.text}");
    prefs.setString('postalCode1', currentLocationController.text);
    setState(() {
      currentLocationController.text = result.formattedAddress.toString();
      var lat = result.latLng!.latitude;
      var long = result.latLng!.longitude;
    });
  }
}
