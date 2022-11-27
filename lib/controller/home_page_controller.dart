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


  ///user info variable
  var userName="".obs,fullName="".obs,
      userBatch="".obs,userBatchName="".obs,
      pendingAssignmentCount="".obs,
      doneAssignmentCount="".obs,
      totalAssignmentCount="".obs,
      userType="".obs,userId="".obs,email="".obs;

  @override
  void onInit() {
    super.onInit();
    RetriveUserInfo();
  }

  ///get user data from share pref
  void RetriveUserInfo() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name)??"");
      email(storage.read(pref_user_email)??"");
      fullName(storage.read(pref_full_name)??"");
      userBatch(storage.read(pref_user_batch)??"");
      userBatchName(storage.read(pref_user_batch_name)??"");
      userType(storage.read(pref_user_type)??"");
      userId(storage.read(pref_user_id)??"");

      pendingAssignmentCount(storage.read(pref_user_total_pending_assignment_count)??"");
      doneAssignmentCount(storage.read(pref_user_total_done_assignment_count)??"");
      totalAssignmentCount(storage.read(pref_user_total_assignment_count)??"");

    }catch(e){

    }

  }




  ///toast create
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