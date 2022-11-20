import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ntp/ntp.dart';

import '../Colors.dart';
import '../api_service/sharePreferenceDataSaveName.dart';

class HomePageController extends GetxController {

  var userName="".obs,fullName="".obs,userBatch="".obs,userBatchName="".obs,userType="".obs,userId="".obs,email="".obs;

  @override
  void onInit() {
    super.onInit();
    RetriveUserInfo();
  }

  ///get data from share pref
  loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      storage.read(exam_pannel_pref_user_uid);
      storage.read(exam_panel_pref_user_id);
    } catch(e) {
      //code
    }

  }
  void RetriveUserInfo() async {
    try {

      var storage =GetStorage();
     // _showToast( "name "+storage.read(pref_full_name).toString());
      userName(storage.read(pref_user_name)??"");
      email(storage.read(pref_user_email)??"");
      fullName(storage.read(pref_full_name)??"");
      userBatch(storage.read(pref_user_batch)??"");
      userBatchName(storage.read(pref_user_batch_name)??"");
      userType(storage.read(pref_user_type)??"");
      userId(storage.read(pref_user_id)??"");



    } catch (e) {

      //code


    }


    // sharedPreferences.setString(pref_user_UUID, userInfo['data']["user_name"].toString());
    // sharedPreferences.setBool(pref_login_firstTime, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_cartID, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_county, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_city, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_state, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_nid, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_nid, userInfo['data']["user_name"].toString());


  }




  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}