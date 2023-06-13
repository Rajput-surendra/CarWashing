import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key,this.name,this.address,this.mobile,this.email}) : super(key: key);
  final name,address,mobile,email;

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.name);
    addressController = TextEditingController(text: widget.address);
    mobileController2 = TextEditingController(text: widget.mobile);
    emailController = TextEditingController(text: widget.email);
  }

  String addressType = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController2 = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: customAppBar(context: context, text:"Add Address", isTrue: true, ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
          children: [
            TextFormField(
              validator: (v){
                if(v!.isEmpty){
                  return "Enter Name";
                }
              },
              controller: nameController,decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                )
            ),),
            SizedBox(height: 10,),
            // TextFormField(
            //   validator: (v){
            //     if(v!.isEmpty){
            //       return "Enter Address";
            //     }
            //   },
            //   controller: addressController,
            //   decoration: InputDecoration(
            //     hintText: "Recipient's Address",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(6),
            //       borderSide: BorderSide(color: Colors.grey),
            //     )
            // ),),
            // SizedBox(height: 10,),
            // TextFormField(
            //   validator: (v){
            //     if(v!.length != 10){
            //       return "Enter correct number";
            //     }
            //   },
            //   keyboardType: TextInputType.number,
            //   maxLength: 10,
            //   controller: mobileController1,decoration: InputDecoration(
            //     hintText: "Recipient's Mobile",
            //     counterText: "",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(6),
            //       borderSide: BorderSide(color: Colors.grey),
            //     )
            // ),),
            // SizedBox(height: 10,),
            TextFormField(
              validator: (v){
                if(v!.length != 10){
                  return "Enter mobile";
                }
              },
              maxLength: 10,
              keyboardType: TextInputType.number,
              controller: mobileController2,decoration: InputDecoration(
                hintText: "Mobile",
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                )
            ),),

            SizedBox(height: 10,),
            // TextFormField(
            //   validator: (v){
            //     if(v!.isEmpty){
            //       return "Enter Address";
            //     }
            //   },
            //   controller: addressController,
            //   decoration: InputDecoration(
            //     hintText: "Recipient's Address",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(6),
            //       borderSide: BorderSide(color: Colors.grey),
            //     )
            // ),),
            // SizedBox(height: 10,),
            // TextFormField(
            //   validator: (v){
            //     if(v!.length != 10){
            //       return "Enter correct number";
            //     }
            //   },
            //   keyboardType: TextInputType.number,
            //   maxLength: 10,
            //   controller: mobileController1,decoration: InputDecoration(
            //     hintText: "Recipient's Mobile",
            //     counterText: "",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(6),
            //       borderSide: BorderSide(color: Colors.grey),
            //     )
            // ),),
            // SizedBox(height: 10,),
            TextFormField(
              // validator: (v){
              //   if(v!.contains('@')){
              //     return "Enter Email";
              //   }
              // },
              keyboardType: TextInputType.emailAddress,
              controller: emailController,decoration: InputDecoration(
                hintText: "Email",
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                )
            ),),
            SizedBox(height: 10,),
            TextFormField(
              validator: (v){
                if(v!.isEmpty){
                  return "Enter Address";
                }
              },
              controller: addressController,decoration: InputDecoration(
                hintText: "Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                )
            ),),
            SizedBox(height: 20,),
            InkWell(
              onTap: () async{
                SharedPreferences preferences = await SharedPreferences.getInstance();
                if(_formKey.currentState!.validate()) {
                  preferences.setString("name", nameController.text);
                  preferences.setString("address", addressController.text);
                  preferences.setString("email", emailController.text);
                  preferences.setString("mobile1", mobileController2.text);
                  Navigator.pop(context,{
                    "name":nameController.text,
                    "address":addressController.text,
                    "email":emailController.text,
                    "mobile1":mobileController2.text,

                  });
                }
                else{
                  Fluttertoast.showToast(msg: "All Fields are required");
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: colors.secondary
                ),
                child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
