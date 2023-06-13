import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Helper/Appbar.dart';
import '../New_model/GetSettingModel.dart';
import 'package:http/http.dart'as http;

import '../api/api_services.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

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
  var privacyPolicy;
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
        privacyPolicy = jsonResponse['data']['privacy_policy'][0];
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
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
          appBar:  customAppBar(text: "Privacy Policy",isTrue: true, context: context),
          body: ListView(
            children: [
              privacyPolicy == null ? Center(child: CircularProgressIndicator()) :Html(
                  data:"${privacyPolicy}"
              )
            ],
          )
      ),
    );
  }
}
