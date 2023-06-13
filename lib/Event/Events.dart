import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/Event/event_deatils.dart';
import 'package:doctorapp/New_model/GetSliderModel.dart';
import 'package:doctorapp/widgets/widgets/commen_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../Helper/customcard.dart';
import '../New_model/GetEventModel.dart';
import '../api/api_services.dart';
import '../widgets/widgets/events_list_card.dart';
import 'AddEventPost.dart';

import 'package:http/http.dart'as http;

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key, }) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}
final GlobalKey _key = GlobalKey();

class _EventsScreenState extends State<EventsScreen> {
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
      'type': '$event',
      'speciality_id':"$id"
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
    String? localId = preferences.getString('LocalId');
    print("getEventUserId--------------->${userId}");
    print("getRoll--------------->${specialityId}");
    var headers = {
      'Cookie': 'ci_session=24cf09ce78eebd805097f2d1bcece02c6e418346'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getEvents}'));
    request.fields.addAll({
      'user_id': '$userId',
      'roll': '$Roll',
       'speciality_id': localId==null || localId== '' ? specialityId ?? '' : localId
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderApi();

    Future.delayed(Duration(milliseconds: 500),(){
      getEventList();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isReady = true;
      });
    });

    String date = dateTime.substring(11,16);
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


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEventPost()));
          },
          backgroundColor: colors.secondary,
          child: Icon(Icons.add),
        ),
        appBar: customAppBar(context: context, text:"Events", isTrue: true, ),
        body: SingleChildScrollView(
          child: Column(
            children:[
              // Stack(
              //   alignment: Alignment.bottomCenter,
              //   children: [
              //     SizedBox(
              //       height: 200,
              //       child: _sliderModel == null? const Center(child: CircularProgressIndicator(
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
              //   ],
              // ),
              eventModel == null ? Center(child: CircularProgressIndicator(),) : SizedBox(
                child:  eventModel?.data == null ? Center(child: CircularProgressIndicator())  : eventModel?.data.isEmpty?? false ? Text("No Data Found !!!!"):
                ListView.builder(
                    // scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: eventModel!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDeatils(getEventModel: eventDataList[index])));
                        },
                          child: EventsListCard(index: eventDataList.length, getEventModel: eventDataList[index],i: index,));
                    }),
              ),
            ],
          ),
        ),
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

  // _shareQrCode() async {
  //   iconVisible =  true;
  //   final Rect? box = Rect.largest;
  //   PermissionStatus storagePermission = await Permission.storage.request();
  //   if (storagePermission == PermissionStatus.granted) {
  //     final directory = (await getApplicationDocumentsDirectory()).path;
  //     screenshotController.capture(delay: Duration(milliseconds: 10)).then((Uint8List? image) async {
  //       if (image != null) {
  //         try {
  //           String fileName = DateTime
  //               .now()
  //               .microsecondsSinceEpoch
  //               .toString();
  //           final imagePath = await File('$directory/$fileName.png').create();
  //           if (imagePath != null) {
  //             await imagePath.writeAsBytes(image);
  //             Share.shareXFiles( [XFile(image1)] ) ;
  //           }
  //         } catch (error) {}
  //       }
  //     }).catchError((onError) {
  //       print('Error --->> $onError');
  //     });
  //   } else if (storagePermission == PermissionStatus.denied) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('This Permission is recommended')));
  //   } else if (storagePermission == PermissionStatus.permanentlyDenied) {
  //     openAppSettings().then((value) {
  //
  //     });
  //   }
  // }
  _shareQrCode() async {
    iconVisible = true;
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
