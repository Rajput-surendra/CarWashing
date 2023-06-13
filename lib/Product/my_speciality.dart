
import 'dart:convert';
import 'dart:math';

import 'package:doctorapp/New_model/GetSelectCatModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../AuthenticationView/LoginScreen.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/pharma_products_category_response.dart';
import '../AuthenticationView/Signup.dart';


class MySpeciality extends StatefulWidget {
   MySpeciality({Key? key,}) : super(key: key);

  @override
  State<MySpeciality> createState() => _MySpecialityState();
}
class _MySpecialityState extends State<MySpeciality> {
  GetSelectCatModel? selectCatModel;
  getCatApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? Roll = preferences.getString('roll');
    print("getRoll--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=742f7d5e34b7f410d122da02dbbe7e75f06cadc8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.selectCategory}'));
    request.fields.addAll({
      'roll': '1'
    });
    print("this is a Response==========>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     final result =  await response.stream.bytesToString();
     final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));
     print("this is =============>${finalResult}");
     setState(() {
       selectCatModel = finalResult;
     });

    }

    else {
    print(response.reasonPhrase);
    }
  }
  // bool isPrime(int number) {
  //   if (number <= 1) {
  //     return false;
  //   }
  //   for (int i = 2; i <= sqrt(number); i++) {
  //     if (number % i == 0) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }


  int? number;

  @override
  void initState() {
    // TODO: implement initState
    getCatApi();
    super.initState();

  }
  List <PharmaProductCategoryDataList> pharmaProductListOld = [];




  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context: context, text:"My Speciality", isTrue: true, ),
        body: SingleChildScrollView(
          child: Column(
            children:[
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
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>SignupScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height:MediaQuery.of(context).size.height/13,
                            width:MediaQuery.of(context).size.width/1.09,
                            decoration: BoxDecoration(

                              border: Border.all(color: index%2 == 0 ? colors.primary:colors.secondary),borderRadius: BorderRadius.circular(11),
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
                                Text('${selectCatModel?.data?[index].name}',style: TextStyle(fontWeight: FontWeight.w700),)
                              ],
                            ),
                          ),
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

