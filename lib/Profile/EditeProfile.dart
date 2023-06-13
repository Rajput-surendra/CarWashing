import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/getUserProfileModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';


class EditeProfile extends StatefulWidget {
  const EditeProfile({Key? key, required this.getUserProfileModel}) : super(key: key);
  final  GetUserProfileModel getUserProfileModel;

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();


  File? imageFile;
  File? registrationImage;
  final ImagePicker _picker = ImagePicker();
  bool? isFromProfile ;
  String? image;
  bool  isLodding = false;

  void requestPermission(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  //getFromGallery(i);
                  getImageGallery(ImgSource.Gallery, context ,i);
                },
                child: Container(
                  child: const ListTile(
                      title:  Text("Gallery"),
                      leading: Icon(
                        Icons.image,
                        color: colors.primary,
                      )),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  getImage(ImgSource.Camera, context, i);
                },
                child: Container(
                  child: const ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> getFromGallery(int i) async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        if(i==1){
          imageFile = File(result.files.single.path.toString());
        }else  if(i==2) {
          registrationImage = File(result.files.single.path.toString());
        }
      });
      Navigator.pop(context);

    } else {
      // User canceled the picker
    }
  }
  Future getImage(ImgSource source, BuildContext context, int i) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  Future getImageGallery(ImgSource source, BuildContext context, int i) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],

    );
    setState(() {
      if (i == 1) {
        imageFile = File(croppedFile!.path);
      } else if (i == 2) {
        registrationImage = File(croppedFile!.path);
      }

    });
    Navigator.pop(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    emailController.text = widget.getUserProfileModel.data?.first.email ?? '' ;
    nameController.text = widget.getUserProfileModel.data?.first.username ?? '' ;
    mobileController.text = widget.getUserProfileModel.data?.first.mobile?? '' ;
    addressController.text = widget.getUserProfileModel.data?.first.address?? '' ;

    getUserID();
    super.initState();
  }
  String? UserId;
  getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserId  =  preferences.getString('userId');
  }
  // updateProfileApi() async {
  //   setState(() {
  //         isLodding = true;
  //       });
  //
  //   var headers = {
  //     'Cookie': 'ci_session=98a8e696908fc6e2aaa9e4ce789a38eab96998d5'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getupdateUser}'));
  //   request.fields.addAll({
  //     'user_id': UserId.toString() ,
  //     'name': nameController.text,
  //     'email': emailController.text,
  //     'mobile': mobileController.text,
  //     'address': 'Indore Madhya Pradesh',
  //     'lat': '',
  //     'lng': ''
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color:colors.secondary,
              borderRadius: BorderRadius.circular(10)
          ),
          height: 50,
          child: InkWell(
              onTap: (){
                updateProfileApi();
              },
              child:isLodding ? Center(child: CircularProgressIndicator()) :Center(child: Text("Update Profile",style: TextStyle(color: colors.whiteTemp),))
          ),
        ),
      ),
      appBar: customAppBar(text: "",isTrue: true, context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            const SizedBox(height: 20,),
            Stack(
                children:[
                  imageFile == null
                      ?  SizedBox(
                    height: 110,
                    width: 110,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      elevation: 5,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(image.toString(), fit: BoxFit.fill,)
                        // Image.file(imageFile!,fit: BoxFit.fill,),
                      ),
                    ),
                  ) :

                  Container(
                    height: 110,
                    width: 110,
                    child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(imageFile ?? File(''),fit: BoxFit.fill)
                      // Image.file(imageFile!,fit: BoxFit.fill,),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      // top: 30,
                      child: InkWell(
                        onTap: (){
                          isFromProfile = true ;
                          requestPermission(context, 1);
                          // showExitPopup(isFromProfile ?? false);
                        },
                        child: Container(
                            height: 30,width: 30,
                            decoration: BoxDecoration(
                                color: colors.secondary,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Icon(Icons.camera_enhance_outlined,color: Colors.white,)),
                      ))
                ]
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Name", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'User Name',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),

                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Email Id", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email Id',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),

                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Mobile No", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),

                    TextFormField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: 'Mobile No',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),

                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Address", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      onTap: (){
                        _getLocation();
                      },
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }


  updateProfileApi() async{
    setState(() {
      isLodding = true;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId  =  preferences.getString('userId');
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getupdateUser}'));
    request.fields.addAll({
      'user_id': userId ?? '',
      "name":nameController.text,
      "email":emailController.text,
      "mobile":mobileController.text,
     "address":addressController.text,
     "lat":"",
     "lng":""


    });
    print("this os p spos pms oskm ms=========>${request.files}");
   // request.files.add(await http.MultipartFile.fromPath('registration_card', registrationImage?.path ?? ''  ));
   if(imageFile != null){
     request.files.add(await http.MultipartFile.fromPath('image', imageFile?.path ?? ''));
   }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.encode(result);
      print("thi os ojon==========>${finalResult}");
     // Fluttertoast.showToast(msg: finalResult['message']);
      Fluttertoast.showToast(msg:'Updated Successfully');
      Navigator.pop(context);
      setState(() {
        isLodding =  false;
      });
    }
    else {
      setState(() {
        isLodding = false;
      });
      print(response.reasonPhrase);
    }

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
      print('__________${lat}_____${long}____');
    });
  }
}
