import 'dart:convert';

import 'package:doctorapp/New_model/GetSettingModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Helper/Appbar.dart';
import 'package:http/http.dart'as http;

import '../Helper/Color.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({Key? key}) : super(key: key);

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  @override


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getTermsConditionsDataApi();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getTermsConditionsDataApi();
  }
  GetSettingModel? settingModel;
  var termsConditions;
  var termsConditionsTitle;
  getTermsConditionsDataApi() async {
    var headers = {
      'Cookie': 'ci_session=0972dd56b7dcbe1d24736525bf2ee593c03d46de'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getTermsConditionsApi}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('_______sdfsdfsdf___${response.statusCode}_________');
      final result =  await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      print('______asdsadsa____${result}_________');
      setState(() {
        termsConditions = jsonResponse['setting']['html'];
        termsConditionsTitle = jsonResponse['setting']['title'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar:  customAppBar(text: "Terms & Condition",isTrue: true, context: context),
         body: ListView(

           children: [
             Padding(
               padding: const EdgeInsets.only(left: 8,top: 5),
               child: Text("${termsConditionsTitle}",style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.bold),),
             ),
             termsConditions == null || termsConditions == "" ? Center(child: CircularProgressIndicator()) :Html(
                 data: termsConditions
             )
           ],
         )
      ),
    );
  }
}
