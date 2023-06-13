import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/Brand/Model_Screen.dart';
import 'package:doctorapp/New_model/CarWashing/Get_brand_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../api/api_services.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({Key? key}) : super(key: key);

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBrandApi();
  }
  GetBrandModel? getBrandModel;
  getBrandApi() async {
    var headers = {
      'Cookie': 'ci_session=6f6d1e21291ca7058fbe06d969fff0d27d6c98d1'
    };
    var request = http.Request('POST', Uri.parse('${ApiService.getBrandApi}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult = GetBrandModel.fromJson(jsonDecode(result));
     print('____finalResult______${finalResult}_________');
     setState(() {
       getBrandModel = finalResult;
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
        backgroundColor: colors.darkIcon,
        appBar: customAppBar(context: context, text:"Brand", isTrue: true, ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              getBrandModel == null ? Center(child: CircularProgressIndicator()): getBrandModel!.data == null ? Center(child: Text("No data Found!!"),):Container(
                height: MediaQuery.of(context).size.height/1.2,
                child: GridView.builder(
                  itemCount: getBrandModel!.data!.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ModelScreen(branId:getBrandModel!.data![index].id,)));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                              Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                      child: Image.network("${getBrandModel!.data![index].image}",fit: BoxFit.fill,))),
                            SizedBox(height: 15,),
                            Text("${getBrandModel!.data![index].title}")
                          ],
                        )
                      ),
                    );
                  },
                ),
               )
            ]
          ),
        )
      ),
    );
  }
}
