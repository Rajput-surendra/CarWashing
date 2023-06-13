import 'dart:convert';

import 'package:doctorapp/Helper/Appbar.dart';
import 'package:doctorapp/New_model/update_profile_response.dart';
import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Helper/AppBtn.dart';
import '../Helper/Color.dart';
import '../api/api_services.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final cPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(text: "Update password", isTrue: true, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Old Password",
                    style: TextStyle(
                        color: colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: oldPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: '',
                      hintStyle: const TextStyle(
                          fontSize: 15.0, color: colors.secondary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.only(left: 10, top: 10)),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "password is required";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "New Password",
                    style: TextStyle(
                        color: colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: newPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: '',
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: colors.secondary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.only(left: 10, top: 10)),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "password is required";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Confirm New Password",
                    style: TextStyle(
                        color: colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: '',
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: colors.secondary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.only(left: 10, top: 10)),
                  validator: (v) {
                    if (cPasswordController.text != newPasswordController.text) {
                      return "password must be same";
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Btn(
                    color: colors.secondary,
                    height: 50,
                    width: 320,
                    title: 'Update Password',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        updateProfile();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${ApiService.getUserProfile}'));
    request.fields.addAll({
      'user_id': userId ?? '',
      'old': oldPasswordController.text,
      'new': newPasswordController.text,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final response2 = await response.stream.bytesToString();

      final result = UpdateprofileResponse.fromJson(jsonDecode(response2));

      if (result.error == false) {
        print('__________${response2}_____________');

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.message ?? '')));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.message ?? '')));
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
