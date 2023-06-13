import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import 'package:http/http.dart'as http;

import '../Helper/Color.dart';
import '../api/api_services.dart';
class AddEventPost extends StatefulWidget {
  const AddEventPost({Key? key}) : super(key: key);

  @override
  State<AddEventPost> createState() => _AddEventPostState();
}

class _AddEventPostState extends State<AddEventPost> {

  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  File? newImageFile;
  bool isloader = false;
  List<File> files = [];
  List<File> files1 = [];
  _getFromGallery(bool type) async {
    FilePickerResult? result;
    if(type){
   result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg', 'jpg']);}
    if (result != null) {
      setState(() {
        files = result!.paths.map((path) => File(path!)).toList();
      });}
    else {
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        setState(() {
          files1 = result!.paths.map((path) => File(path!)).toList();
        });
      }
    }

  }

  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController designController = TextEditingController();

  String _dateValue = '';
  var dateFormate;
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  Future _selectDateStart() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        startDateController = TextEditingController(text: _dateValue);


      });
  }
  Future _selectDateEnd() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
        endDateController = TextEditingController(text: _dateValue);


      });
  }

  getEventPostApi() async {
    setState(() {
      isloader = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId,,,,,,,,,,,,,,,,--------------->${Roll}");

    var headers = {
      'Cookie': 'ci_session=f5c119f5040eaef28e6a4c420b14b794a449a6c4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addDoctorEvent}'));
    request.fields.addAll({
      'user_id': '$userId',
      'roll': '$Roll',
      'link': linkController.text,
      'title': titleController.text,
      'start_date': startDateController.text,
      'end_date': endDateController.text,
      'designation': designController.text,
      'mobile':mobileController.text,
      'name':nameController.text,
      'address':addressController.text

    });
    print("getEventPostApi555555555555555--------------->${request.fields}");
    if(files != null){
      request.files.add(await http.MultipartFile.fromPath('image', files[0].path ?? ''));
    }
    print("files--------------->${request.files}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.encode(result);
      print("thi os ojon==========>${finalResult}");
      //Fluttertoast.showToast(msg: finalResult['message']);
      titleController.clear();
      endDateController.clear();
      startDateController.clear();
      linkController.clear();
      addressController.clear();
      nameController.clear();
      designController.clear();
      mobileController.clear();
      Navigator.pop(context);
      files.clear();
      setState(() {
        isloader = false;
      });
    }

    else {
      setState(() {
        isloader = false;
      });
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Add Event Post", isTrue: true, ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 55,
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Event Name',hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.normal)
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Event Name";
                      }

                    },
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: 45,
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'City Name'
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "City Name are required";
                      }

                    },
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onTap: (){
                    _selectDateStart();
                  },
                  controller:startDateController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      counterText: "",
                      hintText: 'Start Date',
                      contentPadding: EdgeInsets.only(left: 10)
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Start Date is required";
                    }

                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onTap: (){
                    _selectDateEnd();
                  },
                  controller:endDateController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      counterText: "",
                      hintText: 'End Date',
                      contentPadding: EdgeInsets.only(left: 10)
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "End Date is required";
                    }

                  },
                ),
                SizedBox(height: 10,),

                Text("Sponsored",style: TextStyle(
                  color: colors.blackTemp,fontSize: 20
                ),),
                SizedBox(height: 10,),

                Container(
                  height: 45,
                  child: TextFormField(
                    controller: linkController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Registration Link'
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Registration Link is Empty";
                      }

                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 45,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Name'
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Name is Empty";
                      }

                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 45,
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      counterText: "",
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Mobile '
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Mobile  is Empty";
                      }

                    },
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  height: 45,
                  child: TextFormField(
                    controller: designController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Designation '
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Designation in Required";
                      }

                    },
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    // showExitPopup();
                    _getFromGallery(true);
                  },
                  child: Container(
                    // height: MediaQuery.of(context).size.height/6,
                    height: imageFile == null ?70:100,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(5),
                      dashPattern: [5, 5],
                      color: Colors.grey,
                      strokeWidth: 2,
                      child: files.length > 0  ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("${files[0]}")),
                      ) :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child:
                            Column(
                              children: [
                                Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 30,),
                                Text("jpeg file",style: TextStyle(color: colors.red),)
                              ],
                            )

                        ),
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    // showExitPopup();
                    _getFromGallery(false);
                  },
                  child: Container(
                    // height: MediaQuery.of(context).size.height/6,
                    height: imageFile == null ?70:100,
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(5),
                        dashPattern: [5, 5],
                        color: Colors.grey,
                        strokeWidth: 2,
                        child: files1.length > 0  ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("${files1[0]}")),
                        ) :
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child:
                                  Column(
                                    children: [
                                      Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 30,),
                                      Text("pdf File",style: TextStyle(color: colors.red),)
                                    ],
                                  )

                          ),
                        ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Btn(
                  height: 50,
                  width: 320,
                  title: isloader == true ? "Please wait......" : 'Add Event Post',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      getEventPostApi();
                    } else {
                      setState(() {
                        isloader = false;
                      });
                      Fluttertoast.showToast(
                          msg:
                          "All Field are Required!!");
                    }
                  },
                ),
                SizedBox(height: 20,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
