import 'dart:convert';
import 'dart:io';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Color.dart';
import '../New_model/GetEventListDeteilsModel.dart';

import 'package:http/http.dart' as http;

class EventsEmageScreen extends StatefulWidget {

  EventsEmageScreen({Key? key, this.id}) : super(key: key);
  final String? id;


  @override
  State<EventsEmageScreen> createState() => _EventsEmageScreenState();
}

class _EventsEmageScreenState extends State<EventsEmageScreen> {
  GetEventListDeteilsModel? eventListDeteilsModel;

  getEventListApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? Roll = preferences.getString('roll');
    String? specialityId = preferences.getString('specialityId');
    print("getEventUserId--------------->${userId}");
    print("getRoll--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=2a74e1313ac4372b572217b9fc2f2d145677f21a'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getEvents}'));
    request.fields.addAll({
      'event_id': widget.id.toString(),
      'roll': '$Roll',
      'user_id': '$userId',
      'speciality_id':"${specialityId}"
    });
    print("event_id================>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final FinalResult = GetEventListDeteilsModel.fromJson(
          json.decode(result));
      print("this is a Event=============>${FinalResult}");
      setState(() {
        eventListDeteilsModel = FinalResult;
        eventListDeteilsModel?.data?[0].address;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getEventListApi();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
   GlobalKey<RefreshIndicatorState>();

  Future _refresh() {
    return callApi();
  }

  Future callApi() async {
    getEventListApi();
  }

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
                TextButton(onPressed: () {}, child: Text("View"))

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
    if (media == PermissionStatus.granted) {
      print(statuses[Permission.location]);
      final folderName = folderNames;
      final path = Directory("storage/emulated/0/$folderName");
      final path1 = await getExternalStorageDirectory();
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
      }
    } else {
      print("permission denied");
    }
    return "";
  }

  String? text;
  bool? istrue;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SafeArea(

        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
                child: Icon(Icons.arrow_back_ios_new)),
            backgroundColor: Colors.transparent, title: Text("Events"),centerTitle: true,),
          body: eventListDeteilsModel == null ? Center(child: CircularProgressIndicator(),) : Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  image: DecorationImage(image:NetworkImage(
                    "${ApiService.imageUrl}${eventListDeteilsModel
                        ?.data?[0].image}"), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20),

                  )
                ),
                  width: double.infinity,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${eventListDeteilsModel?.data?[0]
                            .name},',
                          style: TextStyle(
                              color: Colors.white, fontSize: 25),),
                        SizedBox(height: 5,),
                        Text('${eventListDeteilsModel?.data?[0]
                            .description},',
                  style: TextStyle(
                      color: Colors.white, fontSize: 14),),

                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [


                        Text(getDate(eventListDeteilsModel?.data?[0]
                            .startDate ?? '2023-05-25'), style: TextStyle(
                            color: Colors.white,
                            fontSize: 14),),
                        const SizedBox(
                          height: 15,
                          child: VerticalDivider(

                            thickness: 2, color: Colors.white,),
                        ),
                        Text(getDateYear(eventListDeteilsModel?.data?[0]
                            .startDate ?? '2023-05-25'), style: TextStyle(
                            color: Colors.white,
                            fontSize: 14),)
                        /*Text(getDate(eventListDeteilsModel?.data?[0]
                            .endDate ?? ''), style: TextStyle(
                            color: colors.blackTemp,
                            fontSize: 20),),*/
                      ],
                    ),
                  ],
                ),


              ),


              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          launchUrl(Uri.parse(eventListDeteilsModel?.data?[0].link ?? ''));
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.primary,
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Click Here To Registration",style: TextStyle(color: colors.whiteTemp,fontSize: 13),),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          showModalBottomSheet(
                              context: context,
                              builder: (context)
                              {
                                return Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${eventListDeteilsModel?.data?[0].name}",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
                                          Text("${eventListDeteilsModel?.data?[0].designation}",style: TextStyle(color: colors.blackTemp,fontSize: 15),),
                                          Text("${eventListDeteilsModel?.data?[0].mobile}",style: TextStyle(color: colors.blackTemp,fontSize: 15),),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.primary,
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sponsored",style: TextStyle(color: colors.whiteTemp),),
                          )),
                        ),
                      ),
                    ),
                  ],),
              ),
              SizedBox(height: 10,),
              Btn(
                height: 40,
                width: 340,
                color: colors.secondary,
                title: 'Download first annoncement PDF/JPG File',
                fSize: 12,
                onPress: () {
                  downloadFile(
                      '${ApiService.imageUrl}${eventListDeteilsModel?.data?[0]
                          .image}',
                      eventListDeteilsModel?.data?[0].docName ?? '');
                },
              ),
              SizedBox(height: 70,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: eventListDeteilsModel?.data?[0].profileImage == null ||
                    eventListDeteilsModel?.data?[0].profileImage == "" ? Image
                    .asset("assets/images/event img.png") : Container(
                    width: double.infinity,
                    child: Image.network(
                      "${ApiService.imageUrl}${eventListDeteilsModel?.data?[0]
                          .image}", fit: BoxFit.fill,)),
              )
            ],
          ),
        ),
      ),
    );


  }

 String getDate(String startDate){
    print('__________${startDate}_________');

  // var date  =  DateTime.parse(dateString);
  // DateFormat format =  DateFormat('LLLL');
  // var formattedDate = format.parse(dateString);
   var formattedDate =  DateTime.parse(startDate).formatted(format: 'MMMM')
       .toUpperCase();
   return formattedDate ;

 }
  String getDateYear(String startDate){
    print('__________${startDate}_________');

    // var date  =  DateTime.parse(dateString);
    // DateFormat format =  DateFormat('LLLL');
    // var formattedDate = format.parse(dateString);
    var formattedDate =  DateTime.parse(startDate).formatted(format: 'yyyy')
        .toUpperCase();
    return formattedDate ;

  }

  getOpen() {
    return AlertDialog(
      title: new Text(""),
      content: new Text(""),
      backgroundColor: colors.primary,
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        ElevatedButton(
          child: new Text(""),
          onPressed: () {

          },
        ),
        ElevatedButton(
          child: Text("yes"),
          onPressed: () {},
        ),
      ],
    );
  }

}
extension DateTimeExtension on DateTime {
  String formatted({String? format}) {
    return DateFormat(format ?? 'dd MMM yyyy, hh:mm a')
        .format(
      DateTime.parse(this.toString()).toLocal(),
    )
        .toString();
  }
}