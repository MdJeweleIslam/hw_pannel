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

  var userName="".obs,fullName="".obs,userBatch="".obs,userType="".obs,userId="".obs;

  @override
  void onInit() {
    super.onInit();
    RetriveUserInfo();
  }

  ///get data from share pref
  loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      storage.read(hw_pannel_pref_user_uid);
      storage.read(hw_pannel_pref_user_id);
    } catch(e) {
      //code
    }

  }

  void RetriveUserInfo() async {
    try {

      var storage =GetStorage();
      userName(storage.read(pref_user_name)??"");
      fullName(storage.read(pref_full_name)??"");
      userBatch(storage.read(pref_user_batch)??"");
      userType(storage.read(pref_user_type)??"");
      userId(storage.read(pref_user_id)??"");


     // _showToast( storage.read(hw_pannel_pref_user_uid));
      storage.read(hw_pannel_pref_user_uid);
      storage.read(hw_pannel_pref_user_id);


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