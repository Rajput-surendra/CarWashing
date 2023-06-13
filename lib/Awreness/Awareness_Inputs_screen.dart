import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/New_model/GetSliderModel.dart';
import 'package:doctorapp/New_model/Get_search_model.dart';
import 'package:doctorapp/widgets/widgets/awareness_list_card.dart';
import 'package:doctorapp/widgets/widgets/commen_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../New_model/GetAwarenessModel.dart';
import '../api/api_services.dart';
import '../Awreness/AddAwrenessPost.dart';

class AwarenessScreen extends StatefulWidget {
  const AwarenessScreen({Key? key}) : super(key: key);

  @override
  State<AwarenessScreen> createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends State<AwarenessScreen> {
  late VideoPlayerController _controller;
  List<bool> isPlayed = [];
   final List <VideoPlayerController> _vController = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderApi();
    getAwarenessList();
    String date = dateTime.substring(11,16);
    print("aaaaaaaaaaaaa====>${date}");
  }

  String? specialityId;
  bool isSliderLoading = false ;
  bool isScreenLoading = false ;

  String dateTime = '2023-03-24 16:09:30';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
    getAwarenessList();
  }

  int _currentIndex = 0;
  GetAModel? getAwareNess;
  getAwarenessList() async {
    setState(() {
      isScreenLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? specialityId = preferences.getString('specialityId');
      String? localId = preferences.getString('LocalId');


    var headers = {
      'Cookie': 'ci_session=24cf09ce78eebd805097f2d1bcece02c6e418346'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getAwareness}'));
    request.fields.addAll({
      'user_id': '$userId',
      'speciality_id': localId==null || localId== ''  ?  specialityId ?? '' : localId
    });
    print("this is is request=========>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response =  await request.send();
    if (response.statusCode == 200) {
      final result  = await response.stream.bytesToString();
      final finalResult = GetAModel.fromJson(jsonDecode(result));
      print("this is a awarenessModel=============>${finalResult}");
      print("this is a awarenessModel=============>${result}");
      setState(() {
        getAwareNess = finalResult;
        isScreenLoading = false;
      });

      print('__________${getAwareNess?.data.poster}_________');
      // for(var i=0;i<FinalResult.data.video.length;i++){
      //   FinalResult.data.video.forEach((element) {
      //     Uri uri = Uri.parse(element.image?? '');
      //     String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
      //
      //     if(typeString == "mp4")
      //     _vController.add(VideoPlayerController.network(element.image ?? '')..initialize().then((value){
      //       setState(() {
      //       });
      //     }));
      //     isPlayed.add(false);
      //   });
      //   //_vController.add(VideoPlayerController.network(jsonResponse.data![i].video.toString()));
      //
      //   print("video controller length ${_vController.length}");
      // }

      for(var i=0;i<(getAwareNess?.data.video?.length ?? 5);i++){
        // _vController.add(VideoPlayerController.network(jsonResponse.data![i].video.toString()));
          _vController.add(VideoPlayerController.network(getAwareNess!.data.video![i].toString())..initialize().then((value){
          setState(() {
          });
        }));
        isPlayed.add(false);
        print("video controller length ${_vController.length}");
      }

    }
    else {
      print(response.reasonPhrase);
      setState(() {
        isScreenLoading = false;
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
  //         autoPlayInterval: Duration(seconds: 5),
  //         autoPlayAnimationDuration:
  //         Duration(milliseconds: 500),
  //         enlargeCenterPage: false,
  //         scrollDirection: Axis.horizontal,
  //         height: 200.0),
  //     items: _sliderModel?.data?.map((item) {
  //       return CommonSlider(file: item.image ?? '', link: item.link ?? '');
  //     }).toList(),
  //   );
  //
  // }
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    isSliderLoading = true;
    setState(() {

    });
    String type = '/awareness';
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

        isSliderLoading = false;

      });
    } else {
      print(response.reasonPhrase);
    }
  }
  TextEditingController searchController = TextEditingController();
  GetSearchModel?  getSearchModel;
  getSearchListApi(String v) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getRoll--------------->${userId}");
    var headers = {
      'Cookie': 'ci_session=73057c266192adca72d009505c074949facaf6b7'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getAwareness}'));
    request.fields.addAll({
      'user_id': '$userId',
      'search': v.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("Response here ${response}");
    if (response.statusCode == 200) {
      getAwarenessList();
     final result =  await response.stream.bytesToString();
      print("hello data here ${result}");
     final finalResult = GetSearchModel.fromJson(jsonDecode(result));
     setState(() {
       getSearchModel = finalResult;
     });

    }
    else {
    print(response.reasonPhrase);
    }

  }
  getNewWishlistApi(String id, String event) async {

    isScreenLoading = true ;
    setState(() {

    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");
    specialityId = preferences.getString('specialityId');
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
      'speciality_id':specialityId.toString()
    });
    print("this is data------------->${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      print("thi os ojon=result=========>${result}");
      Fluttertoast.showToast(msg: finalResult['message']);

      isScreenLoading = false ;
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
      isScreenLoading = false ;
      setState(() {

      });
    }

  }
  int selectedSegmentVal = 0;
  bool iconVisible = true;
  bool iconVisible1 = true;
  bool iconVisible2 = true;
  bool iconVisible3 = true;
  ScreenshotController screenshotController = ScreenshotController();

  setSegmentValue(int i) {
    selectedSegmentVal = i;
    String status;
    if (i == 0) {
      status = 'Ongoing';
    } else if (i == 1) {
      status = 'Complete';
    }
    setState(() {
      getAwarenessList();
    });
    // getOrderList(status: status);
  }



searchProduct(String value) {
  if (value.isEmpty) {
    getAwarenessList();
    setState(() {
    });
  } else {
    if(selectedSegmentVal == 0){
      final suggestions = getAwareNess?.data.mPoster?.where((element) {
        final productTitle = element.title?.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle!.contains(input);
      }).toList();
      getAwareNess?.data.mPoster= suggestions!;
      setState(() {

      });
    }if(selectedSegmentVal == 1){
      final suggestions = getAwareNess?.data.booklets?.where((element) {
        final productTitle = element.title?.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle!.contains(input);
      }).toList();
      getAwareNess?.data.booklets= suggestions!;
      setState(() {

      });
    }if(selectedSegmentVal == 2){
      final suggestions = getAwareNess?.data.leaflets?.where((element) {
        final productTitle = element.title?.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle!.contains(input);
      }).toList();
      getAwareNess?.data.leaflets= suggestions!;
      setState(() {

      });
    }
    if(selectedSegmentVal == 3){
      final suggestions = getAwareNess?.data.poster?.where((element) {
        final productTitle = element.title?.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle!.contains(input);
      }).toList();
      getAwareNess?.data.poster= suggestions!;
      setState(() {

      });
    }

  }
}

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAwanessPost()));
            },
            backgroundColor: colors.secondary,
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: colors.secondary,
            centerTitle: true,
            leading:InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_ios_new_outlined,color: colors.whiteTemp,),
                )
            ),
            title: Text("Awareness Inputs"),
            // actions: [
            //   InkWell(
            //     onTap: (){
            //       // Navigator.pop(context);
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(8),
            //       child: InkWell(
            //           onTap: (){
            //             //Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
            //           },
            //           child: Icon(Icons.search,color: colors.whiteTemp,)),
            //     ),
            //   ),
            // ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Stack(
                //   alignment: Alignment.bottomCenter,
                //   children: [
                //     SizedBox(
                //       height: 200,
                //       width: double.maxFinite,
                //       child: isSliderLoading ? const Center(child: CircularProgressIndicator(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: TextFormField(
                        controller: searchController,
                        decoration:InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            prefixIcon:  Icon(Icons.search,color: colors.black54,),
                            contentPadding: EdgeInsets.only(top: 5),
                            hintText: "Search...."
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchProduct(value);
                          });
                        }
                    ),
                  ),
                ),
                _segmentButton(),
                // _sliderModel== null ? Center(child: CircularProgressIndicator(),) :_CarouselSlider1(),
                // SizedBox(height: 5,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:  _buildDots(),),
                // customTabbar(),
                SizedBox(
                  // height: MediaQuery.of(context).size.height/1.0,
                    child: isScreenLoading ? const Center(child: CircularProgressIndicator())
                        :
                    getAwareNess?.data.poster?.isEmpty ?? false ? Center(child: Text('Poster not available'),) : selectedSegmentVal == 0
                        ?
                    ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess!.data.poster?.length ?? 5,
                        itemBuilder: (BuildContext context, int index) {
                          return AwarenessListCard(currentIndex: 0,index: index,getAwareNess: getAwareNess, vController: _vController,); //getPosterList(getAwareNess?.data.mPoster, index);
                        })
                        : getAwareNess?.data.booklets?.isEmpty ?? false ? Center(child: Text('Booklets not available'),) : selectedSegmentVal == 1
                        ? ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess!.data.booklets?.length ?? 5,
                        itemBuilder: (BuildContext context, int index) {
                          return AwarenessListCard(currentIndex: 1,index: index,getAwareNess: getAwareNess,vController: _vController); // bookletsList(getAwareNess?.data.booklets, index);
                        })
                        :getAwareNess?.data.leaflets?.isEmpty ?? true ? Center(child: Text('Leaflets not available'),) : selectedSegmentVal == 2
                        ?  ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess!.data.leaflets?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AwarenessListCard(currentIndex: 2,index: index,getAwareNess: getAwareNess,vController: _vController); // getLeafletList(getAwareNess?.data.leaflets, index);
                        })
                        : getAwareNess?.data.mPoster?.isEmpty ?? true ? Center(child: Text('Poster not available'),) :selectedSegmentVal == 3
                        ?ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess!.data.mPoster?.length??5,
                        itemBuilder: (BuildContext context, int index) {
                          return AwarenessListCard(currentIndex: 3,index: index,getAwareNess: getAwareNess,vController: _vController); // getMotimationList(getAwareNess?.data.poster, index);
                        })
                        :getAwareNess?.data.video?.isEmpty ?? true ? Center(child: Text('video not available'),): selectedSegmentVal == 4
                        ? ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess?.data.video?.length ?? 5,
                        itemBuilder: (BuildContext context, int index) {
                          return getVideoList(getAwareNess?.data.video,index);
                        }):SizedBox()),
                      SizedBox(height: 50,)
                      //
                      //   : selectedSegmentVal == 5
                      //   ?ListView.builder(
                      // // scrollDirection: Axis.vertical,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   reverse: true,
                      //   itemCount: GetAwrenessModel?.data?.awareness?.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return productCustomCards();
                //      });

              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _segmentButton() =>
      SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 0
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(0),
              child: Center(
                child: Text(

                  'Patient Awareness Poster',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: selectedSegmentVal == 0
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 1
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(1),
              child: Text(
                'Patient Awareness Booklet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 1
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 2
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(2),
              child: Text(
                'Patient Awareness Leaflet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 2
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 3
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(3),
              child: Text(
                'Patient Motivational Poster',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 3
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 4
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(4),
              child: Text(
                'Patient Awareness Video',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 4
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ],
      ),
    ),
  );
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
  getPosterList(model, int index){
    return  Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child:  Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                  //     backgroundColor: colors.primary,
                  //     radius: 25,
                  //   ),
                  // ), //CircleAvatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getAwareNess?.data.mPoster?[index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                        SizedBox(height: 2,),
                        Text(getAwareNess?.data.mPoster?[index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius:  BorderRadius.circular(5),
                    child: Image.network("${getAwareNess?.data.mPoster?[index].image}",fit: BoxFit.fill,height: 250,)),
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${getAwareNess?.data.mPoster?[index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                      Text('${getAwareNess?.data.mPoster?[index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),

                    ],
                  ),
                  iconVisible ?  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          iconVisible = false;
                        });
                        Future.delayed(Duration(seconds: 1), (){
                          _shareQrCode();
                          // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                        });
                      }, icon: Icon(Icons.share)),
                      IconButton(onPressed: (){
                        setState(() {
                          getNewWishlistApi(getAwareNess?.data.mPoster?[index].id ??'',getAwareNess?.data.mPoster?[index].type ?? "");
                          getAwareNess?.data.mPoster?[index].isSelected = !(getAwareNess?.data.mPoster?[index].isSelected ?? false );
                        });
                      },icon: getAwareNess?.data.mPoster?[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                    ],
                  ):SizedBox.shrink()


                ],
              ),

              SizedBox(height: 10,)

            ],
          ),
        )
    );
  }
  _shareQrCode() async {
    iconVisible = true;
    iconVisible1 = true;
    iconVisible2 = true;
    iconVisible3 = true;
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
  bookletsList(model, int index){
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                  //     backgroundColor: colors.primary,
                  //     radius: 25,
                  //   ),
                  // ), //CircleAvatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getAwareNess?.data.booklets?[index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                        SizedBox(height: 2,),
                        Text(getAwareNess?.data.booklets?[index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius:  BorderRadius.circular(5),
                    child: Image.network("${getAwareNess?.data.booklets?[index].image}",fit: BoxFit.fill,height: 250,)),
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${getAwareNess?.data.booklets?[index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp),),
                      Text('${getAwareNess?.data.booklets?[index].awareLanguage}'),
                    ],
                  ),
                iconVisible1?  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          iconVisible1 = false;
                        });
                        Future.delayed(Duration(seconds: 1), (){
                          _shareQrCode();
                          // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                        });
                       // _shareQrCode();
                      }, icon: Icon(Icons.share)),
                      IconButton(onPressed: (){
                        setState(() {
                          getNewWishlistApi(getAwareNess?.data.booklets?[index].id ??'',getAwareNess?.data.booklets?[index].type ?? "");
                          getAwareNess?.data.booklets?[index].isSelected = !(getAwareNess?.data.booklets?[index].isSelected ?? false );
                        });
                      },icon: getAwareNess?.data.booklets?[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                    ],
                  ):SizedBox.shrink()
                ],
              ),
              SizedBox(height: 10,)

            ],
          ),
        )
    );
  }
  getLeafletList(model, int index){
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                  //     backgroundColor: colors.primary,
                  //     radius: 25,
                  //   ),
                  // ), //CircleAvatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getAwareNess?.data.leaflets?[index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 2,),
                        Text(getAwareNess?.data.leaflets?[index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        const SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius:  BorderRadius.circular(5),
                    child: Image.network("${getAwareNess?.data.leaflets?[index].image}",fit: BoxFit.fill,height: 250,)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('${getAwareNess?.data.leaflets?[index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                      Text('${getAwareNess?.data.leaflets?[index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal)),
                    ],
                  ),
                iconVisible2 ?  Row(
                  children: [
                    IconButton(onPressed: (){
                      setState(() {
                        iconVisible2 = false;
                      });
                      Future.delayed(Duration(seconds: 1), (){
                        _shareQrCode();
                        // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                      });
                    }, icon: Icon(Icons.share)),
                    IconButton(onPressed: (){
                      setState(() {
                        getNewWishlistApi(getAwareNess?.data.leaflets?[index].id ??'',getAwareNess?.data.leaflets?[index].type ?? "");
                        getAwareNess?.data.leaflets?[index].isSelected = !(getAwareNess?.data.leaflets?[index].isSelected ?? false );
                      });
                    },icon: getAwareNess?.data.leaflets?[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                  ],
                ):SizedBox.shrink()
              ],
                )



            ],
          ),
        )
    );
  }
  getMotimationList(model, int index){
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                  //     backgroundColor: colors.primary,
                  //     radius: 25,
                  //   ),
                  // ), //CircleAvatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getAwareNess?.data.poster?[index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                        SizedBox(height: 2,),
                        Text(getAwareNess?.data.poster?[index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius:  BorderRadius.circular(5),
                    child: Image.network("${getAwareNess?.data.poster?[index].image}",fit: BoxFit.fill,height: 250,)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('${getAwareNess?.data.poster?[index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                      Text('${getAwareNess?.data.poster?[index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal)),
                    ],
                  ),
                  iconVisible3 ?  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          iconVisible3 = false;
                        });
                        Future.delayed(Duration(seconds: 1), (){
                          _shareQrCode();
                          // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                        });
                      }, icon: Icon(Icons.share)),
                      IconButton(onPressed: (){
                        setState(() {
                          getNewWishlistApi(getAwareNess?.data.poster?[index].id ??'',getAwareNess?.data.poster?[index].type ?? "");
                          getAwareNess?.data.poster?[index].isSelected = !(getAwareNess?.data.poster?[index].isSelected ?? false );
                        });
                      },icon: getAwareNess?.data.poster?[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                    ],
                  ):SizedBox.shrink()
                ],
              ),
              SizedBox(height: 10,)

            ],
          ),
        )
    );
  }
  getVideoList(model, int index){
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.secondary,
                ),
                child: Column(
                  children: [
                    Container(
                        height:180,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AspectRatio(aspectRatio: _vController[index].value.aspectRatio,child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: VideoPlayer(_vController[index])),)),
                   const SizedBox(height: 10,),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("${getAwareNess?.data.video?[index].title}",style: const TextStyle(color: colors.whiteTemp),),

                     ],
                   )

                  ],
                )),
          ),
          // Positioned(
          //     bottom: 50,
          //     width: MediaQuery.of(context).size.width,
          //     child: VideoProgressIndicator(
          //       _vController[i],
          //       allowScrubbing: false,
          //       colors: VideoProgressColors(
          //           backgroundColor: Colors.blueGrey,
          //           bufferedColor: Colors.blueGrey,
          //           playedColor: Colors.blueAccent),
          //     )),
          Positioned(
              left: 1,right: 1,
              top: 0,
              bottom: 1,
              //alignment: Alignment.center,
              child: isPlayed[index] == true ? InkWell(
                  onTap: (){
                    setState(() {
                      isPlayed[index] = false;
                      _vController[index].pause();
                    });
                  },
                  child: Icon(Icons.pause,color: Colors.white,)) : InkWell(
                  onTap: (){
                    setState(() {
                      isPlayed[index] = true;
                      _vController[index].play();
                    });
                  },
                  child: Icon(Icons.play_arrow,color: Colors.white,))),

        ],
      ),
    );
  }
}
