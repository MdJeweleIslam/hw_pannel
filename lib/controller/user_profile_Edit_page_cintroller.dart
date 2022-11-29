import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Colors.dart';

class UserProfileEditPageController extends GetxController {

  ///input box controller
  final userNameController = TextEditingController().obs;
  final userPhoneController = TextEditingController().obs;
  final userFbUrlController = TextEditingController().obs;


  var selectGenderId="".obs;
  var userName="Abdullah".obs;
  var userPhone="01994215664".obs;
  var userFbUrl="http://facebook.com/test".obs;
  var data = [].obs;
  ///input box color and operation
  var userNameLevelTextColor = hint_color.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    RetrieveUserInfo();


  }



  updateUserNameLevelTextColor(Color value) {
    userNameLevelTextColor(value);
  }


  ///get data from share pref
  void RetrieveUserInfo() async {
    try {

      var storage =GetStorage();
      userNameController.value.text=userName.value;
      userPhoneController.value.text=userPhone.value;
      userFbUrlController.value.text=userFbUrl.value;


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