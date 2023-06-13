import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/Event/Events.dart';
import 'package:doctorapp/Webiner/AddPostWebiner.dart';
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
import '../New_model/GetEventModel.dart';
import '../New_model/GetSliderModel.dart';
import '../New_model/GetWebinarModel.dart';
import '../Webiner/Online_webinar.dart';
import '../api/api_services.dart';
import '../widgets/widgets/commen_slider.dart';
import '../widgets/widgets/events_list_card.dart';
import '../widgets/widgets/news_update_list_card.dart';
import 'package:http/http.dart'as http;

import '../widgets/widgets/onlinewebnar_list_card.dart';
import 'AddEventPost.dart';
import 'event_deatils.dart';

class EventAndWebiner extends StatefulWidget {
  const EventAndWebiner({Key? key}) : super(key: key);

  @override
  State<EventAndWebiner> createState() => _EventAndWebinerState();
}

class _EventAndWebinerState extends State<EventAndWebiner> {

  bool _isReady = false;
  bool isSelected =  false;
  GetEventModel? eventModel;
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
  getEventList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? Roll = preferences.getString('roll');
    String? specialityId = preferences.getString('specialityId');
    print("getEventUserId--------------->${userId}");
    print("getRoll--------------->${specialityId}");
    var headers = {
      'Cookie': 'ci_session=24cf09ce78eebd805097f2d1bcece02c6e418346'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getEvents}'));
    request.fields.addAll({
      'user_id': '$userId',
      'roll': '$Roll',
      'speciality_id':"$specialityId"
    });
    print("this is is request=========>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final result  = await response.stream.bytesToString();
      final FinalResult = GetEventModel.fromJson(jsonDecode(result));
      print("this is a Event=============>${FinalResult}");

      eventModel = FinalResult ;

      eventDataList = FinalResult.data ;
    }
    else {
      print(response.reasonPhrase);
    }

  }
  ScreenshotController screenshotController = ScreenshotController();
  bool iconVisible = true;
  getNewWishlistaaApi(String id ,event) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? specialityId = preferences.getString('specialityId');
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
      'type': '$event',
      'speciality_id':"${specialityId}"
    });
    print("this is data------------->${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");

      Fluttertoast.showToast(msg: finalResult['message']);
      Navigator.pop(context);
    }
    else {
      print(response.reasonPhrase);
    }

  }

  GetWebinarModel? webinarModel;

  getOnlineWebinarApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? Roll = preferences.getString('roll');
    String? id = preferences.getString('sId');
    print("getOnlineWebinarUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=ff45191bc42e12d2471ecac1e726d8107925e77c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getWebinar}'));
    request.fields.addAll({
      'user_id': '$userId',
      'roll': '$Roll',
      'speciality_id':"$id"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = GetWebinarModel.fromJson(jsonDecode(result));
      print("OnlineWebinar--------------->${finalResult}");
      setState(() {
        webinarModel = finalResult;
        webinarModel?.data?.reversed;
        getWebnDataList =  webinarModel?.data ?? [] ;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  List <GetWebnDataList> getWebnDataList = [] ;
  downloadFile(String url, String filename) async {
    FileDownloader.downloadFile(
        url: "${url}",
        name: "${filename}",
        onDownloadCompleted: (path) {
          print(path);
          String tempPath = path.toString().replaceAll("Download", "DR Apps");
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderApi();
    getSliderApi();
    Future.delayed(Duration(seconds: 1),(){
      getOnlineWebinarApi();
    }) ;
    String date = dateTime.substring(11,16);
    Future.delayed(Duration(milliseconds: 500),(){
      getEventList();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isReady = true;
      });
    });
    // String date = dateTime.substring(11,16);
    print("aaaaaaaaaaaaa====>${date}");
  }
  String dateTime = '2023-03-25 13:45:05';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getEventList();
  }
  List <EventDataList> eventDataList = [] ;
  int _currentIndex = 1 ;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      key: _refreshIndicatorKey,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(_currentIndex == 1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEventPost()));
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPostWebiner()));
              }

            },
            backgroundColor: colors.secondary,
            child: Icon(Icons.add),
          ),
          appBar: customAppBar(context: context, text:"Event & Online Webinar", isTrue: true, ),
        body:
        ListView(
          children: [
            eventabbar(),
          ],
        )
      ),
    );
  }
  eventabbar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 1;
                  // getNewListApi(1);

                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 1 ?
                    colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                height: 45,
                child: Center(
                  child: Text("Event",style: TextStyle(color: _currentIndex == 1 ?colors.whiteTemp:colors.blackTemp,fontSize: 18)),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 2;
                  // getNewListApi(3);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 2 ?
                    colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                // width: 120,
                height: 45,
                child: Center(
                  child: Text("Online Webinars",style: TextStyle(color: _currentIndex == 2 ?colors.whiteTemp:colors.blackTemp,fontSize: 18),),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
  int _currentPost =  0;
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < (_sliderModel?.data?.length ?? 10) ; i++) {
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
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    String type = '/event_slide';
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


}
