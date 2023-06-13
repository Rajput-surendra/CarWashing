import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/New_model/GetSliderModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:doctorapp/widgets/widgets/commen_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetEditorialmodel.dart';
import '../widgets/widgets/editorial_list_card.dart';
import 'AddEditorialPost.dart';
import 'package:http/http.dart' as http;

class Editorial extends StatefulWidget {
  const Editorial({Key? key}) : super(key: key);

  @override
  State<Editorial> createState() => _EditorialState();
}

class _EditorialState extends State<Editorial> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderApi();
    getEdiorialApi();

    String date = dateTime.substring(11,16);
    print("aaaaaaaaaaaaa====>${date}");
  }
  String? specialityId;
  String dateTime = '2023-03-24 16:09:30';

  GetEditorialmodel? editorialmodel;
  getEdiorialApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? Roll = preferences.getString('roll');
    specialityId = preferences.getString('specialityId');
    String? localId = preferences.getString('LocalId');
    print("getEventUserId--------------->${userId}");
    print("getRoll--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=ac2ad75ade0fea45b016a264f634bc030be7f15b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getEditorial}'));
    request.fields.addAll({
      'user_id': '$userId',
      'speciality_id': localId==null || localId== '' ?  specialityId ?? '' : localId
    });
    print("getRollwwwwwwwwwww--------------->${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     final result =  await response.stream.bytesToString();
     final finalResult = GetEditorialmodel.fromJson(jsonDecode(result));
     print("getEventUserId---------------fdfdgfdgdgfdgd>${finalResult}");
     setState(() {
       editorialmodel =  finalResult;
       geteditorialList = editorialmodel?.data ?? [] ;
     });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future _refresh() {
    return callApi();
  }
  Future callApi() async {
    getEdiorialApi();
  }
  bool isSelected =false;
  bool iconVisible = true;

  downloadFile(String url, String filename) async {
    FileDownloader.downloadFile(
        url: "${url}",
        name: "${filename}",
        onDownloadCompleted: (path) {
          print(path);
          String tempPath = path.toString().replaceAll("Download", "doctorapp");
          final File file = File(tempPath);
          print("path here ${file}");
          var snackBar = SnackBar(
            backgroundColor: colors.primary,
            content: Row(
              children: [
                const Text('doctorapp Saved in your storage'),
                TextButton(onPressed: (){}, child: Text("View"))

              ],
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //This will be the path of the downloaded file
        });
  }
  Future<String> createFolderInAppDocDir(String folderNames) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.accessMediaLocation,
      // Permission.manageExternalStorage,
      Permission.storage,
    ].request();
    // var manage = await Permission.manageExternalStorage.status;
    var media = await Permission.accessMediaLocation.status;
    if(media==PermissionStatus.granted){

      print(statuses[Permission.location]);
      final folderName = folderNames;
      final path= Directory("storage/emulated/0/$folderName");
      final path1 =  await getExternalStorageDirectory();
      print("ssdsds ${path1}");
      print("11111111111 ${path}");
      var status = await Permission.storage.status;
      print("mmmmmmmmmmm ${status} and ${status.isGranted}");
      if (!status.isGranted) {
        print("chacking status ${status.isGranted}");
        await Permission.storage.request();
      }
      print(" path here ${path} and ${await path.exists()}");
      if ((await path.exists())) {
        print("here path is ${path}");
        // var dir = await DownloadsPathProvider.
        print("ooooooooo and $path/$folderNames");
        return path.path;
      } else {
        print("here path is 1 ${path}");
        path.create();
        return path.path;
      }}else{
      print("permission denied");
    }
    return "";
  }

  _shareQrCode() async {
    PermissionStatus storagePermission = await Permission.storage.request();
    if (storagePermission == PermissionStatus.granted) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          try {
            String fileName = DateTime
                .now()
                .microsecondsSinceEpoch
                .toString();
            final imagePath = await File('$directory/$fileName.png').create();
            if (imagePath != null) {
              await imagePath.writeAsBytes(image);
              Share.shareFiles([imagePath.path],);
            }
          } catch (error) {}
        }
      }).catchError((onError) {
        print('Error --->> $onError');
      });
    } else if (storagePermission == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This Permission is recommended')));
    } else if (storagePermission == PermissionStatus.permanentlyDenied) {
      openAppSettings().then((value) {

      });
    }
  }



  // _CarouselSlider1(){
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //         onPageChanged: (index, result) {
  //           setState(() {
  //             _currentPost = index;
  //           });
  //         },
  //         viewportFraction: 1.0,
  //         initialPage: 0,
  //         enableInfiniteScroll: true,
  //         reverse: false,
  //         autoPlay: true,
  //
  //         autoPlayInterval: const Duration(seconds: 5),
  //         autoPlayAnimationDuration:
  //         const Duration(milliseconds: 500),
  //
  //         enlargeCenterPage: false,
  //         scrollDirection: Axis.horizontal,
  //         height: 200.0),
  //     items: _sliderModel?.data?.map((item) {
  //       return CommonSlider(file: item.image ?? '', link: item.link ?? '');
  //     }).toList(),
  //   );
  //
  // }


  getNewWishlistApi(String id, String event) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=3d55d84af76cc51db413ee4ccdea5fff824134e1'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addNewWishListApi}'));
    request.fields.addAll({
      'roll': '$Roll',
      'user_id': '$userId',
      'prod_id': '$id',
      'status': '1',
      'type': '$event'
    });
    print("this is data------------->${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      Fluttertoast.showToast(msg: finalResult['message']);


    }
    else {
      print(response.reasonPhrase);
    }

  }
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    String type = '/editorial_slide';
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getSlider}$type'));
    request.headers.addAll(headers);
    print("fieldss===========>${request.url}");
    http.StreamedResponse response = await request.send();
    print("response.statusCode===========>${response.statusCode}");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========>${result}");
      final finalResult = GetSliderModel.fromJson(json.decode(result));
      print("this is a response===========>${finalResult}");
      setState(() {
        _sliderModel = finalResult;

      });
    } else {
      print(response.reasonPhrase);
    }
  }
  List <GetEdoDataList> geteditorialList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
       child: RefreshIndicator(
         onRefresh: _refresh,
         child: Scaffold(
           floatingActionButton: FloatingActionButton(
             onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEditoilPost()));
             },
             backgroundColor: colors.secondary,
             child: Icon(Icons.add),
           ),
          appBar: customAppBar(context: context, text:"Editorial", isTrue: true, ),
            body: SingleChildScrollView(
             child: Column(
              children:<Widget> [
                // SizedBox(height: 10,),
                // _sliderModel== null ? Center(child: CircularProgressIndicator(),) :_CarouselSlider1(),
                // SizedBox(height: 5,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:  _buildDots(),),

                // Stack(
                //   alignment: Alignment.bottomCenter,
                //   children: [
                //     SizedBox(
                //       height: 200,
                //       width: double.maxFinite,
                //       child: _sliderModel == null? Center(child: CircularProgressIndicator(
                //         color: colors.primary,
                //       )):_CarouselSlider1(),
                //     ),
                //     Positioned(
                //       bottom: 20,
                //       // left: 80,
                //       child:
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children:  _buildDots(),),
                //     ),
                //
                //   ],
                //
                // ),
                SizedBox(
                  child: editorialmodel?.data == null ? Center(child: CircularProgressIndicator())  : editorialmodel?.data.isEmpty?? false ? Text("No Data Found !!"):
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: editorialmodel!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return EditorialListCard(index: geteditorialList.length,getEdoDataList: geteditorialList[index] , );
                      }),
                  ),
              ],
            ),
          ),
      ),
       ),
    );
  }

  int _currentPost =  0;

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < (_sliderModel?.data?.length ?? 10); i++) {
      dots.add(
        Container(
          margin: EdgeInsets.all(1.5),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPost == i
                ? colors.primary
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      );
    }
    return dots;
  }


}
