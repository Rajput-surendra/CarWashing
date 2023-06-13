import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/New_model/Get_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../api/api_services.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

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
  void initState() {
    getHistroyApi(0);
    // TODO: implement initState
    super.initState();
  }
  GetHistory? getWishListModel;
  getHistroyApi(int i, ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=579af58e6f03e48e089abbbe963a0b6ff69888d3'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getHistoryApi}'));
    request.fields.addAll({
      'user_id': '$userId',

    });
    print("this is a history=============>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = GetHistory.fromJson(jsonDecode(result));
      print("this is a ddgfdgdf=============>${finalResult}");
      setState(() {
        getWishListModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  getHistoryDeleteApi(allType,id) async {
    var headers = {
      'Cookie': 'ci_session=62a0fd8d85e99731c639e0959f1b91127a318fd9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getHistoryDeleteApi}'));
    request.fields.addAll({
      'type': '$allType',
      'id': '$id'
    });
    print('___dgsdg_______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      getHistroyApi(0);
      Fluttertoast.showToast(msg: finalResult['message']);
    }
    else {
    print(response.reasonPhrase);
    }

  }
  int selectedSegmentVal = 0;
  Widget _segmentButton() => Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: Colors.white,
    ),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            height: 30,
            width: 100,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 0
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(0),
              child: Text(
                'News',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 0
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 90,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 1
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(1),
              child: Text(
                'Event',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 1
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 100,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 2
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(2),
              child: Text(
                'Webinars',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 2
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 90,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 3
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(3),
              child: Text(
                'Editorial',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 3
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 110,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 4
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(4),
              child: Text(
                'Awareness',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 4
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 110,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 5
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(5),
              child: Text(
                'Product',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 5
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),

        ],
      ),
    ),
  );

  setSegmentValue(int i) {
    selectedSegmentVal = i;
    String status;
    if (i == 0) {
      status = 'Ongoing';
    } else if (i == 1) {
      status = 'Complete';
    }
    setState(() {
      getHistroyApi(i);
    });
    // getOrderList(status: status);
  }

  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          context: context,
          text: "History",
          isTrue: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _segmentButton(),
              SizedBox(
                // height: MediaQuery.of(context).size.height/1.0,
                  child: getWishListModel?.data == null
                      ? Center(child: CircularProgressIndicator())
                      : getWishListModel?.data?.news?.isEmpty ?? true ? Center(child: Text('News not available'),) : selectedSegmentVal == 0
                      ?
                  ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.news?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  newCustomCards(getWishListModel, index);
                      })

                      : getWishListModel?.data?.event?.isEmpty ?? true ? Center(child: Text('Event not available'),) :selectedSegmentVal == 1
                      ? ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.event?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  eventCustomCards(getWishListModel, index);
                      })

                      :getWishListModel?.data?.webinar?.isEmpty ?? true ? Center(child: Text('Webiner not available'),) : selectedSegmentVal == 2
                      ?  ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.webinar?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  webinarsCustomCards(getWishListModel, index);
                      })

                      :getWishListModel?.data?.editorial?.isEmpty ?? true ? Center(child: Text('Editorial not available'),) : selectedSegmentVal == 3
                      ?ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.editorial?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return   editorialCustomCards(getWishListModel ,index);
                      })

                      :getWishListModel?.data?.awareness?.isEmpty ?? true ? Center(child: Text('Awareness not available'),) : selectedSegmentVal == 4
                      ? ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.awareness?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return awarenessCustomCards(getWishListModel, index);
                      })
                      :getWishListModel?.data?.products?.isEmpty ?? true ? Center(child: Text('Products not available'),) : selectedSegmentVal == 5
                      ? ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.products?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return productCustomCards(getWishListModel ,index);
                      })
                      :SizedBox()
              )
            ],
          ),
        ));
  }

  newCustomCards(model, int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _currentIndex == 1
                //     ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 5, bottom: 8),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${getWishListModel?.data?.news![i].userImage}"),
                                backgroundColor: colors.primary,
                                radius: 25,
                              ),
                            ), //CircleAvatar
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: getWishListModel!.data!.news!.isEmpty
                                  ? Center(child: CircularProgressIndicator())
                                  : Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getWishListModel?.data?.news![i].userName}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: colors.secondary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${getWishListModel?.data?.news![i].userDigree}",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                      child: Text(
                                        "${getWishListModel?.data?.news![i].userAddress}",
                                        style: TextStyle(fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     IconButton(
                        //         onPressed: () {
                        //           showDialog(
                        //             context: context,
                        //             builder: (context) => Dialog(
                        //               child: ListView(
                        //                 padding: const EdgeInsets.symmetric(
                        //                   vertical: 16,
                        //                 ),
                        //                 shrinkWrap: true,
                        //                 children: ['Remove from wishlist']
                        //                     .map(
                        //                       (e) => InkWell(
                        //                     onTap: () async {
                        //                       removeWishListApi(
                        //                           getWishListModel
                        //                               ?.data?.news!.first.id ??
                        //                               "", 0);
                        //                       Navigator.of(context).pop();
                        //                     },
                        //                     child: Container(
                        //                       padding: const EdgeInsets
                        //                           .symmetric(
                        //                         vertical: 12,
                        //                         horizontal: 16,
                        //                       ),
                        //                       child: Text(e),
                        //                     ),
                        //                   ),
                        //                 )
                        //                     .toList(),
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //         icon: Icon(Icons.more_vert_rounded))
                        //   ],
                        // )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shrinkWrap: true,
                                    children: ['Remove from News']
                                        .map(
                                          (e) => InkWell(
                                        onTap: () async {
                                          getHistoryDeleteApi(getWishListModel?.data?.news![i].type ??  "" , getWishListModel?.data?.news![i].id);
                                          // removeWishListApi(
                                          //     getWishListModel
                                          //         ?.data?.news!.first.id ??
                                          //         "", 0);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.more_vert_rounded))
                      ],
                    )
                  ],
                ),

                   // : SizedBox(),
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: getWishListModel?.data?.news![i].userImage == null ||
                          getWishListModel?.data?.news![i].userImage == ""
                          ? Image.asset("assets/splash/splashimages.png")
                          : Image.network(
                        "${getWishListModel?.data?.news![i].image}",
                        fit: BoxFit.fill,
                        height: 250,
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${getWishListModel?.data?.news![i].title}'),
                        Text('${getWishListModel?.data?.news![i].description}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }
  eventCustomCards(model, int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _currentIndex == 1
                //     ?
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 5, bottom: 8),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${getWishListModel?.data?.event![i].userImage}"),
                            backgroundColor: colors.primary,
                            radius: 25,
                          ),
                        ), //CircleAvatar
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: getWishListModel!.data!.event!.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getWishListModel?.data?.event![i].userName}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colors.secondary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${getWishListModel?.data?.event![i].userDigree}",
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                  child: Text(
                                    "${getWishListModel?.data?.event![i].userAddress}",
                                    style: TextStyle(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shrinkWrap: true,
                                    children: ['Remove from Event']
                                        .map(
                                          (e) => InkWell(
                                        onTap: () async {
                                          getHistoryDeleteApi(getWishListModel?.data?.event![i].type ??  "" , getWishListModel?.data?.event![i].id);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.more_vert_rounded))
                      ],
                    )
                  ],
                ),
                    //: SizedBox(),
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: getWishListModel?.data?.event![i].image == null ||
                          getWishListModel?.data?.event![i].image == ""
                          ? Image.asset("assets/splash/splashimages.png")
                          : Image.network(
                        "${getWishListModel?.data?.event![i].image}",
                        fit: BoxFit.fill,
                        height: 250,
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${getWishListModel?.data?.event![i].title}'),
                        Text('${getWishListModel?.data?.event![i].description}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(

                  height: 10,
                )
              ],
            ),
          )),
    );
  }
  webinarsCustomCards(model,int i){
    return Column(
      children: [
        SizedBox(
          child: getWishListModel?.data == null ? Center(child: CircularProgressIndicator())  : getWishListModel?.data?.webinar!.isEmpty ?? false ? Text("Not Approved by Admin"):
          Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Container(
                  height: 30,
                  width:MediaQuery.of(context).size.width/1.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${getWishListModel?.data!.webinar![i].startDate.toString().substring(0,10)}',style: TextStyle(color: Colors.white,fontSize: 15),),
                      SizedBox(width: 20,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: VerticalDivider(thickness: 1,color: colors.whiteTemp,),
                      ),
                      SizedBox(width: 20,),
                      Text('${getWishListModel?.data!.webinar![i].fromTime}',style: TextStyle(color: Colors.white,fontSize: 15),),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                  child: ClipRRect(
                                    borderRadius:  BorderRadius.circular(10),
                                      child: Image.network("${getWishListModel!.data!.webinar![i].image}",height: 120,width: 80,))),
                              SizedBox(width: 10,),

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Text("${getWishListModel!.data!.webinar![i].title}",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 16),),
                                    SizedBox(height: 3,),
                                    Text("${getWishListModel!.data!.webinar![i].topic}"),
                                    SizedBox(height: 3,),
                                    Text("${getWishListModel!.data!.webinar![i].moderator}"),
                                    SizedBox(height: 3,),
                                    Text("${getWishListModel!.data!.webinar![i].speaker}"),
                                    SizedBox(height: 3,),
                                    Text("${getWishListModel!.data!.webinar![i].title}"),

                                  ],
                                )
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: ListView(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shrinkWrap: true,
                                          children: ['Remove from Webinars']
                                              .map(
                                                (e) => InkWell(
                                              onTap: () async {
                                                getHistoryDeleteApi(getWishListModel?.data?.webinar![i].type ??  "" , getWishListModel?.data?.webinar![i].id);
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                  vertical: 12,
                                                  horizontal: 16,
                                                ),
                                                child: Text(e),
                                              ),
                                            ),
                                          )
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.more_vert_rounded))
                            ],
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 25,
                            child: ElevatedButton(
                                onPressed: (){
                                  launch('${getWishListModel?.data!.webinar![i].link}');
                                },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                child: Text('Live link',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 25,
                            child: ElevatedButton(onPressed: (){
                              downloadFile('${getWishListModel?.data!.webinar![i].image}', getWishListModel?.data!.webinar![i].userName??'');
                            },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                child: Text('Detail PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ),
                          // Row(
                          //   children: [
                          //     IconButton(onPressed: (){
                          //       setState(() {
                          //         getNewWishlistApi(webinarModel?.data[index].id??'');
                          //         webinarModel?.data[index].isSelected = !(webinarModel?.data[index].isSelected ?? false );
                          //       });
                          //     },icon: webinarModel?.data[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,))
                          //   ],
                          // )
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,)


              ],
            ),
          )
        ),
      ],
    );
  }
  editorialCustomCards(model,int i){
    return Column(
      children: [
        SizedBox(
          child: getWishListModel!.data!.editorial == null ? Center(child: CircularProgressIndicator())  : getWishListModel!.data!.editorial!.isEmpty?? false ? Text("Not Approved by Admin"):
          Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 5),
                        child: Text("${getWishListModel!.data!.editorial![i].date?.substring(0,10)}",style: TextStyle(fontSize: 15,color: colors.secondary)),
                      ),
                    ],
                  ),
                  Divider(thickness: 1,color: colors.black54.withOpacity(0.2),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network("${getWishListModel!.data!.editorial![i].userImage}",height: 90,width:80,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${getWishListModel!.data!.editorial![i].title}',style: TextStyle(fontSize: 14,color: colors.blackTemp,fontWeight: FontWeight.bold),),
                              SizedBox(height: 2),
                              Text('${getWishListModel!.data!.editorial![i].userDigree}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                              SizedBox(height: 2),
                              Text('${getWishListModel!.data!.editorial![i].userAddress}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                              SizedBox(height: 2),
                              SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Dr. ${getWishListModel!.data!.editorial![i].userName}',style: TextStyle(fontSize: 10,color: colors.secondary),),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 25,
                                    child: ElevatedButton(onPressed: (){
                                      downloadFile('${getWishListModel!.data!.editorial![i].image}', getWishListModel!.data!.editorial![i].userName??'');
                                    },
                                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                        child: Text('Detail PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                                  ),
                                  SizedBox(width: 20,),
                                  // IconButton(onPressed: (){
                                  //   setState(() {
                                  //     isSelected =!isSelected;
                                  //   });
                                  // },icon: isSelected ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,))
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shrinkWrap: true,
                                    children: ['Remove from Editorial']
                                        .map(
                                          (e) => InkWell(
                                        onTap: () async {
                                          getHistoryDeleteApi(getWishListModel?.data?.editorial![i].type ??  "" , getWishListModel?.data?.editorial![i].id);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.more_vert_rounded))
                      ],
                    ),
                  ],

                )
                ],
              )


          ),
        ),
      ],
    );
  }
  awarenessCustomCards(model, int i){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _currentIndex == 1
                //     ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                           //CircleAvatar
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: getWishListModel!.data!.awareness!.isEmpty
                                  ? Center(child: CircularProgressIndicator())
                                  : Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getWishListModel?.data?.awareness![i].title}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: colors.secondary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("${getWishListModel?.data?.awareness![i].awareLanguage}",),


                                ],
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shrinkWrap: true,
                                    children: ['Remove from Awareness']
                                        .map(
                                          (e) => InkWell(
                                        onTap: () async {
                                          getHistoryDeleteApi(getWishListModel?.data?.awareness![i].type ??  "" , getWishListModel?.data?.awareness![i].id);
                                          // removeWishListApi(
                                          //     getWishListModel
                                          //         ?.data?.news!.first.id ??
                                          //         "", 0);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.more_vert_rounded))
                      ],
                    )
                  ],
                ),

                // : SizedBox(),
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child:  Image.network(
                        "${getWishListModel?.data?.awareness![i].image}",
                        fit: BoxFit.fill,
                        height: 250,
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${getWishListModel?.data?.awareness![i].awareInput}",),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }
  productCustomCards(model, int i){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _currentIndex == 1
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 5, bottom: 8),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${getWishListModel?.data?.products![i].userImage}"),
                            backgroundColor: colors.primary,
                            radius: 25,
                          ),
                        ), //CircleAvatar
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: getWishListModel!.data!.products!.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getWishListModel?.data?.products![i].userName}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colors.secondary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${getWishListModel?.data?.products![i].userDigree}",
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                  child: Text(
                                    "${getWishListModel?.data?.products![i].userAddress}",
                                    style: TextStyle(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                )
                    : SizedBox(),
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child:
                      // getWishListModel?.data?.products![i].image == null ||
                      //     getWishListModel?.data?.products![i].image == ""
                      //     ? Image.asset("assets/splash/splashimages.png")
                         // :
                    Image.network(
                        "${getWishListModel?.data?.products![i].image}",
                        fit: BoxFit.fill,
                        height: 250,
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${getWishListModel?.data?.products![i].title}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }
}
