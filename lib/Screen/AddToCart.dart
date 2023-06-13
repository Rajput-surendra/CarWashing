import 'dart:convert';

import 'package:doctorapp/Screen/AddAddress.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetUserCartModel.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key,this.pid}) : super(key: key);
  final pid;
  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  GetUserCartModel? userCartModel;
  getUserCartApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    var headers = {
      'Cookie': 'ci_session=472e980cd4075e2ad3588b57ee360c52cf204358'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUserCart}'));
    request.fields.addAll({
      'user_id': '$userId'
    });
    print("this--------------->${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = GetUserCartModel.fromJson(jsonDecode(result));
      print("getEventUserId--------------->${finalResult}");
      setState(() {
        userCartModel = finalResult;
      });
      print("is empty===========>${userCartModel}");
    }
    else {
    print(response.reasonPhrase);
    }

  }


  String addressType = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController2 = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int currentIndex = 1;

  getRemoveCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    var headers = {
      'Cookie': 'ci_session=51a471437729ba5f9b1d085be010c59cf36ebf24'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getRemoveCartApi}'));
    request.fields.addAll({
      'user_id': '$userId',
      //'product_variant_id': '${userCartModel.}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      getUserCartApi();
     final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);
      Fluttertoast.showToast(msg: finalResult['message']);
      print('thi i si  mi========?${finalResult}');
    }
    else {
    print(response.reasonPhrase);
    }

  }

  getPlaceOrderApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? mobile = preferences.getString('userMobile');
    print("getEventUserId1111111111111--------------->${mobile}");
    var headers = {
      'Cookie': 'ci_session=c4961f2c1bf92b901ce6f6097b19128aa6382998'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getPlaceOrderApi}'));
    request.fields.addAll({
      'user_id': '$userId',
      'mobile': '$mobile',
      'product_variant_id': widget.pid,
      'final_total': '120',
      'address_id': '${deliveryAddres}'
    });
    print("getEventUserId222222222222222222--------------->${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      getRemoveCart();
      final resutl =  await response.stream.bytesToString();
      final finalResult = json.decode(resutl);
      Fluttertoast.showToast(msg: finalResult['message']);
      print("ttttttttttttttttt=>${finalResult}");
     setState(() {
       deliveryAddres == null;
     });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String? name;
  String? mobile1;
  String? address;
  String? email;
   getAddressList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
   name = preferences.getString('name');
   mobile1 = preferences.getString('mobile1');
   address = preferences.getString('address');
   email = preferences.getString('email');
    print("Surendra name------------------>${name}");
    print("Surendra-mobile1----------------->${mobile1}");
    print("Surendra-address----------------->${address}");
    print("Surendra-email----------------->${email}");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressList();
    getUserCartApi();
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future _refresh() {
    return callApi();
  }
  Future callApi() async {
    getUserCartApi();
  }
  var deliveryAddres;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      key: _refreshIndicatorKey,
      child: Scaffold(
        bottomSheet:
        Container(
            height: 60,
            child: InkWell(
              onTap: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (context)
                      {
                        return Container(
                          height: 230,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                            /*  InkWell(
                                  onTap: ()async{
                                    var result = await  Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress()));
                                    print("sfsfsfsdsssf ${result}");
                                    if(result == "" || result == null){
                                    }
                                    else{
                                     setState(() {
                                       deliveryAddres = result;
                                     });
                                    }
                                    // }else
                                    //   deliveryAddres == null || deliveryAddres == "" ?
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress())):SizedBox();
                                  },
                                  child: Center(
                                    child: Center(child: Text("Add Address")
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: TextFormField(
                                    //     autofocus: true,
                                    //     readOnly: false,
                                    //     decoration: InputDecoration(
                                    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    //     hintText: "Add Address"
                                    //   ),),
                                    // )
                                    ),
                                  )
                                // Container(
                                //   height: 40,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(5),
                                //       color: colors.primary
                                //   ),
                                //   alignment: Alignment.center,
                                //   child: Text("Add Address",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                                // ),
                              ) : SizedBox.shrink(),*/
                               deliveryAddres == null || deliveryAddres == ""  ?
                              Card(
                                child: Container(
                                  height: 120,
                                  child: Padding(
                                      padding: const EdgeInsets.only(),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          name == null ? Padding(
                                            padding: const EdgeInsets.only(top: 15,left: 10),
                                            child: Text("Shipping Address"),
                                          ):   Padding(
                                            padding: const EdgeInsets.only(top: 10,left: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Name: ${name}",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
                                                SizedBox(height: 2,),
                                                Text("Mobile: ${mobile1}"),
                                                SizedBox(height: 2,),
                                                Text("Email: ${email}"),
                                                SizedBox(height: 2,),
                                                Text("Address: ${address}"),
                                              ],
                                            ),
                                          ),
                                        name == null ?  Padding(
                                            padding: const EdgeInsets.only(),
                                            child: TextButton(onPressed: () async {
                                            var result = await  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(name: name,address: address,email: email,mobile: mobile1,)));
                                            if(result != null){
                                             name = result['name'];
                                             mobile1 = result['mobile1'];
                                             email = result['email'];
                                             address = result['address'];
                                             getAddressList();
                                             getUserCartApi();
                                            }

                                            }, child:Text("Add Address",style: TextStyle(color: Colors.deepOrangeAccent,)))
                                          ):Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Change Address",style: TextStyle(color: Colors.deepOrangeAccent,)),
                                          )
                                        ],
                                      )

                                  ),
                                ),
                              ): SizedBox.shrink(),

                              SizedBox(height: 10,),


                             InkWell(
                                onTap: (){
                                  if(deliveryAddres == null || deliveryAddres == " ") {
                                   // Fluttertoast.showToast(msg: "please Add Address");
                                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress()));
                                    Navigator.pop(context);
                                    getPlaceOrderApi();
                                  }else{
                                    Navigator.pop(context);
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors.secondary,
                                      ),
                                      height: 45,
                                      width: 150,
                                      child: Center(child: Text("PlaceOrder",style: TextStyle(color: colors.whiteTemp),)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  );

              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.secondary
                    ),
                    child: Center(child: Text("Checkout ",style: TextStyle(color: colors.whiteTemp),)),
                  ),
                ),
              ),
            )
        ),
        //
        //   Btn(
        //     height: 50,
        //     width: MediaQuery.of(context).size.width/1.5,
        //     title: 'Generate Enquiry ',
        //     onPress: () {
        //       if(deliveryAddres == null || deliveryAddres == ""){
        //         Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress()));
        //       }else
        //         deliveryAddres == null || deliveryAddres == "" ?
        //         Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress())):
        //         getPlaceOrderApi();
        //     },
        //   ),
        // ),
        appBar: customAppBar(context: context, text:"Cart", isTrue: true, ),
        body: userCartModel  == null ?Center(child: CircularProgressIndicator()):Padding(
          padding: const EdgeInsets.only(top: 10,left: 5,right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: userCartModel?.data == null ? Center(child: CircularProgressIndicator()) :
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userCartModel!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: ClipRRect(
                                           borderRadius: BorderRadius.circular(10),
                                           child: Image.network('${ApiService.imageUrl}${userCartModel!.data![index].image}',height: 90,width:100,)),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.only(top: 10),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text('${userCartModel!.data![index].name}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.bold),),
                                           SizedBox(height: 2),
                                           Container(
                                               width: 220,
                                               child: Text('${userCartModel!.data![index].productDetails![0].shortDescription}',maxLines: 4,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: colors.blackTemp),)),

                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                                 InkWell(
                                   onTap: (){
                                     getRemoveCart();
                                   },
                                   child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.only(bottom: 55,right: 5),
                                         child: Icon(Icons.close),
                                       )
                                     ],
                                   ),
                                 )
                               ],
                             )
                            ],
                          )


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
