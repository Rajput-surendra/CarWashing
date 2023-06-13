import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../api/api_services.dart';

class AddPosterScreen extends StatefulWidget {
  const AddPosterScreen({Key? key}) : super(key: key);

  @override
  State<AddPosterScreen> createState() => _AddPosterScreenState();
}

class _AddPosterScreenState extends State<AddPosterScreen> {
  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();
  }
  getRole() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');
    role = preferences.getString('roll');
    print('_______sadsadasdas___${role}_________');
  }
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  File? newImageFile;
  bool isloader = false;
  List<File> files = [];
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
        });
      }
    }

  }
  List<File> filesVideo = [];
  _getFromGalleryVideo(bool type) async {
    FilePickerResult? result;
    if(type){
      result = await FilePicker.platform.pickFiles(type: FileType.video);}
    if (result != null) {
      setState(() {
        filesVideo = result!.paths.map((path) => File(path!)).toList();
      });}
    else {
      result = await FilePicker.platform.pickFiles(
          type: FileType.video);
      if (result != null) {
        setState(() {
        });
      }
    }

  }
  TextEditingController linkController = TextEditingController();
  String? role;
  getUploadBannerNewApi() async {
    setState(() {
      isloader = true;
    });
    var headers = {
      'Cookie': 'ci_session=f5c119f5040eaef28e6a4c420b14b794a449a6c4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUploadBannerApi}'));
    request.fields.addAll({
      'user_id': '$userId',
      'link': linkController.text,
      if(role == "1" )
       'type': role == "1" ? "" : dropdownInput
    });
    print("getEventUserId--------------->${request.fields}");
    if(_value == 1) {
      if (filesVideo != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'image',  filesVideo[0].path ?? '' ));
      }
    }else{
      if (files != null) {
        print('__________3_________');
        request.files.add(await http.MultipartFile.fromPath(
            'image',  files[0].path ?? '' ));
      }
    }

    print("files--------------->${request.files}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      Fluttertoast.showToast(msg: finalResult['message']);
      linkController.clear();
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
  int _value = 1;
  bool isVideo = false;
  bool isImage = false;
  var dropdownInput ;
  List<Map<String, dynamic>> list = [
    {'id': 'doctor_news_slide', 'name' : 'New'},
    {'id': 'event_slide', 'name' : 'Event'},
    {'id': 'webinar_slide', 'name' : 'Webinar'},
    {'id': 'pharma_product_slide', 'name' : 'Pharma Product'},
    {'id': 'editorial_slide', 'name' : 'Editorial'},
    {'id': 'awareness', 'name' : 'Awareness '},

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Btn(
            height: 50,
            title: isloader == true ? "Please wait......" : 'Upload Banner ',
            onPress: () {
              getUploadBannerNewApi();
            },
          ),
        ),
      ),
      appBar: customAppBar(context: context, text:"Upload Banner", isTrue: true, ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 10),
        child: Form(
          // key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
             Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 1,
                    fillColor: MaterialStateColor.resolveWith(
                            (states) =>  colors.secondary),
                    activeColor:  colors.secondary,
                    groupValue: _value,
                    onChanged: (int? value) {
                      setState(() {
                        _value = value!;
                        isVideo = false;
                      });
                    },
                  ),
                  Text(
                    "Video",
                    style: TextStyle(
                        color: colors.secondary, fontSize: 21),
                  ),
                  Radio(
                      value: 2,
                      fillColor: MaterialStateColor.resolveWith(
                              (states) => colors.secondary),
                      activeColor:   colors.secondary,
                      groupValue: _value,
                      onChanged: (int? value) {
                        setState(() {
                          _value = value!;
                          isImage = true;
                        });
                      }),
                  // SizedBox(width: 10.0,),
                  Text(
                    "Images",
                    style: TextStyle(
                        color:  colors.secondary, fontSize: 21),
                  ),
                ],
              ),
              role == "1" ? SizedBox.shrink():Container(
                  padding: EdgeInsets.only(right: 5, top: 5),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all( color: colors.black54),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      hint: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text("Awareness Input Upload",
                          style: TextStyle(
                              color: colors.black54,fontWeight: FontWeight.normal
                          ),),
                      ),
                      // dropdownColor: colors.primary,
                      value: dropdownInput,
                      icon:  Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                      // elevation: 16,
                      style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                      underline: Container(
                        // height: 2,
                        color:  colors.whiteTemp,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownInput = value!;
                        });


                      },

                      items: list.map((items) {
                        return DropdownMenuItem(
                          value: items['id'].toString(),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Container(
                                    width: 250,
                                    child: Text(items['name'].toString(),overflow:TextOverflow.ellipsis,style: TextStyle(color:colors.black54,fontWeight: FontWeight.normal),)),
                              ),
                              Divider(
                                thickness: 0.2,
                                color: colors.black54,
                              )
                            ],
                          ),

                        );
                      }).toList(),

                    ),
                  )
              ),
              SizedBox(height: 20,),
              _value == 1  ?   InkWell(
                onTap: (){
                  // showExitPopup();
                  _getFromGalleryVideo(true);
                },
                child: Container(
                  // height: MediaQuery.of(context).size.height/6,
                  height: newImageFile == null ?60:120,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5),
                    dashPattern: [5, 5],
                    color: Colors.grey,
                    strokeWidth: 2,
                    child: filesVideo.length > 0  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("${filesVideo[0]}")),
                    ) :
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                          child:
                          Column(
                            children: [
                              Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 25,),
                              Text("Video file Upload",style: TextStyle(color: colors.red),)
                            ],
                          )

                      ),
                    ),

                  ),
                ),
              ):InkWell(
                onTap: (){
                  // showExitPopup();
                  _getFromGallery(true);
                },
                child: Container(
                  // height: MediaQuery.of(context).size.height/6,
                  height: imageFile == null ?60:120,
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
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                          child:
                          Column(
                            children: [
                              Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 25,),
                              Text("Banner file Upload",style: TextStyle(color: colors.red),)
                            ],
                          )

                      ),
                    ),

                  ),
                ),
              ),

              SizedBox(height: 20,),
              Container(
                height: 50,
                child: TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '(Link Optional)'
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Link is required";
                    }
                  },
                ),
              ),

              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
