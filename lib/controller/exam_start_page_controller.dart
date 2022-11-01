import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/time_over.dart';

class ExamStartPageController extends GetxController {

  ///timer variable
  var startTxt = "00:00:00".obs;
  late Timer timer;
  var otpCountDownSecond = 0.obs;


  ///question no variable
  var currentQuestionNo="1".obs;
  var totalQuestionNo="30".obs;
  /// if one then mcq and 2 then short question
  var questionType = "2".obs;

  final shortQuestionNameController = TextEditingController().obs;
  var abcdList=["(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)"];
  var selectedValue = (-1).obs;
  var message="If you click 'Skip' or 'Submit' button, You will can not go back previous page.".obs;


  @override
  void onInit() {
    super.onInit();
    diffSecond1();

  }


  ///input two time and difference between time and pass second with timer
  diffSecond1() {
    DateTime dt1 = DateTime.parse("2021-12-23 11:50:50");
    DateTime dt2 = DateTime.parse("2021-12-23 11:50:10");
    Duration diff = dt1.difference(dt2);

    if (diff.inSeconds > 0) {
      updateOtpCountDownSecond(diff.inSeconds);
      startTimer(diff.inSeconds);
    }
  }
  /// timer method
  void startTimer(var second) {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (second <= 0) {

          timer.cancel();
          Get.off(TimeOverScreen());
        }
        else {
          second--;
          updateStartTxt(_printDuration(Duration(seconds: second)));
          // _startTxt = _printDuration(Duration(seconds: second));
        }
      },
    );
  }

  /// duration to time format converter
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHour = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHour:$twoDigitMinutes:$twoDigitSeconds";
  }
  ///timer cancel
  void cancelTimer(){
    timer.cancel();
    updateStartTxt("00:00:00");

  }
  updateOtpCountDownSecond(int value) {
    otpCountDownSecond(value);
  }

  ///update timer text
  updateStartTxt(String value) {
    startTxt(value);
  }

  ///update current question no
  updateCurrentQuestionNo(String value) {
    currentQuestionNo(value);
  }

  ///update total question no
  updateTotalQuestionNo(String value) {
    totalQuestionNo(value);
  }

  void selectedValueUpdate(int option){
    selectedValue(option);
  }
  void updateQuestionType(String value){
    questionType(value);
  }



}