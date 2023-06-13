

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/GetNewTypeModel.dart';
import 'package:doctorapp/New_model/GetSliderModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_share/social_share.dart';

import '../Helper/Appbar.dart';
import '../New_model/newsUpadeModel.dart';
import '../widgets/widgets/commen_slider.dart';
import '../widgets/widgets/news_update_list_card.dart';
import 'AddPostNew.dart';
import 'dart:ui' as ui;



class UpdsateScreen extends StatefulWidget {
  const UpdsateScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<UpdsateScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isSelected = false;
  bool loading = false;
  bool loading1 = false;
  bool iconVisible = true;

  final _selectedColor = colors.primary;
  final _unselectedColor = Color(0xff5f6368);
  final _tabs = [
    Tab(text: 'Doctor News',),
    Tab(text: 'Pharma News'),
    Tab(text: 'Product News'),
  ];
  String? role;
  getRoll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    role = preferences.getString('roll');
    print("getEventUserId--------------->222222222222${role}");
  }
  @override
   initState() {

    _tabController = TabController(length: 3, vsync: this,initialIndex: 0,
    );
    super.initState();
    getRoll();
    getSliderApi();
    getNewListApi(1);
    copyBundleAssets();
    String date = dateTime.substring(11,16);
    print("aaaaaaaaaaaaa====>${date}");

  }


  String? referUrl;
  List<GlobalKey> _globalKey = [];
  String dateTime = '2023-03-24 10:51:42';
  //List<Model> homeSliderList = [];
  String facebookId = "xxxxxxxx";
  var imageBackground = "image-background.jpg";
  var videoBackground = "video-background.mp4";
  String imageBackgroundPath = "";
  String videoBackgroundPath = "";

  Future<void> copyBundleAssets() async {
    imageBackgroundPath = await copyImage(imageBackground);
    videoBackgroundPath = await copyImage(videoBackground);
  }

  Future<String> copyImage(String filename) async {
    final tempDir = await getTemporaryDirectory();
    ByteData bytes = await rootBundle.load("assets/$filename");
    final assetPath = '${tempDir.path}/$filename';
    File file = await File(assetPath).create();
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file.path;
  }

  ScreenshotController screenshotController = ScreenshotController();
  String newsType= 'doctor-news';
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  int _currentIndex = 1;
  customTabbar(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 1;
                newsType= 'doctor-news';
                getNewListApi(1);

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
              width: MediaQuery.of(context).size.width/3.3,
              child: Center(
                child: Text("Doctor News",style: TextStyle(color: _currentIndex == 1 ?colors.whiteTemp:colors.blackTemp)),
              ),
            ),
          ),
          InkWell(
            onTap: (){

              setState(() {
                _currentIndex = 3;
                newsType= 'product-news';
                getNewListApi(3);

              });
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 3 ?
                    colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                // width: 120,
                height: 45,
                width: MediaQuery.of(context).size.width/3.3,
                child: Center(
                  child: Text("Product News",style: TextStyle(color: _currentIndex == 3 ?colors.whiteTemp:colors.blackTemp),),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 2;
                newsType= 'pharma-news';
                getNewListApi(2);

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
              width: MediaQuery.of(context).size.width/3.3,

              child: Center(
                child: Text("Pharma News",style: TextStyle(color: _currentIndex == 2 ?colors.whiteTemp:colors.blackTemp)),
              ),
            ),
          )
        ],
      ),
    );
  }
  customCards(model, int i){
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child:  Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _currentIndex == 1 ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5,bottom: 8),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${newModel?.data[i].profileImage}"),
                        backgroundColor: colors.primary,
                        radius: 25,
                      ),
                    ), //CircleAvatar
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 3),
                      child:newModel!.data.isEmpty  ? Center(child: CircularProgressIndicator()) :Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dr.${newModel?.data[i].docName}",style: TextStyle(fontSize: 14,color: colors.secondary,fontWeight: FontWeight.bold),),SizedBox(height: 2,),
                          Row(children: [
                            Text("Prof.Dr.-",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                            Text("${newModel?.data[i].docDegree}",style: TextStyle(fontSize: 10),),SizedBox(height: 2,),
                          ],),

                          Container(
                              width: 250,
                              child: Text("${newModel?.data[i].docAddress}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,)),

                        ],
                      ),
                    ),
                  ],
                ):SizedBox(),
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius:  BorderRadius.circular(5),
                      child: newModel?.data[i].image == null || newModel?.data[i].image == "" ? Image.asset("assets/splash/splashimages.png"):Image.network("${ApiService.imageUrl}${newModel?.data[i].image}",fit: BoxFit.fill,height: 250,)),
                ),
                SizedBox(height: 8,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('${newModel?.data[i].title}'),
                  Text('${newModel?.data[i].description}'),
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
                          iconVisible = false;
                             });
                                Future.delayed(Duration(seconds: 1), (){
                               _shareQrCode();
                               });

                          }, icon: Icon(Icons.share)),
                    IconButton(onPressed: (){
                      setState(() {
                        getNewWishlistApi(newModel?.data[i].id??'');
                        newModel?.data[i].isSelected = !(newModel?.data[i].isSelected ?? false );
                      });
                    },icon: newModel?.data[i].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                  ],
                ):SizedBox.shrink()


              ],
            ),


            SizedBox(height: 10,)

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

  Future<String> capturePng(i,url) async {
    try {
      print('inside');
      RenderRepaintBoundary? boundary =
      _globalKey[i].currentContext!.findRenderObject()   as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      print(pngBytes);
      String dir = (await getApplicationSupportDirectory()).path;
      File? file = File(
          "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
      await file.writeAsBytes(pngBytes);
      setState(() {
        loading = true;
      });
      SocialShare.shareOptions("${referUrl}",imagePath: file.path);
      return file.path;
    } catch (e) {
      print(e);
    }
    return "";
  }

  getNewWishlistApi(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? specialityId = preferences.getString('specialityId');
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
      'type': '$newsType',
      'speciality_id':'${specialityId}'
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
  GetNewTypeModel? newTypeModel;
  NewModel? newModel;
  List <DoctorNewsData> newsDatalist = [];

  getNewListApi(int i) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? specialityId = preferences.getString('specialityId');
    String? localId = preferences.getString('LocalId');
    print("Specialityid--------->${specialityId}");
    setState(() {
      loading1 = true ;
    });
    var headers = {
      'Cookie': 'ci_session=9a59f2a36579743ebe4be326398f94cb3844c40b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getNewType}'));
    request.fields.addAll({
      'news_type': i.toString(),
      'speciality_id': localId==null || localId== '' ? specialityId ?? '' : localId
    });
    print("this is a finalRe----------->${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     final result =  await response.stream.bytesToString();
     final finalResult = NewModel.fromJson(jsonDecode(result));
     //print("this is a finalRe----------->${finalResult}");
     setState(() {
       newModel = finalResult;
       newsDatalist = finalResult.data;

       print('MY Doctor Name-------${newsDatalist[0].docName}');
       print('__________${finalResult.data.first.profileImage}_________');
       //newTypeModel?.data!.reversed;
       loading1 =false ;
     });
    }
    else {
    print(response.reasonPhrase);
    loading1 =false ;
    setState(() {

    });
    }
  }



  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
    //getNewListApi();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
           floatingActionButton: role == "1" &&  _currentIndex == 1?
          FloatingActionButton(
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPostNew()));
          },
          backgroundColor: colors.secondary,
          child: Icon(Icons.add),
        )
           : role == "2" && _currentIndex != 1? FloatingActionButton(
             onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPostNew()));
             },
             backgroundColor: colors.secondary,
             child: Icon(Icons.add),
           )
           : const SizedBox.shrink(),

        backgroundColor: Colors.white,
        appBar: customAppBar(context: context, text:" News Update", isTrue: true, ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView(
                children: [
                  //const SizedBox(height: 10,),
                  customTabbar(),
                 // SizedBox(height: 5,),
                  //_Tabs(),


                  // _sliderModel== null ? Center(child: CircularProgressIndicator(),) :_CarouselSlider1(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children:  _buildDots(),),

                  loading1 ? const Center(child: SingleChildScrollView()): SizedBox(
                    child: ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: newModel!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return //customCards(newModel!.data,index);
                            UpdateScreenListCard(index: newsDatalist.length,newModel: newsDatalist[index],currentIndex: _currentIndex,i: index,);//customCards(newModel, index);


                        }),
                  ),

                ]
            ),
          ],
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
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    String type = '/doctor_news_slide';
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
