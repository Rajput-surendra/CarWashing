
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/registration_model2.dart';
import 'package:http/http.dart'as http;

import '../api/api_services.dart';
import 'drverification.dart';

List <String>_selectedItems2 = [];
List<String> _selectedItems3 = [];
class Hospital extends StatefulWidget {
  String title, name, mobile, email,gender,pass,cPass,cityName,stateID,cityID,placeID,degree,profileImages,roll,categoryId,experience;
   Hospital({Key? key,required this.title,required this.name,required this.mobile,required this.email,required this.gender,required this.cityName,required this.cityID,required this.cPass,required this.pass,required this.degree,required this
   .placeID,required this.profileImages,required this.stateID,required this.roll,required this.categoryId,required this.experience}) : super(key: key);

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {

  bool isLoading = false;
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime1;
  TimeOfDay? _selectedTimeNew;
  TimeOfDay? _selectedTimeOld;
  List<String>? results;
  List? results1;
  void _showMultiSelect() async {
     results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState)
              {
                return
                  MultiSelect();
              }
          );
        }
    );
     setState(() {

     });

     print("checking result here ${results.runtimeType}");



  }
  void _showMultiSelect2() async {
    results1 = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState)
              {
                return
                  HospitalDay();
              }
          );
        }
    );
    setState(() {
    });
    print("checking result here ${results1}");
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime) {

      setState(() {
        _selectedTime = pickedTime;
      });
      print('_____sfgfdgfdg_____${_selectedTime!.format(context)}_________');
    }

  }

  Future<void> chooseTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime1 ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime1) {
      setState(() {
        _selectedTime1 = pickedTime;
      });
    }
  }

  Future<void> selectTimeStart(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeNew ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTimeNew) {

      setState(() {
        _selectedTimeNew = pickedTime;
      });
      print('_____sfgfdgfdg_____${_selectedTimeNew!.format(context)}_________');
    }

  }
  Future<void> chooseTimeEnd(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeOld ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTimeOld) {
      setState(() {
        _selectedTimeOld = pickedTime;
      });
    }
  }
  //
  TextEditingController addressC = TextEditingController();
  TextEditingController numberC = TextEditingController();
  TextEditingController addressC1 = TextEditingController();
  TextEditingController numberC1 = TextEditingController();
  TextEditingController experience1 = TextEditingController();
  TextEditingController experienceC1 = TextEditingController();
  TextEditingController clinicNameC = TextEditingController();
  TextEditingController clinicNameC1 = TextEditingController();
  //
  // List <List<String>> selectedClinicTime = [];
  // List<List<String>> clinicDay = [];
  // List<List<String>> selectedClinicMorningTime = [];
  // List<List<String>> selectedClinicEveningTime = [];
  // List<List<String>> selectedClinicAddress = [];
  // List<List<String>> selectedClinicName = [];
  // List<List<String>> selectedClinicAppointment = [];
  //
  // List<String> selectedClinicMorningTimeTemp = [];
  // List <String> selectedClinicEveningTimeTemp = [];
  // List <String> selectedClinicAddressTemp = [];
  // List <String> selectedClinicNameTemp = [];
  // List <String> selectedClinicAppointmentTemp = [];
  // List<String> clinicDayTemp = [];
  //
  // List<String> allDataAdd = [];

  List  clinicListForJson = [];
  List  encodeClinicForJson = [];
  
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  bool show =false;

  registration() async {
    isLoading ==  true;

    if(false ){
      Fluttertoast.showToast(msg: 'Please add profile photo');
    }
    else {
      String? token;
      try {
        token = await FirebaseMessaging.instance.getToken();
      } on FirebaseException {
      }
      List newList = [];

      for(int i = 0; i< clinicListForJson.length; i++){
        print('${clinicListForJson[i]['days']}____________');
        newList.add(jsonEncode({
          "days":clinicListForJson[i]['days'],
          "clinic_name":clinicListForJson[i]['clinic_name'],
          "morning_shift":clinicListForJson[i]['morning_shift'],
          "evening_shift":clinicListForJson[i]['evening_shift'],
          "addresses":clinicListForJson[i]['addresses'],
          "appoint_number":clinicListForJson[i]['appoint_number'],
        }));
      }




      var headers = {
        'Cookie': 'ci_session=7484a255faa8a60919687a35cf9c56e5c55326d2'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiService.userRegister}'));
      request.fields.addAll({
        'email': widget.email,
        'mobile':widget.mobile,
        'username': widget.name,
        'gender':widget.gender,
        'doc_degree':widget.degree,
        'address': "",
        'c_address':" ",
        'cat_type':"",
        'category_id':widget.categoryId,
        'designation_id':"",
        'password':widget.pass,
        'roll': widget.roll,
        'confirm_password':widget.cPass,
        'fcm_id': token ?? '',
        'city': widget.cityName,
        'title': widget.title,
        "company_name": "",
        "company_division":"",
        "state_id":widget.stateID,
        "city_id":widget.cityID,
        "area_id":widget.placeID,
        "experience":widget.experience,
        "json": '${newList}'

      });
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'image', widget.profileImages ?? ''));
      }
      print('my fields-------${request.fields}');
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        addressC.clear();
        results?.clear();
        numberC.clear();
        _selectedTime = null;
        _selectedTime1 = null;
        _selectedTimeNew = null;
        _selectedTimeOld = null;
        final reslut = await response.stream.bytesToString();
        print('____assadsdddsa______${reslut}_________');
        var finalResult = jsonDecode(reslut);
        int?  otp = finalResult['data']['otp'];
        String?  mobile = finalResult['data']['mobile'];
        Fluttertoast.showToast(msg: finalResult['message']);

        if (!finalResult['error']) {
          Fluttertoast.showToast(msg: finalResult['message']);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewCerification (otp: otp.toString(),mobile:mobile)));
        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print(response.reasonPhrase);
      }
      //}
    }
  }
  String? days;
  String? daysHos;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: customAppBar(context: context, text:"Clinic/Hospital Details", isTrue: true, ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Clinic/Hospital Details",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 18),),
                const SizedBox(height: 10,),
                clinicListForJson.isEmpty ? SizedBox():  Container(
                  height: clinicListForJson.isEmpty ? 0: 180,
                  child:ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount:clinicListForJson.length ,
                      reverse: true,
                      itemBuilder: (BuildContext context, int i) {
                      print('____asasdsadsadasd______${clinicListForJson.length}_________');
                      print('__Clinic Data_____${clinicListForJson[i]}_________');
                     // print('____asasdsadsasfdssfsfsdasd___sfffretgret___${clinicListForJson[morning_shift]}_________');
                    //  print('____Dhahgujhgdjkgfdj_____${clinicListForJson[i]['morning_shift_new']}_________');
                      return Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child:Padding(
                                padding: const EdgeInsets.only(left: 20,top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(clinicListForJson[i]['days'].toString()),
                                    SizedBox(
                                      width: 200, child: Text("${clinicListForJson[i]['morning_shift']}",overflow: TextOverflow.ellipsis,maxLines: 1)),
                                    const SizedBox(height: 3,),
                                    Text("${clinicListForJson[i]['evening_shift']}"),
                                    // SizedBox(
                                    //     width: 200, child: Text("${clinicListForJson[i]['morning_shift_new']}",overflow: TextOverflow.ellipsis,maxLines: 1)),
                                    // const SizedBox(height: 3,),
                                    // Text("${clinicListForJson[i]['evening_shift_old']}"),
                                    // const SizedBox(height: 3,),
                                    Text("${clinicListForJson[i]['addresses']}"),
                                    Text("${clinicListForJson[i]['clinic_name']}",),
                                    const SizedBox(height: 3,),
                                    Text("${clinicListForJson[i]['appoint_number']}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 15,),
                const Text("Clinic/Hospital Days",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                const SizedBox(height:15,),
                select(),
                const SizedBox(height:15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(" Morning Shift Start ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        MorningShift(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(" Morning Shift End ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        EveningShift(),
                      ],
                    )


                  ],
                ),
                const SizedBox(height:15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(" Evening Shift Start",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                        SizedBox(height:5,),
                        MorningShiftStart(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(" Evening Shift End ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                        const SizedBox(height:5,),
                        EveningShiftEnd(),
                      ],
                    )


                  ],
                ),
                const SizedBox(height:15,),
                const Text("Clinic/Hospital Name",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                const SizedBox(height:5,),
                Container(
                  child: TextFormField(
                    controller: clinicNameC,
                    decoration: InputDecoration(
                        hintText:"Clinic Name",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Clinic/Hospital is required";
                      }
                    },
                  ),
                ),
                const SizedBox(height:15,),
                const Text("Clinic/Hospital Address",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                const SizedBox(height:5,),
                Container(
                  child: TextFormField(
                      controller: addressC,
                    decoration: InputDecoration(
                      hintText:"Address",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Clinic/Hospital Address is required";
                      }
                    },
                  ),
                ),
                SizedBox(height:15,),
                const Text("Clinic/Hospital Appoint Number",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                SizedBox(height:5,),
                Container(
                  child: TextFormField(

                    controller: numberC,
                    maxLines: 1,
                    //maxLength: 10,
                    keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                          hintText:"Mobile Number",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                      ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "mobile number is required";
                      }
                    },

                  ),
                ),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.topRight,
                  child: Btn(
                      height: 50,
                      width: MediaQuery.of(context).size.width/2.8,
                      title: isLoading ? "Please wait......" : 'Add',
                      color: colors.secondary,
                      onPress: () {
                        if(_formKey.currentState!.validate()){
                         Fluttertoast.showToast(msg: 'Data Add Successfully');
                         if (_formKey.currentState!.validate()) {
                           days = results!.join(",");
                           clinicListForJson.add({
                             "days":days,
                             "clinic_name":clinicNameC.text,
                             "morning_shift":"${_selectedTime!.format(context)} - ${_selectedTime1?.format(context)}",
                             "evening_shift":"${_selectedTimeNew!.format(context)} - ${_selectedTimeOld!.format(context)}",
                             "addresses":addressC.text,
                             "appoint_number":numberC.text,
                           });

                           print('${clinicListForJson.length}______________length');
                           print('${clinicListForJson.first}______________');

                           clinicListForJson.forEach((element) {print(element);});
                           print('${clinicListForJson.first}__________0');
                           addressC.clear();
                           results?.clear();
                           numberC.clear();
                           _selectedTime = null;
                           _selectedTime1 = null;
                           _selectedTimeNew = null;
                           _selectedTimeOld = null;

                         } else {
                           Fluttertoast.showToast(
                               msg: "Fill All field ",
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.BOTTOM,
                               timeInSecForIosWeb: 1,
                               backgroundColor: colors.secondary,
                               textColor: Colors.white,
                               fontSize: 16.0
                           );
                           //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                         }



                        }
                      }),
                ),
                SizedBox(height: 20,),
                /////////////////////////Hospital///////////////////////////////////
                // SizedBox(height: 20,),
                // const Text("Hospital",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 18),),
                // SizedBox(height: 15,),
                // selectHospital(),
                // SizedBox(height:15,),
                // const Text("Hospital Morning Shift ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                // SizedBox(height:5,),
                // MorningShiftHospital(),
                // SizedBox(height:15,),
                // const Text("Hospital Evening Shift",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                // SizedBox(height:5,),
                // EveningShiftHospital(),
                // SizedBox(height:15,),
                // const Text("Experience",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                // SizedBox(height:5,),
                // Container(
                //   height: 50,
                //   child: TextFormField(
                //       controller: experienceC1,
                //       decoration: InputDecoration(
                //           counterText: "",
                //           hintText:"Experience",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                //       )
                //   ),
                // ),
                // SizedBox(height: 15,),
                // const Text("Hospital Address",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                // SizedBox(height:5,),
                // Container(
                //   height: 50,
                //   child: TextFormField(
                //       controller: addressC1,
                //       decoration: InputDecoration(
                //           hintText:"Address",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                //       )
                //   ),
                // ),
                // SizedBox(height:15,),
                // const Text("Hospital Name",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                // SizedBox(height:5,),
                // Container(
                //   height: 50,
                //   child: TextFormField(
                //       controller: clinicNameC1,
                //       decoration: InputDecoration(
                //           hintText:"Hospital Name",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                //       )
                //   ),
                // ),
                // SizedBox(height:15,),
                // const Text("Hospital Appoint Number",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                // SizedBox(height:5,),
                // Container(
                //   height: 50,
                //   child: TextFormField(
                //       controller: numberC1,
                //       maxLines: 1,
                //       maxLength: 10,
                //       keyboardType: TextInputType.number,
                //       decoration: InputDecoration(
                //           counterText: "",
                //           hintText:"Appoint Number",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                //       )
                //   ),
                // ),
                // SizedBox(height: 20,),
                Center(
                  child: Btn(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.0,
                      title: isLoading ? "Please wait......" : 'Submit',
                      color: colors.secondary,
                      onPress: () {
                        if(clinicListForJson.isNotEmpty){
                          registration();
                        }
                        else if (_formKey.currentState!.validate()) {
                          days = results!.join(",");
                        clinicListForJson.add(json.encode({
                        "days":days,
                        "clinic_name":clinicNameC.text,
                        "morning_shift":"${_selectedTime!.format(context)} - ${_selectedTime1?.format(context)}",
                        "evening_shift":"${_selectedTimeNew!.format(context)} - ${_selectedTimeOld!.format(context)}",
                        "addresses":addressC.text,
                        "appoint_number":numberC.text,
                        }));
                         print('my encoded json is --------${encodeClinicForJson}');
                        } else {
                            Fluttertoast.showToast(
                                msg: "Fill All field ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: colors.secondary,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                        }


                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget select() {
    return InkWell(
      onTap:_selectedItems2 == null ? (){
        Fluttertoast.showToast(msg: 'Please Select Days',backgroundColor: colors.secondary);
      }: () {
      setState(() {
        _showMultiSelect();
      });
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: colors.white10,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black.withOpacity(0.7))),
        child: results == null
            ? const Padding(
              padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
              child: Text(
            'Select Days',
            style: TextStyle(
              fontSize: 16,
              color: colors.black54,
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
            :
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: results!.map((e){
                return Padding(
                  padding: const EdgeInsets.only(top: 10,left: 1,right: 1),
                  child: Container(
                    width:45,
                    height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: colors.secondary),
                      child: Center(child: Text("${e}",style: TextStyle(color: colors.whiteTemp),))),
                );
              }).toList(),
            )

      ),
    );
  }
  Widget MorningShift() {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime != null
                  ? '${_selectedTime!.format(context)}'
                  : 'Morning Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget EveningShift() {
    return  InkWell(
      onTap: () {
        chooseTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime1 != null
                  ? '${_selectedTime1!.format(context)}'
                  : 'Evening Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget MorningShiftStart() {
    return InkWell(
      onTap: () {
        selectTimeStart(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTimeNew != null
                  ? '${_selectedTimeNew!.format(context)}'
                  : 'Morning Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget EveningShiftEnd() {
    return  InkWell(
      onTap: () {
        chooseTimeEnd(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTimeOld != null
                  ? '${_selectedTimeOld!.format(context)}'
                  : 'Evening Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget selectHospital() {
    return InkWell(
      onTap:_selectedItems3 == null ? (){
        Fluttertoast.showToast(msg: 'Please Select Days',backgroundColor: colors.secondary);
      }: () {
        setState(() {
          _showMultiSelect2();
        });
      },
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: colors.white10,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black.withOpacity(0.7))),
          child: results1 == null
              ? const Padding(
            padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
            child: Text(
              'Select Days',
              style: TextStyle(
                fontSize: 16,
                color: colors.black54,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
              :
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: results1!.map((e){
              return Padding(
                padding: const EdgeInsets.only(top: 10,left: 1,right: 1),
                child: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: colors.secondary),
                    child: Center(child: Text("${e}",style: TextStyle(color: colors.whiteTemp),))),
              );
            }).toList(),
          )

      ),
    );
  }

}
class MultiSelect extends StatefulWidget {
  // String type;
  // required this.type
  MultiSelect({Key? key, }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}
class _MultiSelectState extends State<MultiSelect> {
  List selectedItems = [];
  List<String> eventCat = [];
  bool isChecked = false;
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
      setState(() {
        _selectedItems2.add(itemValue);
      });
      } else {
       setState(() {
         _selectedItems2.remove(itemValue);
       });
      }
    });
    print("this is selected values ${_selectedItems2.toString()}");
  }
  void _cancel() {
    Navigator.pop(context);
  }
  void _submit() {
    List selectedItem = _selectedItems2.map((item) => item).toList();
    //Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_selectedItems2.clear();
  }
  String finalList = '';
  var dayList = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState)
        {
          return
            AlertDialog(
              title: const Text('Select Days'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: dayList
                      .map((data) =>
                  CheckboxListTile(
                    activeColor: colors.primary,
                    value: _selectedItems2.contains(data),
                    title: Text(data),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(data, isChecked!),

                  )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel',
                    style: TextStyle(color: colors.primary),),
                  onPressed: _cancel,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: colors.primary
                  ),
                  child: Text('Submit'),
                  onPressed: () {
                    print("selected values are here ${_selectedItems2}");
                    //_submit();

                    Navigator.pop(context, _selectedItems2);

                  }
                ),
              ],
            );
        }
    );
  }

}
class HospitalDay extends StatefulWidget {
  const HospitalDay({Key? key}) : super(key: key);

  @override
  State<HospitalDay> createState() => _HospitalDayState();
}
class _HospitalDayState extends State<HospitalDay> {
  List selectedItems = [];
  List<String> eventCat = [];
  bool isChecked = false;
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        setState(() {
          _selectedItems3.add(itemValue);
        });
      } else {
        setState(() {
          _selectedItems3.remove(itemValue);
        });
      }
    });
    print("this is selected values ${_selectedItems3.toString()}");
  }
  void _cancel() {
    Navigator.pop(context);
  }
  void _submit() {
    List selectedItem = _selectedItems3.map((item) => item).toList();
    //Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _selectedItems3.clear();
  }
  String finalList = '';
  var dayList1 = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];
  @override
  Widget build(BuildContext context) {
    return  StatefulBuilder(
        builder: (context, setState)
        {
          return
            AlertDialog(
              title: const Text('Select Days'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: dayList1
                      .map((data) =>
                      CheckboxListTile(
                        activeColor: colors.primary,
                        value: _selectedItems3.contains(data),
                        title: Text(data),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) => _itemChange(data, isChecked!),

                      )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel',
                    style: TextStyle(color: colors.primary),),
                  onPressed: _cancel,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.primary
                    ),
                    child: Text('Submit'),
                    onPressed: () {
                      print("selected values are here ${_selectedItems3}");
                      //_submit();

                      Navigator.pop(context, _selectedItems3);

                    }
                ),
              ],
            );
        }
    );
  }
}

