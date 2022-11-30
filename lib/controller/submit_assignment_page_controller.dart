
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

class SubmitAssignmentPageController extends GetxController {
  final assignmentLinkController = TextEditingController().obs;
  var userNameLevelTextColor = hint_color.obs;

  // var selectName="".obs;

  var selectAssignmentId="".obs;
  var hw_studentId="".obs;

  var data = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserIdFromSharePref();
  }

  void updateAssignmentList(List newList){
    data=newList as RxList;
  }

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {

      var storage =GetStorage();

      storage.read(pref_user_batch);

      storage.read(exam_panel_pref_user_id);
      hw_studentId(storage.read(pref_user_id));
    // _showToast("student batch= "+storage.read(pref_user_batch));

      getAssignmentList(batchId: storage.read(pref_user_batch));

    } catch (e) {

    }

  }

  ///get Assignment list
  void getAssignmentList({required String batchId }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
              // Uri.parse("https://hw.arenaclass.stream/apk/apk-assignment/?batch_id=13"),
             Uri.parse('$BASE_URL_API$SUB_URL_API_GET_ASSIGNMENT_LIST$batchId'),
            
          );
          //  _showToast("${response.statusCode}");
          if (response.statusCode == 200) {
            var dataResponse = jsonDecode(response.body);
            data(dataResponse["data"]);
           // _showToast(data.length.toString());
          }
          else{
           
          }

        } catch (e) {

          // Log(e.toString());
          _showToast(e.toString());
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {

      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
    //updateIsFirstLoadRunning(false);
  }

  ///submit Assignment
  void submitAssignment({
    required String submitUrl,
    required String topicId,
    required String studentId,
  }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await post(
              Uri.parse('$BASE_URL_API$SUB_URL_API_SUBMIT_ASSIGNMENT'),
              // Uri.parse('https://hw.arenaclass.stream/apk/apk-assignment/'),
              body: {
                'submit_url':submitUrl,
                'topic_id':topicId,
                'student_id':studentId,
              }
          );
           // _showToast("${response.statusCode}");
          if (response.statusCode == 200) {

            var data = jsonDecode(response.body);
            _showToast(data["message"].toString());
            if(data['error']==false){
              assignmentLinkController.value.text="";
            }

          }
          else {
            var data = jsonDecode(response.body);
           _showToast(data["message"].toString());

          }
        } catch (e) {

          // Log(e.toString());
          _showToast(e.toString());
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {

      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
    //updateIsFirstLoadRunning(false);
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