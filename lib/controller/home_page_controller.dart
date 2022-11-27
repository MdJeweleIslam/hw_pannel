import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:ntp/ntp.dart';

import '../Colors.dart';
import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';

class HomePageController extends GetxController {


  ///user info variable
  var userName="".obs,fullName="".obs,
      userBatch="".obs,userBatchName="".obs,
      pendingAssignmentCount="".obs,
      doneAssignmentCount="".obs,
      totalAssignmentCount="".obs,
      userType="".obs,
      userId="".obs,
      email="".obs,
      hw_user_api_key="".obs;

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
      hw_user_api_key(storage.read(pref_user_api_key)??"");

      pendingAssignmentCount(storage.read(pref_user_total_pending_assignment_count)??"");
      doneAssignmentCount(storage.read(pref_user_total_done_assignment_count)??"");
      totalAssignmentCount(storage.read(pref_user_total_assignment_count)??"");
      getAssignmentData(userKey: hw_user_api_key.value);

    }catch(e){

    }

  }


  ///get Assignment count data
  void getAssignmentData({required String userKey }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(

           Uri.parse('$BASE_URL_API$SUB_URL_API_SUBMIT_ASSIGNMENT_COUNT_DATA$userKey/'),

          );
          // _showToast("${response.statusCode}");
          if (response.statusCode == 200) {
            var dataResponse = jsonDecode(response.body);
           // data(dataResponse["data"]);
            if(dataResponse['error']==false){
              // _showToast(dataResponse["message"].toString());
              userBatchName(dataResponse["data"]['batch_name'].toString());
              pendingAssignmentCount(dataResponse["data"]['pending'].toString());
              doneAssignmentCount(dataResponse["data"]['done'].toString());
              totalAssignmentCount(dataResponse["data"]['total'].toString());

            }



          }
          else{
            var dataResponse = jsonDecode(response.body);
            // data(dataResponse["data"]);
            _showToast(dataResponse["message"].toString());
          }

        } catch (e) {

          // Log(e.toString());
          _showToast(e.toString());
          // Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {

      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
    //updateIsFirstLoadRunning(false);
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