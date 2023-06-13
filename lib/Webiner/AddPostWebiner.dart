import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../api/api_services.dart';

class AddPostWebiner extends StatefulWidget {
  const AddPostWebiner({Key? key}) : super(key: key);

  @override
  State<AddPostWebiner> createState() => _AddPostWebinerState();
}

class _AddPostWebinerState extends State<AddPostWebiner> {

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
  TextEditingController doctoreController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController SpeakerController = TextEditingController();
  TextEditingController moderatorController = TextEditingController();
  TextEditingController topictController = TextEditingController();

  addDoctorWebinarApi() async {
    setState(() {
      isloader == true;

    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");

    var headers = {
      'Cookie': 'ci_session=f5c119f5040eaef28e6a4c420b14b794a449a6c4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addDoctorWebiner}'));
    request.fields.addAll({
      'user_id': '$userId',
      'roll': '$Roll',
      'title':doctoreController.text,
      'link':linkController.text,
      'topic':topictController.text,
      'speaker':SpeakerController.text,
      'moderator':moderatorController.text,
      'start_date':startDateController.text,
      'from_time':startTimeController.text

     // "description":decController.text,

    });
    print("getEventUserId--------------->${request.fields}");
    if(files != null){
      request.files.add(await http.MultipartFile.fromPath('image', files[0].path ?? ''));
    }
    print("filesqqqqqq--------------->${request.files}");

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(jsonEncode(result));

      print("thi os ojon==========>${finalResult}");
      Fluttertoast.showToast(msg: 'Webinar Added Successfully');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
     doctoreController.clear();
     linkController.clear();
     topictController.clear();
     SpeakerController.clear();
     moderatorController.clear();
     startDateController.clear();
     startTimeController.clear();
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

  TimeOfDay? selectedTime1 ;
  TimeOfDay? selectedTime2;
  _selectStartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        useRootNavigator: true,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: colors.primary),
                buttonTheme: const ButtonThemeData(
                    colorScheme: ColorScheme.light(primary: colors.primary))),
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!),
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime1) {
      setState(() {
        selectedTime1 = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
         startTimeController.text = selectedTime1!.format(context);

      });
    }
    var per = selectedTime1!.period.toString().split(".");
     //startTimeController.text = "${selectedTime1!.format(context).toString()}  ${per[1]}";
    print(
        "selected time here ${selectedTime1!.format(context).toString()} and ${per[1]}");
  }
  _selectEndTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        useRootNavigator: true,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: colors.primary),
                buttonTheme: ButtonThemeData(
                    colorScheme: ColorScheme.light(primary: colors.primary))),
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!),
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime1) {
      setState(() {
        selectedTime1 = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
        endTimeController.text = selectedTime1!.format(context);
      });
    }
    var per = selectedTime1!.period.toString().split(".");
    //endTimeController.text = "${selectedTime1!.format(context).toString()}  ${per[1]}";
    print(
        "selected time here ${selectedTime1!.format(context).toString()} and ${per[1]}");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Add Webinar", isTrue: true, ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Text("Title"),
                  SizedBox(height: 5,),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: doctoreController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Title',
                      )
                    ),
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Topic"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    child: TextFormField(
                      controller: topictController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        hintText: 'Topic',
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Topic are required";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Speaker"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    child: TextFormField(
                      controller: SpeakerController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        hintText: 'Speaker'
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Speaker are required";
                        }

                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Moderator"),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    child: TextFormField(
                      controller: moderatorController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Moderator '
                      ),

                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Date"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
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
                        hintText: 'Date',
                        contentPadding: EdgeInsets.only(left: 10)
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Date is required";
                      }

                    },
                  ),
                  // SizedBox(height: 10,),
                  // TextFormField(
                  //   onTap: (){
                  //     _selectDateEnd();
                  //   },
                  //   controller:endDateController,
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       counterText: "",
                  //       hintText: 'EndTDate',
                  //       contentPadding: EdgeInsets.only(left: 10)
                  //   ),
                  //   validator: (v) {
                  //     if (v!.isEmpty) {
                  //       return "EndTDate is required";
                  //     }
                  //
                  //   },
                  // ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Time"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    onTap: (){
                     _selectStartTime(context);
                    },
                    controller:startTimeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        counterText: "",
                        hintText: 'Time',
                        contentPadding: EdgeInsets.only(left: 10)
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Time is required";
                      }

                    },
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Link"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    child: TextFormField(
                      controller: linkController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        hintText: 'Link'

                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Link are required";
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
                                children: const [
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
                    title: isloader == true ? "Please wait......" : 'Add Post Webinar',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        addDoctorWebinarApi();
                      } else {
                        setState(() {
                          isloader = false;
                        });
                        Fluttertoast.showToast(
                            msg:
                            "All Field required");
                      }
                    },
                  ),
                  SizedBox(height: 20,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
