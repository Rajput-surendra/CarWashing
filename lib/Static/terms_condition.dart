import 'dart:convert';

import 'package:doctorapp/New_model/GetSettingModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Helper/Appbar.dart';
import 'package:http/http.dart'as http;

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
    getSettingApi();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getSettingApi();
  }
  GetSettingModel? settingModel;
  var termsConditions;
  getSettingApi() async {
    var headers = {
      'Cookie': 'ci_session=eb651cdce0850614d296b81363913b2ca08fe641'
    };
    var request = http.Request('POST', Uri.parse('${ApiService.getSettings}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     final result =  await response.stream.bytesToString();
     final jsonResponse = json.decode(result);
     setState(() {
       termsConditions = jsonResponse['data']['terms_conditions'][0];
     });
     // var FinalResult = GetSettingModel.fromJson(jsonDecode(result));
     // print("thi osoks0  ============>${FinalResult}");
     // setState(() {
     //   settingModel = FinalResult;
     // });
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
             termsConditions == null || termsConditions == "" ? Center(child: CircularProgressIndicator()) :Html(
                 data: termsConditions
             )
           ],
         )
      ),
    );
  }
}
