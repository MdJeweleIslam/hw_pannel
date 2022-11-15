
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Colors.dart';
import '../api_service/sharePreferenceDataSaveName.dart';

class NavigationDrawerPageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    RetriveUserInfo();

  }

  var userName="qqq".obs,fullName="www".obs,userBatch="".obs,userType="".obs,userId="".obs;











  void RetriveUserInfo() async {
    try {

      var storage =GetStorage();
      userName(storage.read(pref_user_name)??"");
      fullName(storage.read(pref_full_name)??"");
      userBatch(storage.read(pref_user_batch)??"");
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




}