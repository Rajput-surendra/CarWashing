import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/api/api_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../New_model/pharma_products_category_response.dart';

class AddProductSrcreen extends StatefulWidget {
  const AddProductSrcreen({Key? key,this.categoryData}) : super(key: key);
   final List<PharmaProductCategoryDataList>? categoryData ;

  @override
  State<AddProductSrcreen> createState() => _AddProductSrcreenState();
}



class _AddProductSrcreenState extends State<AddProductSrcreen> {

  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  File? newImageFile;
  bool isLoader = false;
  List<File> files = [];
  _getFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg', 'jpg']);
    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path!)).toList();
      });
      print("thi osko oi============>${files}");
    } else {
      // User canceled the picker
    }
  }
  // _getFromGallery1() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg', 'jpg']);
  //   if (result != null) {
  //     setState(() {
  //       files1 = result.paths.map((path) => File(path!)).toList();
  //     });
  //     print("thi osko oi============>${files1}");
  //   } else {
  //     // User canceled the picker
  //   }
  // }
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController indicationController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  PharmaProductCategoryDataList? dropdownInput;


  getAddProdctApi() async {
    isLoader = true ;
    setState(() {

    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? roll = preferences.getString('roll');
    var headers = {
      'Cookie': 'ci_session=779e238765203610de4772de6d8d19a39fbc2ff6'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addProductApi}'));
    request.fields.addAll({
      'user_id': '$userId',
       //'roll': '$roll',
      'product_name': nameController.text,
      'description': descriptionController.text,
      'indication': indicationController.text,
      'dosage': dosageController.text,
       'rx_info':infoController.text,
      'category': dropdownInput?.id.toString()?? ""
    });
    print("this is respoce=============>${request.fields}");
    if(files != null){
      request.files.add(await http.MultipartFile.fromPath('image', files[0].path ?? ''));
    }
    print('__________${request.files}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = jsonDecode(result);
      Navigator.pop(context);
      // print("thi os ojon==========>${finalResult}");
       Fluttertoast.showToast(msg: finalResult['message']);
      nameController.clear();
      descriptionController.clear();
      indicationController.clear();
      dosageController.clear();
      infoController.clear();
      dropdownInput = null;
      files.clear();
      setState(() {
        isLoader = false;
      });
    }
    else {
      setState(() {
        isLoader = false;
      });
      print(response.reasonPhrase);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('__________${widget.categoryData?.first.name}_________');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Add Products", isTrue: true, ),
      body: Padding(
        padding: EdgeInsets.only(left: 10,right: 10,top: 2),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Select Category"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.black54.withOpacity(0.4))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<PharmaProductCategoryDataList>(
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: const Text("Select Category"),
                          ),
                          isExpanded: true,
                          elevation: 0,
                          value: dropdownInput,
                          icon: const Icon(Icons.keyboard_arrow_down,size: 40,),
                          items:widget.categoryData!.map((PharmaProductCategoryDataList items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(items.name??''),
                                )
                            );
                          }
                          ).toList(),
                          onChanged: (PharmaProductCategoryDataList? newValue){
                            setState(() {
                              dropdownInput = newValue!;

                            });
                          },

                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Product Name"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 50,
                    child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Product Name',
                        ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Product Name are required";
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Short Description"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: ' Product Short Description',
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Product Short Description are required";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Indication"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    child: TextFormField(
                      controller: indicationController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Indication'
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Indication are required";
                        }

                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Dosage"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    child: TextFormField(
                      controller: dosageController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Dosage '
                      ), validator: (v) {
                      if (v!.isEmpty) {
                        return "Dosage are required";
                      }

                    },

                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Rx Info"),
                      Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    child: TextFormField(
                      controller: infoController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Rx Info'
                      ), validator: (v) {
                      if (v!.isEmpty) {
                        return "Rx Info are required";
                      }

                    },

                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Image"),
                      // Text("*",style: TextStyle(color: colors.red),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  InkWell(
                    onTap: (){
                      // showExitPopup();
                      _getFromGallery();
                    },
                    child: Container(
                      // height: MediaQuery.of(context).size.height/6,
                      height: imageFile == null ?50:100,
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
                          Center(child:Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 30,))

                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Btn(
                    height: 50,
                    width: double.infinity,
                    title: isLoader == true ? "Please wait......" : 'Add Product',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        getAddProdctApi();
                      } else {
                        setState(() {
                          isLoader = false;
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
