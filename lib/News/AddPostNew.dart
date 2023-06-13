import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/api/api_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class AddPostNew extends StatefulWidget {
  const AddPostNew({Key? key}) : super(key: key);

  @override
  State<AddPostNew> createState() => _AddPostNewState();
}

class _AddPostNewState extends State<AddPostNew> {
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  File? newImageFile;
  File? newVideoFile;


  bool isloader = false;
  List<File> files = [];
  List<File> files3 = [];
  List<File> files1 = [];
  List<File> files2 = [];
  _getFromGallery(String type) async {
    FilePickerResult? result;
    if(type== 'jpeg'){
      result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg', 'jpg','mp4']);
    if (result != null) {
      setState(() {
        files1 = result!.paths.map((path) => File(path!)).toList();
        files= files1;
      });}}
    else if(type== 'pdf'){
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        setState(() {
          files2 = result!.paths.map((path) => File(path!)).toList();
          files= files2;
        });
      }
    }else if(type == 'video'){
      print('___________________');
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['mp4']);
      if (result != null) {
        setState(() {
          files3 = result!.paths.map((path) => File(path!)).toList();
          files= files3;
        });
      }
    }

  }
  TextEditingController titleController = TextEditingController();
  TextEditingController decController = TextEditingController();


  getPostNew() async {
    isloader = true;
    setState(() {

    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");

    var headers = {
      'Cookie': 'ci_session=f5c119f5040eaef28e6a4c420b14b794a449a6c4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addDoctorNews}'));
    request.fields.addAll({
      'user_id': '$userId',
      'roll': '$Roll',
      'title': titleController.text,
      'description': decController.text
    });
    print("getEventUserId--------------->${request.fields}");
    if(files != null){
      request.files.add(await http.MultipartFile.fromPath('image', files[0].path ?? ''));
    }
    print("files--------------->${request.files}");

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    final result =  await response.stream.bytesToString();
    final finalResult = json.decode(result);
    print("thi os ojon==========>${finalResult}");
    Fluttertoast.showToast(msg: finalResult['message']);
    titleController.clear();
    decController.clear();
    files.clear();
    Navigator.pop(context);
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
      appBar: customAppBar(context: context, text:"Add Post", isTrue: true, ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 45,
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Title'
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "title";
                      }

                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 45,
                  child: TextFormField(
                    controller: decController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Description'
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "description";
                      }

                    },
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    // showExitPopup();
                    _getFromGallery('jpeg');
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
                                Text("jpeg file",style: TextStyle(color: colors.red),)
                              ],
                            )

                        ),
                      ),

                    ),
                  ),
                ),
                Text("or"),
                InkWell(
                  onTap: (){
                    // showExitPopup();
                    _getFromGallery('pdf');
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
                      child: files2.length > 0  ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("${files2[0]}")),
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
                Text("or"),
                InkWell(
                  onTap: (){
                    // showExitPopup();
                    _getFromGallery('video');
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
                      child: files3.length > 0  ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("${files3[0]}")),
                      ) :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child:
                            Column(
                              children: [
                                Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 30,),
                                Text("video",style: TextStyle(color: colors.red),)
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
                  title: isloader == true ? "Please wait......" : 'Add Post',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      getPostNew();
                    } else {
                      setState(() {
                        isloader = false;
                      });
                      Fluttertoast.showToast(
                          msg:
                          "Please Enter Correct Credentials!!");
                    }
                  },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
