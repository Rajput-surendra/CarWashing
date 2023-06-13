import 'dart:convert';

import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetSelectCatModel.dart';
import 'package:http/http.dart'as http;

import '../api/api_services.dart';

class FilterSpeciality extends StatefulWidget {
  const FilterSpeciality({Key? key}) : super(key: key);

  @override
  State<FilterSpeciality> createState() => _FilterSpecialityState();
}

class _FilterSpecialityState extends State<FilterSpeciality> {

  @override
  void initState() {
    // TODO: implement initState
    getCatApi();
    super.initState();

  }
  GetSelectCatModel? selectCatModel;
  getCatApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? Roll = preferences.getString('roll');
    String? userId = preferences.getString('userId');
    print("getRoll--------------->${Roll}");

    var headers = {
      'Cookie': 'ci_session=742f7d5e34b7f410d122da02dbbe7e75f06cadc8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.selectCategory}'));
    request.fields.addAll({
      'roll': '1',
      'cat_type': "2",
      'user_id':'$userId'
    });
    print("this is a Response==========>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //preferences.setString('id', "Id");
      final result =  await response.stream.bytesToString();
      final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));

      setState(() {
        selectCatModel = finalResult;
      });

    }

    else {
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          elevation: 0,
          backgroundColor: colors.whiteTemp,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(1),bottomLeft: Radius.circular(1)),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.secondary,
                    colors.secondary,
                  ],
                  stops: [
                    0,
                    1,
                  ]),
            ),
          ),
          leading: InkWell(
              onTap: (){
                Navigator.pop(context, );
              },
              child:
              //isTrue?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios_new_outlined,color: colors.whiteTemp,),
              )
                  //:SizedBox()
          ),
          title: Text('Filter Speciality',style: TextStyle(color: Colors.white,fontSize: 20),),
          actions: [
            // InkWell(
            //   onTap: (){
            //     Navigator.pop(context);
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(8),
            //     child: InkWell(
            //         onTap: (){
            //          // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
            //         },
            //         child: Icon(Icons.search,color: colors.whiteTemp,)),
            //   ),
            // ),
          ],


        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              SizedBox(
                // height:MediaQuery.of(context).size.height/1.0,
                child:  selectCatModel?.data == null ? Center(child: CircularProgressIndicator()) :
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: selectCatModel!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return   InkWell(
                        onTap: () async {
                         // SharedPreferences preferences = await SharedPreferences.getInstance();

                       //  preferences.setString('sId', selectCatModel?.data?[index].id ?? '');
                         // String? id = preferences.getString('sId');
                        // print('___ddgfdg_______${id}_________');

                          Navigator.pop(context, selectCatModel?.data?[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:  Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                              height:MediaQuery.of(context).size.height/13,
                              width:MediaQuery.of(context).size.width/1.09,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                   color: selectCatModel?.data?[index].isSelected ?? false ?colors.secondary:colors.transparent,
                                //border: Border.all(color: index%2 == 0 ? colors.primary:colors.secondary),borderRadius: BorderRadius.circular(11),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: index%2 == 0?colors.primary:colors.secondary,
                                      maxRadius:27,child: Text('${selectCatModel?.data?[index].name.toString().characters.first.characters}',style:
                                    TextStyle(fontSize: 25,color:colors.lightWhite2),),

                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Text('${selectCatModel?.data?[index].name}',style: TextStyle(fontWeight: FontWeight.w700,color: selectCatModel?.data?[index].isSelected ?? false ? colors.whiteTemp:colors.black54))
                                ],
                              ),
                            ),
                          )
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
