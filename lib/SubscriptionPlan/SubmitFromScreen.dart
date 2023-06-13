import 'dart:convert';

import 'package:doctorapp/Screen/Bottom.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../Screen/HomeScreen.dart';
import '../api/api_services.dart';

class SubmitFromScreen extends StatefulWidget {
  String? planId,amount,title,days;
  bool? Purchased;
  SubmitFromScreen({Key? key,this.planId,this.amount,this.title,this.days,this.Purchased}) : super(key: key);

  @override
  State<SubmitFromScreen> createState() => _SubmitFromScreenState();
}

class _SubmitFromScreenState extends State<SubmitFromScreen> {
  List<String> timeList = [
    '11:00 PM - 11:30 PM',
    '11:30 PM  - 12:00 AM',
    "12:00 AM  - 12:30 PM",
    "12:30 PM - 1:00 PM",
  ];

  String selectedTime = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();


  Razorpay? _razorpay;
  int? pricerazorpayy;
  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  getplanPurchaseSuccessApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=bd34a0e21152859762f3a4ee6615cbbd5acdcee2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getPlanPurchasApi}'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'plan_id': widget.planId.toString(),
      'transaction_id': 'ugjyjjh',
      'amount': widget.amount.toString(),
      'time_slot': '${selectedTime}',
      'name': nameController.text,
      'address': addressController.text,
      'mobile': mobileController.text
    });
    print('__________${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =   await response.stream.bytesToString();
      final finalResult = json.decode(result);
      Fluttertoast.showToast(msg: finalResult['message']);
      print('____Sdfdfdfdff______${finalResult}_________');
      setState(() {
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomScreen()));
    }
    else {
      print(response.reasonPhrase);
    }

  }
  String id = '';
  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
    print("checking razorpay price ${pricerazorpayy.toString()}");

    print("checking razorpay price ${pricerazorpayy.toString()}");
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${pricerazorpayy}",
      'name': 'Lucent',
      'image':'assets/splash/splashimages.png',
      'description': 'Lucent',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    getplanPurchaseSuccessApi();
   // Fluttertoast.showToast(msg: "Subscription added successfully");
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
    // setSnackbar("ERROR", context);
    // setSnackbar("Payment cancelled by user", context);
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: colors.darkIcon,
      appBar: customAppBar(context: context, text:"Booking", isTrue: true, ),
      body:
      SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Title:"),
                                  SizedBox(height: 5,),
                                  Text("Amount:"),
                                  SizedBox(height: 5,),
                                  Text("Days:"),
                                  SizedBox(height: 5,)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${widget.title}",style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text("₹ ${widget.amount}",style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text("${widget.days}",style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold),)
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Your Name",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )


                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color:
                      colors.whiteTemp,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    style: TextStyle(color: colors.black54),
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixText: "",
                        hintText: 'Enter Name',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, color: colors.primary,fontWeight: FontWeight.normal),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 5)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "name is required";
                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        const Text(
                          "Mobile No",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color:
                      colors.whiteTemp,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    style: TextStyle(color: colors.black54),
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counterText: "",
                        hintText: 'Enter Mobile',
                        hintStyle:
                        TextStyle(fontSize: 15.0, color: colors.secondary),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.length != 10) {
                        return "mobile number is required";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Address",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )


                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color:
                      colors.whiteTemp,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    style: TextStyle(color: colors.black54),
                    controller: addressController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixText: "",
                        hintText: 'Enter Address',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, color: colors.primary,fontWeight: FontWeight.normal),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "address is required";
                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )

                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: timeList.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c,i){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedTime = timeList[i];
                        });
                        print("selected time here  ${selectedTime}");
                      },
                      child: Container(
                      alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                           color: selectedTime == timeList[i] ? colors.primary : colors.whiteTemp,
                            // width: selectedTime == timeList[i] ? 2 :1

                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text("${timeList[i]}", style: TextStyle(color:selectedTime == timeList[i] ? colors.whiteTemp : colors.primary),),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 50,),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      // openCheckout(widget.amount);
                      if(widget.Purchased ?? false){
                        Fluttertoast.showToast(msg: "You all ready purchased plan",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:colors.secondary,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }else{
                        openCheckout(widget.amount);
                        id =widget.planId ?? '' ;
                      }
                    }
                    else{
                      Fluttertoast.showToast(msg: "All Field are required");
                    }
                  },
                  child: Container(

                    height: 45,
                    decoration: BoxDecoration(
                      color: colors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child:Text("Buy Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,color: colors.whiteTemp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
