import 'dart:convert';

import 'package:doctorapp/New_model/CarWashing/Get_Model_car.dart';
import 'package:doctorapp/New_model/CarWashing/Get_brand_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../api/api_services.dart';
import 'Accessrioes.dart';

class ModelScreen extends StatefulWidget {
  String? branId;
   ModelScreen({Key? key,this.branId}) : super(key: key);

  @override
  State<ModelScreen> createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getModelApi();
  }
  GetModelCar? getModelCar;
  getModelApi() async {
    var headers = {
      'Cookie': 'ci_session=6f6d1e21291ca7058fbe06d969fff0d27d6c98d1'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getModelApi}'));
    request.fields.addAll({
      'brand_id': widget.branId.toString()
    });
    print('______request.fields____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult = GetModelCar.fromJson(jsonDecode(result));
      print('____finalResult______${finalResult}_________');
      setState(() {
        getModelCar = finalResult;
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
          appBar: customAppBar(context: context, text:"Model", isTrue: true, ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Column(
                children: [
                  getModelCar == null ? Center(child: CircularProgressIndicator()): getModelCar!.data == null ? Center(child: Text("No data Found!!"),):Container(
                    height: MediaQuery.of(context).size.height/1.2,
                    child: GridView.builder(
                      itemCount: getModelCar!.data!.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Accessories(modelId: getModelCar!.data![index].id,)));
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
                                          child: Image.network("${getModelCar!.data![index].image}",fit: BoxFit.fill,))),
                                  SizedBox(height: 15,),
                                  Text("${getModelCar!.data![index].cName}")
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
