import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/New_model/GetSliderModel.dart';
import 'package:doctorapp/widgets/widgets/commen_slider.dart';
import 'package:doctorapp/widgets/widgets/onlinewebnar_list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helper/Color.dart';
import '../Helper/Appbar.dart';
import '../New_model/GetWebinarModel.dart';
import '../api/api_services.dart';
import '../Webiner/AddPostWebiner.dart';
import 'package:http/http.dart'as http;


class OnlineWebinar extends StatefulWidget {
  const OnlineWebinar({Key? key}) : super(key: key);

  @override
  State<OnlineWebinar> createState() => _OnlineWebinarState();
}

class _OnlineWebinarState extends State<OnlineWebinar> {
  bool isSelected = false;
  GetWebinarModel? webinarModel;
  bool iconVisible = true;
  getOnlineWebinarApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? Roll = preferences.getString('roll');
    String? id = preferences.getString('sId');
    String? localId = preferences.getString('LocalId');
    print("getOnlineWebinarUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=ff45191bc42e12d2471ecac1e726d8107925e77c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getWebinar}'));
    request.fields.addAll({
      'user_id': '$userId',
      'roll': '$Roll',
      'speciality_id': localId==null || localId== '' ?  id ?? '' : localId
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
  ScreenshotController screenshotController = ScreenshotController();
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
    Future.delayed(Duration(seconds: 1),(){
      getOnlineWebinarApi();
    }) ;
    String date = dateTime.substring(11,16);
    print("aaaaaaaaaaaaa====>${date}");
  }

  String dateTime = '2023-03-24 16:09:30';


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
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
      Navigator.pop(context);
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Future<Null> callApi() async {
    getOnlineWebinarApi();
  }
  List <GetWebnDataList> getWebnDataList = [] ;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:  _refresh,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPostWebiner()));
            },
            backgroundColor: colors.secondary,
            child: Icon(Icons.add),
          ),
          appBar: customAppBar(context: context, text:"Online Webinar", isTrue: true, ),
          body: SingleChildScrollView(

            child: Column(
              children:<Widget> [
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
                // _sliderModel== null ? Center(child: CircularProgressIndicator(),) :_CarouselSlider1(),
                // SizedBox(height: 5,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:  _buildDots(),),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 3,
                    child: Container(
                      height: 50,
                      width:MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                         borderRadius: BorderRadius.circular(10)
                     ),
                      child: Center(child: Text('Upcoming Interesting online webinar',style: TextStyle(fontSize: 15,color: Color(0xFF3E4095)),)),
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                SizedBox(
                  child: webinarModel?.data == null ? Center(child:  Text("No Data Found !!"))  : webinarModel?.data?.isEmpty?? false ? Text("Not Approved by Admin"):
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // reverse: true,
                      itemCount: webinarModel!.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  OnlineWebinarListCard(index: getWebnDataList.length, getWebinarDataList: getWebnDataList[index],); //webinarCard(index);
                      }),
                ),
                // Container(
                //   height: 40,
                //   width:300,
                //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                //   child: ElevatedButton(onPressed: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=> PharmaProductScreen()));
                //   },
                //       style: ButtonStyle(
                //           backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),
                //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //               RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10.0)))),
                //       child: Text('New Webinar',style: TextStyle(color: Colors.white,fontSize: 15),)),
                // ),
                // SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
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

  Widget webinarCard(int index){
    return Column(
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
                    Text('${webinarModel!.data![index].date.toString().substring(0,10)}',style: TextStyle(color: Colors.white,fontSize: 15),),
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.only(top: 5,bottom: 5),
                      child: VerticalDivider(thickness: 1,color: colors.whiteTemp,),
                    ),
                    SizedBox(width: 20,),
                    Text('${webinarModel!.data?[index].fromTime.toString()}',style: TextStyle(color: Colors.white,fontSize: 15),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('${webinarModel!.data![index].image}',height: 90,width:100,)),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Text('${webinarModel!.data![index].title}',style: TextStyle(fontSize: 14,color: colors.blackTemp,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 2),
                                  Text('${webinarModel!.data![index].topic}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                                  SizedBox(height: 2),
                                  Text('${webinarModel!.data![index].speaker}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                                  SizedBox(height: 2),
                                  Text('${webinarModel!.data![index].moderator}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                                  SizedBox(height: 2),
                                  Container(
                                      width: 120,
                                      child: Text('${webinarModel!.data![index].userAddress}',style: TextStyle(fontSize: 10,color: colors.blackTemp),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                  SizedBox(height: 15,),
                                ],
                              ),
                            ),
                         iconVisible ?   Row(
                              children: [
                                IconButton(onPressed: (){
                                  setState(() {
                                    iconVisible = false;
                                  });
                                  Future.delayed(Duration(milliseconds: 500), (){
                                    _shareQrCode();

                                  });

                                }, icon: Icon(Icons.share)),
                                IconButton(onPressed: (){
                                  setState(() {
                                    getNewWishlistApi(webinarModel!.data![index].id ?? '', webinarModel!.data![index].type ?? "");
                                    webinarModel?.data![index].isSelected = !(webinarModel?.data![index].isSelected ?? false );
                                  });
                                },icon: webinarModel?.data![index].isFav ?? false ? Icon(Icons.favorite,color: colors.red,): webinarModel?.data![index].isSelected ?? false ?Icon(Icons.favorite,color: colors.red,) :  Icon(Icons.favorite_outline,color: colors.red,))
                              ],
                            )
                             : SizedBox.shrink()
                          ],),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 25,
                            child: ElevatedButton(
                                onPressed: (){
                              launch("${webinarModel!.data![index].link}");
                            },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                child: Text('Link',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 25,
                            child: ElevatedButton(onPressed: (){
                              downloadFile('${webinarModel?.data![index].image}', webinarModel?.data![index].userName ?? '');
                            },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                child: Text('Detail PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ),
                          SizedBox(width: 20,),

                        ],
                      ),

                    ],
                  ),

                ],
              ),

            ],
          ),
        ),

      ],
    );
  }
  // _CarouselSlider1(){
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: CarouselSlider(
  //       options: CarouselOptions(
  //           onPageChanged: (index, result) {
  //             setState(() {
  //                 _currentPost = index;
  //             });
  //           },
  //           viewportFraction: 1.0,
  //           initialPage: 0,
  //           enableInfiniteScroll: true,
  //           reverse: false,
  //           autoPlay: true,
  //           autoPlayInterval: Duration(seconds: 5),
  //           autoPlayAnimationDuration:
  //           Duration(milliseconds: 500),
  //           enlargeCenterPage: false,
  //           scrollDirection: Axis.horizontal,
  //           height: 200.0),
  //       items: _sliderModel?.data?.map((item) {
  //         return CommonSlider(file: item.image ?? '', link: item.link ?? '');
  //       }).toList(),
  //     ),
  //   );
  //
  // }
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    String type = '/webinar_slide ';
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
