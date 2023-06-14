import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
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
    getPrivacyPolicyApiApi();
  }
  void initState() {
    super.initState();
    getPrivacyPolicyApiApi();
  }
  var privacyPolicy;
  var privacyPolicyTitle;
  getPrivacyPolicyApiApi() async {
    var headers = {
      'Cookie': 'ci_session=0972dd56b7dcbe1d24736525bf2ee593c03d46de'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getPrivacyPolicyApi}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('_______sdfsdfsdf___${response.statusCode}_________');
      final result =  await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      print('______asdsadsa____${result}_________');
      setState(() {
        privacyPolicy = jsonResponse['setting']['html'];
        privacyPolicyTitle = jsonResponse['setting']['title'];
      });
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
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 5),
                child: Text("${privacyPolicyTitle}",style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.bold),),
              ),
               privacyPolicy == null ? Center(child: CircularProgressIndicator()) :
              Html(
                  data:"${privacyPolicy}"
              )
            ],
          )
      ),
    );
  }
}
