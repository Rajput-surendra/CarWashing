import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetWishListModel.dart';
import '../api/api_services.dart';
import 'package:http/http.dart' as http;

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  void initState() {
    getWishListApi(0);
    // TODO: implement initState
    super.initState();
  }

  int selectedSegmentVal = 0;

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
      getWishListApi(i);
    });
    // getOrderList(status: status);
  }

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          context: context,
          text: "WishList",
          isTrue: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _segmentButton(),
              SizedBox(
                  // height: MediaQuery.of(context).size.height/1.0,
                  child: getWishListModel?.data == null ||
                          getWishListModel?.data == ""
                      ? Center(child: CircularProgressIndicator())
                      : getWishListModel?.data?.news?.isEmpty ?? true ? Center(child: Text('News not available'),) : selectedSegmentVal == 0
                      ?ListView.builder(
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
                        return  webinarsCustomCards();
                      })

                      :getWishListModel?.data?.editorial?.isEmpty ?? true ? Center(child: Text('Editorial not available'),) : selectedSegmentVal == 3
                      ?ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.editorial?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return   editorialCustomCards();
                      })

                      :getWishListModel?.data?.awareness?.isEmpty ?? true ? Center(child: Text('Awareness not available'),) : selectedSegmentVal == 4
                      ? ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.awareness?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return awarenessCustomCards();
                      }):SizedBox()
                  )
            ],
          ),
        ));
  }

  removeWishListApi(String id, int i) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=9516fbdbc1268c93318355a5c0da4a6841deb646'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getRemoveWishListApi}'));
    request.fields.addAll(
        {
          'user_id': '$userId',
          "prod_id": "$id"
        });
    print("getEventUserId-------1111111-------->${request.fields}");

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      getWishListApi(i);
      Fluttertoast.showToast(msg: finalResult['message']);
    } else {
      print(response.reasonPhrase);
    }
  }
  GetWishListModel? getWishListModel;
  getWishListApi(int i) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=579af58e6f03e48e089abbbe963a0b6ff69888d3'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getNewsWishListApi}'));
    request.fields.addAll({
      'user_id': '$userId',

    });
    print("this is a wishListReprocess=============>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = GetWishListModel.fromJson(jsonDecode(result));
      print("this is a wishListReprocess=============>${finalResult}");
      setState(() {
        getWishListModel = finalResult;
        print("MYYYYYYYYYYYYYYYYYYYYYYY${getWishListModel?.data?.news?.first.image}");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  newCustomCards(model, int i) {
    print('imagesssssssssssssssssssssssssss${getWishListModel?.data?.news![i].userImage}');
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
                                            style: const TextStyle(
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
                                          children: ['Remove from wishlist']
                                              .map(
                                                (e) => InkWell(
                                                  onTap: () async {
                                                    removeWishListApi(
                                                        getWishListModel
                                                                ?.data?.news!.first.id ??
                                                            "", 0);
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
                      )
                    : SizedBox(),
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
                        Container(
                          width: 310,
                          child: Text('${getWishListModel?.data?.news![i].title}',overflow: TextOverflow.ellipsis,)),
                        Container(
                            width: 310,
                            child: Text('${getWishListModel?.data?.news![i].description}',overflow: TextOverflow.ellipsis,)),
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
                                    children: ['Remove from wishlist']
                                        .map(
                                          (e) => InkWell(
                                        onTap: () async {
                                          removeWishListApi(
                                              getWishListModel
                                                  ?.data?.event![i].id ??
                                                  "", 1);
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
                )
                    : SizedBox(),
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
                        Container(
                            width: 310,
                            child: Text('${getWishListModel?.data?.event![i].title}',overflow: TextOverflow.ellipsis,)),
                        Container(
                            width: 310,
                            child: Text('${getWishListModel?.data?.event![i].description}',overflow: TextOverflow.ellipsis,)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(

                  height: 10,
                )
              ],
            ),
          )),
    );
  }
  webinarsCustomCards(){
   return Column(
     children: [
       SizedBox(
         child: getWishListModel?.data == null ? Center(child: CircularProgressIndicator())  : getWishListModel?.data?.webinar!.isEmpty ?? false ? Text("Not Approved by Admin"):
         ListView.builder(
             scrollDirection: Axis.vertical,
             physics: NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             reverse: true,
             itemCount: getWishListModel?.data!.webinar!.length,
             itemBuilder: (BuildContext context, int index) {
               return  Card(
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
                           Text('${getWishListModel?.data!.webinar![index].startDate.toString().substring(0,10)}',style: TextStyle(color: Colors.white,fontSize: 15),),
                           SizedBox(width: 20,),
                           Padding(
                             padding: const EdgeInsets.only(top: 5,bottom: 5),
                             child: VerticalDivider(thickness: 1,color: colors.whiteTemp,),
                           ),
                           SizedBox(width: 20,),
                           Text('${getWishListModel?.data!.webinar![index].fromTime}',style: TextStyle(color: Colors.white,fontSize: 15),),
                         ],
                       ),
                     ),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Image.asset("assets/splash/splashimages.png",height: 100,width: 100,),
                         //  webinarModel?.data?[index].image == null || webinarModel?.data?[index].image == "" ?CircleAvatar(
                         //    backgroundImage: AssetImage('assets/splash/splashimages.png'),
                         //  ):Image.network('${ApiService.imageUrl}${webinarModel?.data?[index].image},',height: 80,width:80,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: [

                                 Text('${getWishListModel?.data!.webinar![index].title}',style: TextStyle(fontSize: 14,color: colors.secondary),),
                                 const SizedBox(width: 150,),
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
                                                 children: ['Remove from wishlist']
                                                     .map(
                                                       (e) => InkWell(
                                                     onTap: () async {
                                                       removeWishListApi(
                                                           getWishListModel
                                                               ?.data?.webinar![index].id ??
                                                               "", 2);
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
                             SizedBox(height: 3),
                             Text('${getWishListModel?.data!.webinar![index].userName}',style: TextStyle(fontSize: 10,),),
                             SizedBox(height: 3),
                             Text('${getWishListModel?.data!.webinar![index].userDigree}',style: TextStyle(fontSize: 10,),),
                             SizedBox(height: 3),
                             Text('${getWishListModel?.data!.webinar![index].userAddress}',style: TextStyle(fontSize: 10,),),
                             SizedBox(height: 3),
                             Text('${getWishListModel?.data!.webinar![index].description}',style: TextStyle(fontSize: 10,),),
                             SizedBox(height: 15,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                   height: 25,
                                   child: ElevatedButton(
                                       onPressed: (){
                                         launch('${getWishListModel?.data!.webinar![index].link}');
                                       },
                                       style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                       child: Text('Live link',style: TextStyle(color: Colors.white,fontSize: 10),)),
                                 ),
                                 SizedBox(width: 10),
                                 Container(
                                   height: 25,
                                   child: ElevatedButton(onPressed: (){
                                     downloadFile('${getWishListModel?.data!.webinar![index].image}', getWishListModel?.data!.webinar![index].userName??'');
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
                             SizedBox(height: 20,)

                           ],
                         ),
                       ],
                     ),

                   ],
                 ),
               );
             }),
       ),
     ],
   );
  }
  editorialCustomCards(){
   return Column(
     children: [
       SizedBox(
         child: getWishListModel!.data!.editorial == null ? Center(child: CircularProgressIndicator())  : getWishListModel!.data!.editorial!.isEmpty?? false ? Text("Not Approved by Admin"):
         ListView.builder(
             scrollDirection: Axis.vertical,
             physics: NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: getWishListModel!.data!.editorial!.length,
             itemBuilder: (BuildContext context, int index) {
               return Card(
                   elevation: 5,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 5),
                            child: Text("${getWishListModel!.data!.editorial![index].date?.substring(0,10)}",style: TextStyle(fontSize: 15,color: colors.secondary)),
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
                                          children: ['Remove from wishlist']
                                              .map(
                                                (e) => InkWell(
                                              onTap: () async {
                                                removeWishListApi(
                                                    getWishListModel
                                                        ?.data?.editorial!.first.id ??
                                                        "", 3);
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
                       Divider(thickness: 1,color: colors.black54.withOpacity(0.2),),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [

                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: ClipRRect(
                                 borderRadius: BorderRadius.circular(10),
                                 child: Image.asset('assets/images/tablets.png',height: 90,width:100,)),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 10),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('${getWishListModel!.data!.editorial![index].title}',style: TextStyle(fontSize: 14,color: colors.blackTemp,fontWeight: FontWeight.bold),),
                                 SizedBox(height: 2),
                                 Text('${getWishListModel!.data!.editorial![index].userDigree}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                                 SizedBox(height: 2),
                                 Text('${getWishListModel!.data!.editorial![index].userAddress}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
                                 SizedBox(height: 2),
                                 SizedBox(height: 15,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text('Dr. ${getWishListModel!.data!.editorial![index].userName}',style: TextStyle(fontSize: 10,color: colors.secondary),),
                                     SizedBox(width: 10,),
                                     Container(
                                       height: 25,
                                       child: ElevatedButton(onPressed: (){
                                          downloadFile('${getWishListModel!.data!.editorial![index].image}', getWishListModel!.data!.editorial![index].userName??'');
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
                                 SizedBox(height: 20,)
                               ],
                             ),
                           ),
                         ],
                       ),
                     ],
                   )


               );
             }),
       ),
     ],
   );
  }
  awarenessCustomCards(){
   return Column(
     children: [
       // SizedBox(
       //   height: 50,
       //   child:  aaaaaModel?.data == null ? Center(child: CircularProgressIndicator())  : aaaaaModel?.data?.isEmpty?? false ? Text("Not Approved by Admin"):
       //   ListView.builder(
       //       scrollDirection: Axis.horizontal,
       //       shrinkWrap: true,
       //       itemCount: aaaaaModel!.data!.length,
       //       itemBuilder: (BuildContext context, int index) {
       //         return
       //           Padding(
       //             padding: const EdgeInsets.only(left: 8,top: 10,right: 8),
       //             child: InkWell(
       //               onTap: (){
       //                 setState(() {
       //                   //getNewListApi();
       //                   _currentIndex = index;
       //                 });
       //                 print("this is curent index ${_currentIndex.toString()}");
       //               },
       //               child:
       //               Container(
       //                 padding: EdgeInsets.only(left: 15,right: 15),
       //                 height: 50,
       //                 width: 85,
       //                 //width: MediaQuery.of(context).size.width/3.5,
       //                 decoration: BoxDecoration(
       //                     color: _currentIndex ==  index ?
       //                     colors.secondary
       //                         : colors.primary.withOpacity(0.2),
       //                     borderRadius: BorderRadius.circular(5)
       //                 ),
       //                 child: Center(
       //                   child: Text("${aaaaaModel!.data![index].title}",style: TextStyle(color: _currentIndex == index ?colors.whiteTemp:colors.blackTemp)),
       //                 ),
       //               ),
       //             ),
       //
       //           );
       //       }),
       // ),
     ],
   );
  }
  productCustomCards(){
   return Column(
     children: const [
       Text("productCustomCards")
     ],
   );
  }

}
