import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/pharma_products_response.dart';

import 'package:http/http.dart'as http;

import '../Screen/AddToCart.dart';

class IpcaProductScreen2 extends StatefulWidget {
  const IpcaProductScreen2({Key? key,this.PharmaProduct}) : super(key: key);
  final PharmaProduct ;

  @override
  State<IpcaProductScreen2> createState() => _IpcaProductScreen2State();
}

class _IpcaProductScreen2State extends State<IpcaProductScreen2> {



  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      getProoductListDetails();
    });

  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
    getProoductListDetails();
  }
  GetPharmaProducts? pharmaProducts;
  getProoductListDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    var headers = {
      'Cookie': 'ci_session=a630fb673049b6a5421081e350d6b8be2b23ab2c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getPharmaProducts}'));
    request.fields.addAll({
      'product_variant_ids': widget.PharmaProduct,
    });
    print("thi si i9 s=------------>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========>${result}");
      final finalResult = GetPharmaProducts.fromJson(json.decode(result));
      print("thi i smom 00000000000000=========>${finalResult}");
      setState(() {
        pharmaProducts = finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }

  getManageCartApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    var headers = {
      'Cookie': 'ci_session=c4961f2c1bf92b901ce6f6097b19128aa6382998'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getManageCartApi}'));
    request.fields.addAll({
      'user_id': '$userId',
      'product_variant_id': widget.PharmaProduct,
      'qty': '1'
    });
    print("thi si i9 s=------------>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToCart(pid: widget.PharmaProduct,)));
     final resutl =  await response.stream.bytesToString();
     final finalResult = json.decode(resutl);
     Fluttertoast.showToast(msg: finalResult['message']);
     print("ttttttttttttttttt=>${finalResult}");
    }
    else {
    print(response.reasonPhrase);
    }

  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context: context, text:"Ipca Products", isTrue: true, ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: pharmaProducts == null || pharmaProducts == "" ?Center(child: CircularProgressIndicator()):Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      color: colors.transparent
                  ),
                  child:Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(maxRadius:27,child: Text('${pharmaProducts!.data![0].name!.substring(0,1)}',style:
                          const TextStyle(fontSize: 20,color:colors.lightWhite2),),),
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text('${pharmaProducts!.data![0].name}',style: const TextStyle(fontWeight: FontWeight.w700),),
                            ),
                            Container(
                                width:250,
                                child: Text('${pharmaProducts!.data![0].shortDescription}',maxLines: 7,overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.grey),))

                          ],)                  ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 110,
                      child: ElevatedButton(onPressed: (){
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
                                        Text("${pharmaProducts?.data?[0].indication}",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                      },
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                          child: Text('Indication',style: TextStyle(color: Colors.white,fontSize: 10),)),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      height: 40,
                      width: 110,
                      child: ElevatedButton(onPressed: (){

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
                                          Text("${pharmaProducts?.data?[0].dosage}",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                          );

                      },
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                          child: Text('Dosage',style: TextStyle(color: Colors.white,fontSize: 10),)),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      height: 40,
                      width: 110,
                      child: ElevatedButton(onPressed: (){
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
                                        Text("${pharmaProducts?.data?[0].rxInfo}",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                      },
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                          child: Text('Rx info',style: TextStyle(color: Colors.white,fontSize: 10),)),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Column(children: [
                  SizedBox(
                    height:40,
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      getManageCartApi();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToCart()));
                    },
                        style: ElevatedButton.styleFrom(primary: colors.darkYellow),
                        child: Text('Add to Cart',style: TextStyle(color: Colors.white,fontSize: 15),)),
                  )
                ],),
                SizedBox(height: 40,),
                _CarouselSlider()
              ],
            ),
          ),
        ),

      ),
    );
  }
  int currentindex = 0;
  _CarouselSlider(){
    return  Padding(
      padding: EdgeInsets.only(
          top: 18, bottom: 18, left: 10, right: 10),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration:
          Duration(milliseconds: 150),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 350,
          onPageChanged: (position, reason) {
            setState(() {
              currentindex = position;
            });
            print(reason);
            print(
                CarouselPageChangedReason.controller);
          },
        ),
        items: pharmaProducts?.data?.map((val) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10)),
            // height: 180,
            // width: MediaQuery.of(context).size.width,
            child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10),
                child: Image.network(
                  "${val.image}",
                  fit: BoxFit.fill,
                )),
          );
        }).toList(),
      ),
    );

  }
}
