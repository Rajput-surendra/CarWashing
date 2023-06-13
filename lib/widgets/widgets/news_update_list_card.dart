import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/newsUpadeModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import '../../News/update_screen.dart';



class UpdateScreenListCard extends StatefulWidget {
  const UpdateScreenListCard({Key? key, this.newModel, required this.currentIndex , required this.index, required this.i}) : super(key: key);

 final DoctorNewsData? newModel;
 final int currentIndex;
 final int index;
 final int i;

  @override
  State<UpdateScreenListCard> createState() => _UpdateScreenListCardState();
}
String newsType =  '' ;
ScreenshotController _screenshotController = ScreenshotController();

class _UpdateScreenListCardState extends State<UpdateScreenListCard> {
  GlobalKey keyList  = GlobalKey() ;
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
    print('Doctor Name>>>>>>>${widget.newModel?.docName}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.currentIndex == 1){
      print('My index is 1111${widget.currentIndex}');
      newsType= 'doctor-news';
    }else if(widget.currentIndex == 3){
      print('My index is 3333${widget.currentIndex}');
      newsType= 'pharma-news';
    }else if(widget.currentIndex == 2){
      print('My index is 22222${widget.currentIndex}');
      newsType= 'product-news';
    }
    return RepaintBoundary(
      key: keyList,
      child: _isReady ? Card(
          elevation: 4,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(5),
          ),
          child:  Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                   Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 8),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("${widget.newModel?.profileImage}"),
                            backgroundColor: colors.primary,
                            radius: 25,
                          ),
                        ), //CircleAvatar
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left: 3),
                          child: widget.newModel == null    ? Center(child: CircularProgressIndicator()) :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.currentIndex == 1 ? Text("Dr.${widget.newModel?.docName}",style: TextStyle(fontSize: 14,color: colors.secondary,fontWeight: FontWeight.bold),):Text("Pharma.${widget.newModel?.docName}",style: TextStyle(fontSize: 14,color: colors.secondary,fontWeight: FontWeight.bold),),
                              widget.currentIndex == 1 ? Row(children: [
                                Text("Prof.Dr.-",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                Text("${widget.newModel?.docDegree}",style: TextStyle(fontSize: 10),),SizedBox(height: 2,),
                              ],) :SizedBox(),

                                  Container(
                                  width: 250,
                                  child: Text("${widget.newModel?.docAddress}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,))

                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child:  DecoratedBox(
                          decoration:  BoxDecoration(
                          ),
                          child: widget.newModel?.image == null || widget.newModel?.image == "" ? Image.asset("assets/splash/splashimages.png"):Image.network("${ApiService.imageUrl}${widget.newModel?.image}",fit: BoxFit.cover)
                      ),

                    ),

                    // Container(
                    //   width: double.infinity,
                    //   child: ClipRRect(
                    //       borderRadius:  BorderRadius.circular(5),
                    //       child: widget.newModel?.image == null || widget.newModel?.image == "" ? Image.asset("assets/splash/splashimages.png"):Image.network("${ApiService.imageUrl}${widget.newModel?.image}",fit: BoxFit.fill,height: 250,)),
                    // ),
                    SizedBox(),
                    const SizedBox(height: 8,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                            child: Text('${widget.newModel?.title}',overflow: TextOverflow.ellipsis,)),
                        Container(
                            width: 200,
                            child: Text('${widget.newModel?.description}',overflow: TextOverflow.ellipsis,)),
                      ],),
                    // LikeAnimation(
                    //   isAnimating: i,
                    //   //widget.snap['likes'].contains(user!.uid),
                    //   smallLike: isSelected,
                    //   child: IconButton(
                    //     onPressed: () async {
                    //       setState(() {
                    //         isSelected = !isSelected;
                    //       });
                    //       likeUnlike();
                    //       // await FirestoreMethods().likePost(
                    //       //   widget.snap['postId'],
                    //       //   user!.uid,
                    //       //   widget.snap['likes'],
                    //       // );
                    //     },
                    //     icon: isSelected
                    //         ? const Icon(
                    //       Icons.favorite,
                    //       color: Colors.red,
                    //     )
                    //         : const Icon(
                    //       Icons.favorite_outline_outlined,
                    //       color: colors.primary,
                    //     ),
                    //   ),
                    // ),

        iconVisible ? Row(
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                            iconVisible = false ;
                          });
                          Future.delayed(Duration(seconds: 1),() {
                            _shareQrCode(text: widget.newModel?.docName ?? '');
                          },);

                        }, icon: Icon(Icons.share)),
                        IconButton(onPressed: (){
                          setState(() {
                            getNewWishlistApi(widget.newModel?.id??'');
                            widget.newModel?.isSelected = !(widget.newModel?.isSelected ?? false );
                          });
                        },icon: widget.newModel?.isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                      ],
                    ) : SizedBox(),


                  ],
                ),
                const SizedBox(height: 10,)

              ],
            ),
          )
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(20),
        //           child: Image.network("${ApiService.imageUrl}${newTypeModel?.data?[i].image}",fit: BoxFit.fill,height: 100,width: 100,)),
        //     ),
        //     Padding(
        //       padding:  EdgeInsets.only(top: 15,left: 5),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           Text("${newTypeModel?.data?[i].title}",style: TextStyle(fontWeight: FontWeight.bold),),
        //           SizedBox(height: 3,),
        //           Text("${newTypeModel?.data?[i].description}"),
        //           Text("${newTypeModel?.data?[i].date?.substring(11,16)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),)
        //         ],
        //       ),
        //     ),
        //
        //   ],
        // ),
      ) : SizedBox(),
    );
  }

  _shareQrCode({String? text}) async {
    iconVisible = true ;
    var status =  await Permission.photos.request();
    //Permission.manageExternalStorage.request();

   //PermissionStatus storagePermission = await Permission.storage.request();
    if ( status.isGranted/*storagePermission == PermissionStatus.denied*/) {
      final directory = (await getApplicationDocumentsDirectory()).path;

      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      /*if(bound.debugNeedsPaint){
        Timer(const Duration(seconds: 2),()=>_shareQrCode());
        return null;
      }*/
      ui.Image image = await bound.toImage(pixelRatio: 10);
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
          const SnackBar(content: Text('This Permission is recommended')));
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {

      });
    }
  }
  getNewWishlistApi(String id) async {
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
      'type': '${newsType}'
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
