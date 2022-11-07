import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../Colors.dart';
import '../model/McqQuestionModel.dart';
import '../model/ShortQuestionModel.dart';
import '../view/time_over.dart';

class ExamStartPageController extends GetxController {

   String quizId="8";
  //
  // ExamStartPageController(this.quizId);

  ///timer variable
  var startTxt = "00:00:00".obs;
  late Timer timer;
  var otpCountDownSecond = 0.obs;
  var uid = "09a8a3fb-0c63-49ec-abc4-657132ff8e9f".obs;

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
    getExamQuestion();
    // diffSecond1();

  }


  ///input two time and difference between time and pass second with timer
  diffSecond1() {
    DateTime dt1 = DateTime.parse("2021-12-23 11:50:50");
    DateTime dt2 = DateTime.parse("2021-12-23 10:50:10");
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

//get exam quiz list
  void getExamQuestion() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await put(
            // Uri.parse('http://192.168.1.4:8000/api/individual-classroom-quiz-all-list/$classRoomId/'),
              Uri.parse('http://192.168.1.4:8000/api/exam-question-list-mobile/09a8a3fb-0c63-49ec-abc4-657132ff8e9f/'),
              body: {
                'uid':"$uid",
                'quiz_id':"$quizId",
              }
          );
          _showToast("${response.statusCode}");
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            if(data["data"][0]["is_mcq_questions"]){
              _showToast("mcq");
              McqQuestionModel mcqQuestionModel=mcqQuestionModelFromJson(response.body);
              _showToast(mcqQuestionModel.data[0].questionId.toString());



            }
          else if(data["data"][0]["is_short_questions"]){
              _showToast("mcq");
              ShortQuestionModel shortQuestionModel=shortQuestionModelFromJson(response.body);
              _showToast(shortQuestionModel.data[0].questionId.toString());


            }else{

              _showToast("none");
            }




          }
          else {

          //  _showToast("failed try again!");

          }
        } catch (e) {
          _showToast("failed try again!");
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