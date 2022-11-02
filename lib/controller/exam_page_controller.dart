import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:ntp/ntp.dart';

import '../Colors.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../model/individual_classroom_quiz_all_list_model.dart';

class ExamPageController extends GetxController {

  final shortQuestionNameController = TextEditingController().obs;
  final shortQuestionOptionNameController = TextEditingController().obs;
  var answerOption="".obs;
  var optionList = [].obs;

  late Timer timer;
  var startTxt = "00:00:00".obs;
  var otpCountDownSecond = 0.obs;

  var isCountingStatus = false.obs;

  var upcomingExamText = "Up Coming".obs;
  var getTime = "".obs;

  var classRoomId = "10".obs;
  var uid = "156fa72f-729f-48a7-b0ff-5cb165e31b64".obs;

  var userName="".obs,fullName="".obs,userBatch="".obs,userType="".obs,userId="".obs;

  var classRoomQuizList=[].obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   getExamList();
  //   diffSecond();
  //   RetriveUserInfo();
  //   updateIsCountingStatus(false);
  //  // int a=int.parse(otpCountDownSecond.value);
  //  // startTimer(otpCountDownSecond);
  //  // startTimer(40);
  //  // startTimer(int.parse(otpCountDownSecond));
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getExamList();

  }

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


  diffSecond() {
    DateTime dt1 = DateTime.parse("2021-12-23 11:50:50");
    DateTime dt2 = DateTime.parse("2021-12-23 11:50:10");
    Duration diff = dt1.difference(dt2);

    if (diff.inSeconds > 0) {
      updateOtpCountDownSecond(diff.inSeconds);
      startTimer(diff.inSeconds);
    }
  }

  void startTimer(var second) {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (second <= 0) {
          // _upcomingExamText = "Start Exam";
          updateUpcomingExamText("Start Exam");
          updateIsCountingStatus(true);
         // _isCountingStatus = true;
          timer.cancel();
        }
        else {
          second--;
          updateStartTxt(_printDuration(Duration(seconds: second)));
         // _startTxt = _printDuration(Duration(seconds: second));
        }
      },
    );
  }

  ///timer cancel
  void cancelTimer(){
    timer.cancel();
    updateStartTxt("00:00:00");

  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHour = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHour:$twoDigitMinutes:$twoDigitSeconds";
  }

  updateUpcomingExamText(String value) {
    upcomingExamText(value);
  }
  updateStartTxt(String value) {
    startTxt(value);

  }
  updateIsCountingStatus(bool value) {
    isCountingStatus(value);
  }

  updateAnswerOption(String value) {
    answerOption(value);
  }
  updateOtpCountDownSecond(int value) {
    otpCountDownSecond(value);
  }

  updateGetTime(String value) {
    getTime(value);
  }

  Future<void> main() async {
    [
      'time.google.com',
      'time.facebook.com',
      'time.euro.apple.com',
      'pool.ntp.org',
    ].forEach(_checkTime);
  }

  Future<void> _checkTime(String lookupAddress) async {
    DateTime _myTime;
    DateTime _ntpTime;

    /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
    _myTime = DateTime.now();

    /// Or get NTP offset (in milliseconds) and add it yourself
    final int offset = await NTP.getNtpOffset(
        localTime: _myTime, lookUpAddress: lookupAddress);

    _ntpTime = _myTime.add(Duration(milliseconds: offset));

    print('\n==== $lookupAddress ====');
    print('My time: $_myTime');
    print('NTP time: $_ntpTime');
    print('Difference: ${_myTime.difference(_ntpTime).inMilliseconds}ms');

    var devicedateUtc = DateTime.now().toUtc();
    var ntpdateUtc = _ntpTime.toUtc();

    updateGetTime(
        'Device time: $_myTime' +
            '\nNtp time: $_ntpTime' +
            '\nDevice utc: $devicedateUtc' +
            '\nNtp utc: $ntpdateUtc'

    );

    // setState(() {
    //   // _showToast(' $_myTime');
    //   getTime = 'Device time: $_myTime' +
    //       '\nNtp time: $_ntpTime' +
    //       '\nDevice utc: $devicedateUtc' +
    //       '\nNtp utc: $ntpdateUtc';
    // });

    return;
  }

  void updateClassRoomQuizList(List<IndividualClassroomQuizAllListItem> newList){
    classRoomQuizList=newList as RxList;
  }


//get first page data
  void getExamList() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await put(
            Uri.parse('http://192.168.1.4:8000/api/individual-classroom-quiz-all-list/$classRoomId/'),
            body: {
              'uid':"$uid"
            }

          );

         // _showToast("${response.statusCode}");
          if (response.statusCode == 200) {

           _showToast("success");
            log('data:'+response.body.toString());
             var data = response.body;
            IndividualClassroomQuizAllListModel individualClassroomQuizAllListModel=
            individualClassroomQuizAllListModelFromJson(data);

            classRoomQuizList(individualClassroomQuizAllListModel.data);

          }
          else {
           // Fluttertoast.cancel();

            log('data:'+response.body.toString());
            _showToast("failed try again!");

          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {

      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
    //updateIsFirstLoadRunning(false);
  }

  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}