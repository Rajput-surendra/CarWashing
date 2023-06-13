import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helper/Color.dart';
import '../../New_model/GetWebinarModel.dart';
import 'package:http/http.dart'as http;

import '../../api/api_services.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

class OnlineWebinarListCard extends StatefulWidget {
  const OnlineWebinarListCard({Key? key, required this.index, this.getWebinarDataList}) : super(key: key);

  final int index;
  final GetWebnDataList? getWebinarDataList;

  @override
  State<OnlineWebinarListCard> createState() => _OnlineWebinarListCardState();
}


class _OnlineWebinarListCardState extends State<OnlineWebinarListCard> {

  GlobalKey keyList = GlobalKey() ;
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
    return  RepaintBoundary(
      key: keyList,
      child: _isReady ? Column(
        children: [
          Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Container(
                  height: 30,
                  width:MediaQuery.of(context).size.width/1.0,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${widget.getWebinarDataList?.date.toString().substring(0,10)}',style: TextStyle(color: Colors.white,fontSize: 15),),
                      SizedBox(width: 20,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: VerticalDivider(thickness: 1,color: colors.whiteTemp,),
                      ),
                      SizedBox(width: 20,),
                      Text('${widget.getWebinarDataList?.fromTime.toString()}',style: TextStyle(color: Colors.white,fontSize: 15),),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0,bottom: 8,left: 5),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage("${widget.getWebinarDataList?.userImage}"),
                                backgroundColor: colors.primary,
                                radius: 25,
                              ),
                            ), //CircleAvatar
                            Padding(
                              padding: const EdgeInsets.only(left: 5,bottom: 15),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Title: ${widget.getWebinarDataList?.title}",style: TextStyle(fontSize: 14,color: colors.secondary),),
                                  SizedBox(height: 3,),
                                  Text("Topic: ${widget.getWebinarDataList?.topic}",style: TextStyle(fontSize: 10),),
                                  // Container(
                                  //   // width: 250,
                                  //     child: Text("${widget.getEdoDataList?.userAddress}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,)),
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
                              Future.delayed(Duration(seconds: 1), (){
                                // _CaptureScreenShot(index: index);
                                _shareQrCode(widget.getWebinarDataList?.link ?? '');
                                //_shareQrCode(text: widget.getWebinarDataList?.title ?? '');
                              });

                            }, icon: Icon(Icons.share)),
                            IconButton(onPressed: (){
                              setState(() {
                                getNewWishlistApi(widget.getWebinarDataList?.id ?? '', widget.getWebinarDataList?.type ?? "");
                                widget.getWebinarDataList?.isSelected = !(widget.getWebinarDataList?.isSelected ?? false );
                              });
                            },icon: widget.getWebinarDataList?.isFav ?? false ? Icon(Icons.favorite,color: colors.red,): widget.getWebinarDataList?.isSelected ?? false ?Icon(Icons.favorite,color: colors.red,) :  Icon(Icons.favorite_outline,color: colors.red,))
                          ],
                        ):SizedBox.shrink()

                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child:  DecoratedBox(
                          decoration:  BoxDecoration(
                          ),
                          child: widget.getWebinarDataList?.image == null || widget.getWebinarDataList?.image == "" ? Image.asset("assets/splash/splashimages.png"):Image.network("${widget.getWebinarDataList?.image}",fit: BoxFit.cover)
                      ),

                    ),
                    // Container(
                    //   width: double.infinity,
                    //   child: widget.getWebinarDataList?.image == null || widget.getWebinarDataList?.image == " " ? Image.asset("assets/images/Events banner.png",):ClipRRect(
                    //       borderRadius:  BorderRadius.circular(5),
                    //       child: Image.network("${widget.getWebinarDataList?.image}",fit: BoxFit.cover,height: 150,)),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 140,
                                  child: Text("Speaker: ${widget.getWebinarDataList?.speaker}",overflow: TextOverflow.ellipsis,)),
                              SizedBox(
                                width: 150,
                                  child: Text("Moderator: ${widget.getWebinarDataList?.moderator}",overflow: TextOverflow.ellipsis,)),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                child: ElevatedButton(onPressed: (){
                                  launch("${widget.getWebinarDataList?.link}");
                                },
                                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                    child: Text('Link',style: TextStyle(color: Colors.white,fontSize: 10),)),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                height: 30,
                                child: ElevatedButton(onPressed: (){
                                  downloadFile('${widget.getWebinarDataList?.image}', widget.getWebinarDataList?.userName ?? '');
                                },
                                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                    child: Text('Detail PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                              ),

                            ],
                          ),
                      ],
                      ),
                    )

                  ],
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10)
                //         ),
                //         child: ClipRRect(
                //             borderRadius: BorderRadius.circular(10),
                //             child: Image.network('${widget.getWebinarDataList?.image}',height: 90,width:100,)),
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Container(
                //                 child: Column(
                //                   crossAxisAlignment:CrossAxisAlignment.start,
                //                   children: [
                //                     Text('${widget.getWebinarDataList?.title}',style: TextStyle(fontSize: 14,color: colors.blackTemp,fontWeight: FontWeight.bold),),
                //                     Text('${widget.getWebinarDataList?.topic}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                //                     SizedBox(height: 2),
                //                     Text('${widget.getWebinarDataList?.speaker}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                //                     SizedBox(height: 2),
                //                     Text('${widget.getWebinarDataList?.moderator}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                //                     SizedBox(height: 2),
                //                     Container(
                //                         width: 120,
                //                         child: Text('${widget.getWebinarDataList?.userAddress}',style: TextStyle(fontSize: 10,color: colors.blackTemp),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                //                     SizedBox(height: 15,),
                //                   ],
                //                 ),
                //               ),
                //               iconVisible ?   Row(
                //                 children: [
                //                   IconButton(onPressed: (){
                //                     setState(() {
                //                       iconVisible = false;
                //                     });
                //                     Future.delayed(Duration(milliseconds: 500), (){
                //                       _shareQrCode(widget.getWebinarDataList?.link ?? '');
                //
                //                     });
                //
                //                   }, icon: Icon(Icons.share)),
                //                   IconButton(onPressed: (){
                //                     setState(() {
                //                       getNewWishlistApi(widget.getWebinarDataList?.id ?? '', widget.getWebinarDataList?.type ?? "");
                //                       widget.getWebinarDataList?.isSelected = !(widget.getWebinarDataList?.isSelected ?? false );
                //                     });
                //                   },icon: widget.getWebinarDataList?.isFav ?? false ? Icon(Icons.favorite,color: colors.red,): widget.getWebinarDataList?.isSelected ?? false ?Icon(Icons.favorite,color: colors.red,) :  Icon(Icons.favorite_outline,color: colors.red,))
                //                 ],
                //               )
                //                   : SizedBox.shrink()
                //             ],),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Container(
                //               height: 25,
                //               child: ElevatedButton(onPressed: (){
                //                 launch("${widget.getWebinarDataList?.link}");
                //               },
                //                   style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                //                   child: Text('Link',style: TextStyle(color: Colors.white,fontSize: 10),)),
                //             ),
                //             SizedBox(width: 10,),
                //             Container(
                //               height: 25,
                //               child: ElevatedButton(onPressed: (){
                //                 downloadFile('${widget.getWebinarDataList?.image}', widget.getWebinarDataList?.userName ?? '');
                //               },
                //                   style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                //                   child: Text('Detail PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                //             ),
                //             SizedBox(width: 20,),
                //
                //
                //           ],
                //         ),
                //         SizedBox(height: 10),
                //
                //       ],
                //     ),
                //
                //   ],
                // ),

              ],
            ),
          ),

        ],
      ) : SizedBox(),
    );
  }

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

  getNewWishlistApi(String id ,event) async {
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

}
