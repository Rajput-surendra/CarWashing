import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helper/Color.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import '../../New_model/GetEventModel.dart';
import '../../api/api_services.dart';

class EventsListCard extends StatefulWidget {
  const EventsListCard({Key? key,required this.index, required this.i, this.getEventModel }) : super(key: key);

  final int index;
  final int i;
  final EventDataList? getEventModel;

  @override
  State<EventsListCard> createState() => _EventsListCardState();
}

class _EventsListCardState extends State<EventsListCard> {
  GlobalKey keyList =GlobalKey() ;
  bool _isReady = true ;
  bool iconVisible = true;

  void initState() {
    // TODO: implement initState
    //keyList =  List.generate(1000, (_) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isReady = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: keyList,
      child:_isReady ?  Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child:  Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 8),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("${widget.getEventModel?.userImage}"),
                            backgroundColor: colors.primary,
                            radius: 25,
                          ),
                        ), //CircleAvatar
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.getEventModel?.userName}",style: TextStyle(fontSize: 14,color: colors.secondary),),
                              Text("${widget.getEventModel?.userAddress}",style: TextStyle(fontSize: 10),),
                              Container(
                                // width: 250,
                                  child: Text("${widget.getEventModel?.userDigree}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    iconVisible ? Row(
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                            iconVisible = false;
                          });
                          Future.delayed(Duration(milliseconds: 500), (){
                            //_CaptureScreenShot(index: index);
                            _shareQrCode(widget.getEventModel?.link ?? '');
                            // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                          });

                        }, icon: Icon(Icons.share)),
                        IconButton(onPressed: (){
                          setState(() {
                            getNewWishlistApi(widget.getEventModel?.id ?? '', widget.getEventModel?.type ?? "");
                            widget.getEventModel?.isSelected = !(widget.getEventModel?.isSelected ?? false );
                          });
                        },icon: widget.getEventModel?.isFav ?? false ? Icon(Icons.favorite,color: colors.red,): widget.getEventModel?.isSelected ?? false ?Icon(Icons.favorite,color: colors.red,) :  Icon(Icons.favorite_outline,color: colors.red,))
                      ],
                    ):SizedBox.shrink()

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      width: double.infinity,
                      child:  DecoratedBox(
                        decoration:  BoxDecoration(
                          // image: DecorationImage(
                          //   image: NetworkImage("${widget.getEventModel?.image}"),
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        child: widget.getEventModel?.image == null || widget.getEventModel?.image == ""?Image.asset("assets/splash/splashimages.png"):Image.network("${widget.getEventModel?.image}",fit: BoxFit.fill)
                      ),

                    ),
                    // Container(
                    //   child: AspectRatio(
                    //     aspectRatio: 12/9, //aspect ratio for Image
                    //     child:widget.getEventModel?.image == null || widget.getEventModel?.image == " " ? Image.asset("assets/images/Events banner.png",): Image(
                    //       image: NetworkImage("${widget.getEventModel?.image}"),
                    //       fit: BoxFit.cover, //fill type of image inside aspectRatio
                    //     ),
                    //   ),
                    // ),
                widget.index == 0 ?  Text("Surendra") : SizedBox(),
                  // Container(
                  //   width: double.infinity,
                  //   child: widget.getEventModel?.image == null || widget.getEventModel?.image == " " ? Image.asset("assets/images/Events banner.png",):ClipRRect(
                  //       borderRadius:  BorderRadius.circular(5),
                  //       child: Image.network("${widget.getEventModel?.image}",fit: BoxFit.cover,height: 150,)),
                  // ),
                  SizedBox(height: 8,),
                  Text("${widget.getEventModel?.address}",),
                    SizedBox(height: 5,),
                  Text("${widget.getEventModel?.startDate}"),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('${widget.getEventModel?.title}'),
                  //     Text("Address${widget.getEventModel?.address}")
                  //
                  //   ],
                  // ),
                  // SizedBox(height: 2,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //  Text('Start Date:',style: TextStyle(color: colors.secondary),),
                  //     Text("${widget.getEventModel?.startDate}")
                  //
                  //   ],
                  // ),
                  const SizedBox(height: 10,),

                ],),

              ],
            ),
          )

      ) : SizedBox(),
    );
  }

  // _shareQrCode(String text) async {
  //   iconVisible = true ;
  //   var status =  await Permission.photos.request();
  //   // PermissionStatus storagePermission = await Permission.storage.request();
  //   if (/*storagePermission == PermissionStatus.granted*/status.isGranted) {
  //     final directory = (await getApplicationDocumentsDirectory()).path;
  //
  //     RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     /*if(bound.debugNeedsPaint){
  //       Timer(Duration(seconds: 1),()=>_shareQrCode(text));
  //       return null;
  //     }*/
  //     ui.Image image = await bound.toImage();
  //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //
  //     print('${byteData?.buffer.lengthInBytes}___________');
  //     // this will save image screenshot in gallery
  //     if(byteData != null ){
  //       Uint8List pngBytes = byteData.buffer.asUint8List();
  //       String fileName = DateTime
  //           .now()
  //           .microsecondsSinceEpoch
  //           .toString();
  //       final imagePath = await File('$directory/$fileName.png').create();
  //       await imagePath.writeAsBytes(pngBytes);
  //       Share.shareFiles([imagePath.path],text: text,);
  //       // final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}.png');
  //       //print(resultsave);
  //     }
  //     /*_screenshotController.capture().then((Uint8List? image) async {
  //       if (image != null) {
  //         try {
  //           String fileName = DateTime
  //               .now()
  //               .microsecondsSinceEpoch
  //               .toString();
  //
  //           final imagePath = await File('$directory/$fileName.png').create();
  //           if (imagePath != null) {
  //             await imagePath.writeAsBytes(image);
  //             Share.shareFiles([imagePath.path],text: text);
  //           }
  //         } catch (error) {}
  //       }
  //     }).catchError((onError) {
  //       print('Error --->> $onError');
  //     });*/
  //   } else if (await status.isDenied/*storagePermission == PermissionStatus.denied*/) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('This Permission is recommended')));
  //   } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
  //     openAppSettings().then((value) {
  //
  //     });
  //   }
  // }
  _shareQrCode(String text) async {
    iconVisible = true ;
    var status =  await Permission.photos.request();
    // PermissionStatus storagePermission = await Permission.storage.request();
    if (/*storagePermission == PermissionStatus.granted*/status.isGranted) {
      final directory = (await getApplicationDocumentsDirectory()).path;

      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      /*if(bound.debugNeedsPaint){
        Timer(Duration(seconds: 1),()=>_shareQrCode(text));
        return null;
      }*/
      ui.Image image = await bound.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      print('${byteData?.buffer.lengthInBytes}___________');
      // this will save image screenshot in gallery
      if(byteData != null ){
        Uint8List pngBytes = byteData.buffer.asUint8List();
        String fileName = DateTime
            .now()
            .microsecondsSinceEpoch
            .toString();
        final imagePath = await File('$directory/$fileName.png').create();
        await imagePath.writeAsBytes(pngBytes);
        Share.shareFiles([imagePath.path],text: text);
        // final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}.png');
        //print(resultsave);
      }
      /*_screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          try {
            String fileName = DateTime
                .now()
                .microsecondsSinceEpoch
                .toString();

            final imagePath = await File('$directory/$fileName.png').create();
            if (imagePath != null) {
              await imagePath.writeAsBytes(image);
              Share.shareFiles([imagePath.path],text: text);
            }
          } catch (error) {}
        }
      }).catchError((onError) {
        print('Error --->> $onError');
      });*/
    } else if (await status.isDenied/*storagePermission == PermissionStatus.denied*/) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This Permission is recommended')));
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {

      });
    }
  }

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

}
