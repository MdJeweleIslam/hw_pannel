
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../Colors.dart';
import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';

class ProfileViewPageController extends GetxController {

  var userFullName="Abdullah".obs;
  var userGender="Male".obs;
  var userPhoneNumber="0199421564".obs;
  var userFacebookLink="http://facebook.com/test".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserIdFromSharePref();
  }

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {

      var storage =GetStorage();

      storage.read(pref_user_batch);

      // storage.read(exam_panel_pref_user_id);
      // hw_studentId(storage.read(pref_user_id));

    } catch (e) {

    }

  }

//toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }



}