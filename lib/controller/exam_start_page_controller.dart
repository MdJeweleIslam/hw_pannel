import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Colors.dart';
import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../model/McqQuestionModel.dart';
import '../model/ShortQuestionModel.dart';
import '../view/exam_done.dart';
import '../view/exam_start_page.dart';
import '../view/time_over.dart';

class ExamStartPageController extends GetxController {



  String quizId="8";

  //
  // ExamStartPageController(this.quizId);

  ///timer variable
  var startTxt = "00:00:00".obs;
  Timer? timer;
  var otpCountDownSecond = 0.obs;
  var uid = "09a8a3fb-0c63-49ec-abc4-657132ff8e9f".obs;

  ///question no variable
  var currentQuestionNo="00".obs;
  var totalQuestionNo="00".obs;
  var questionListResponseStatusCode=0.obs;

  var allQuestionSubmit=false.obs;

  var examEndTimeLocal="".obs;
  var currentTimeUtc="".obs;
  /// if 1 then mcq and 2 then short question and 3 question already submit
   var questionType = 0.obs;

   var studentId = "8".obs;
   var questionMcqOptionsId="".obs;

  Rx<McqQuestionModel> mcqQuestionDataModel = McqQuestionModel().obs;
  Rx<ShortQuestionModel> shortQuestionModel = ShortQuestionModel().obs;

  final shortQuestionNameController = TextEditingController().obs;
  var abcdList=["(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)"];
  var selectedValue = (-1).obs;
  var message="If you click 'Skip' or 'Submit' button, You will can not go back previous page.".obs;

  @override
  void onInit() {
    super.onInit();
   // diffSecond1();
    loadUserIdFromSharePref();
    getExamQuestion();
    // diffSecond1();

  }


  @override
  void dispose() {
    print('I am disposed');
    timer!.cancel();
    super.dispose();

  }

  @override
  void onClose() {
   // timer!.cancel();
    super.onClose();
    ifTimerMounted();
    print('I am closed');


  }


  ///input two time and difference between time and pass second with timer
  diffSecond1() {
    DateTime dt1 = DateTime.parse("2021-12-23 11:50:50");
    DateTime dt2 = DateTime.parse("2021-12-23 10:20:10");
    Duration diff = dt1.difference(dt2);

    if (diff.inSeconds > 0) {
      updateOtpCountDownSecond(diff.inSeconds);
      startTimer(diff.inSeconds);
    }
  }

  diffSecond(DateTime dt1,DateTime dt2,) {
    Duration diff = dt1.difference(dt2);
    if (diff.inSeconds > 0) {
     // _showToast('> 0');
      updateOtpCountDownSecond(diff.inSeconds);
      timer?.cancel();
      startTimer(diff.inSeconds);
    }else{
       _showToast("Time less than");
    }
  }

  int timeDifferenceSecond(DateTime dt1,DateTime dt2,) {

    Duration diff = dt1.difference(dt2);
    return diff.inSeconds;
  }

  void startTimer(var second) {

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec, ( timer) {
        if (second <= 0) {
          getExamQuestion();
          if(allQuestionSubmit==false){
            Get.off(TimeOverScreen());
          }
          _showToast("Time over!");
          timer.cancel();
        }
        else {
          if(timer.isActive){
            second--;
            updateStartTxt(_printDuration(Duration(seconds: second)));

          }
        }
      },
    );
  }

  ifTimerMounted(){
    final itimer = timer == null ? false : timer!.isActive;
    if(itimer){
      timer!.cancel();
    }else{
      // Or Do Nothing Leave it Blank
      print('Timer Stop Running');
    }
  }


  void startTimer1(var second) {

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      print('timer is running');
      //DO SOMETHING
    });



    timer = Timer.periodic(
      oneSec, ( timer) {
        if (second <= 0) {
          getExamQuestion();
          if(allQuestionSubmit==false){
            Get.off(TimeOverScreen());
          }
          _showToast("Time over!");
          timer.cancel();
        }
        else {
          if(timer.isActive){
            second--;
            updateStartTxt(_printDuration(Duration(seconds: second)));

          }
        }
      },
    );
  }

  ///timer cancel
  void cancelTimer(){
    _showToast("cancell");
    timer?.cancel();
    updateStartTxt("00:00:00");

  }
  /// duration to time format converter
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHour = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHour:$twoDigitMinutes:$twoDigitSeconds";
  }

  updateOtpCountDownSecond(int value) {
    otpCountDownSecond(value);
  }

  ///update timer text
  updateStartTxt(String value) {
    startTxt(value);
  }

  updateExamEndTimeLocal(String value) {
    examEndTimeLocal(value);
  }
  updateCurrentTimeUtc(String value) {
    currentTimeUtc(value);
  }

  ///update current question no
  updateCurrentQuestionNo(String value) {
    currentQuestionNo(value);
  }


  updateAllQuestionSubmit(bool value) {
    allQuestionSubmit(value);
  }

  ///update total question no
  updateTotalQuestionNo(String value) {
    totalQuestionNo(value);
  }


  updateQuestionListResponseStatusCode(int value) {
    questionListResponseStatusCode(value);
  }

  updateQuestionMcqOptionsId(String value) {
    questionMcqOptionsId(value);
  }

  void selectedValueUpdate(int option){
    selectedValue(option);
  }

   updateQuestionType(int value) {
     questionType(value);
   }

   void updateMcqQuestionModel(McqQuestionModel newData){
     mcqQuestionDataModel(newData);
   }

   void updateShortQuestionModel(ShortQuestionModel newData){
     shortQuestionModel(newData) ;
   }

  //get exam quiz list
  void getExamQuestion() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await put(
            // Uri.parse('http://192.168.1.4:8000/api/individual-classroom-quiz-all-list/$classRoomId/'),
              Uri.parse('$BASE_URL_EXAM_PANNEL$SUB_URL_API_GET_QUESTION$uid/'),
              body: {
                'uid':"$uid",
                'quiz_id':"$quizId",
              }
          );

          updateQuestionListResponseStatusCode(response.statusCode);

         //  _showToast("${response.statusCode}");
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            updateCurrentTimeUtc(utcToLocalDate(data["current_timess"].toString()));
            if(data["data"][0]["is_mcq_questions"]){
              // _showToast("mcq");
              McqQuestionModel mcqQuestionModel=mcqQuestionModelFromJson(response.body);

              updateTotalQuestionNo(mcqQuestionModel.totalQuestions.toString());
              updateCurrentQuestionNo((mcqQuestionModel.questionsAnswerSubmitted!+1).toString());
              // _showToast(mcqQuestionModel.data!.length.toString());
              updateQuestionType(2);
              updateMcqQuestionModel(mcqQuestionModel);


             // updateCurrentTimeUtc(data["current_timess"].toString());


              //count down start
             // diffSecond(DateTime.parse(examEndTimeUtc.toString()),DateTime.parse(mcqQuestionModel.currentTimess.toString()));

              // diffSecond(examEndTimeUtc.value,currentTimeUtc.);



            }
            else if(data["data"][0]["is_short_questions"]){
               // _showToast("short");
                ShortQuestionModel shortQuestionModel=shortQuestionModelFromJson(response.body);

                updateTotalQuestionNo(shortQuestionModel.totalQuestions.toString());
                updateCurrentQuestionNo((shortQuestionModel.questionsAnswerSubmitted!+1).toString());
                updateShortQuestionModel(shortQuestionModel);
                updateQuestionType(1);

              }
            else{
                updateQuestionType(0);
               // _showToast("none");
              }
            diffSecond(DateTime.parse(examEndTimeLocal.value),DateTime.parse(currentTimeUtc.value),);
          }
          else if(response.statusCode == 201){
            Get.off(() => ExamDoneScreen());
          }
          else if(response.statusCode == 203){
            Get.off(() => TimeOverScreen());
          }
          else if(response.statusCode == 402){
            Get.off(() => TimeOverScreen());
          }
          else {
            updateQuestionType(3);
            var data = jsonDecode(response.body);
            _showToast(data["message"]);

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

  //submit Mcq Question Answer
   void submitMcqQuestionAnswer({
     required String questionMcqOptionsId, required String studentId,
     required String quizId, required String questionId, required String uid
  }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await post(
              Uri.parse('$BASE_URL_EXAM_PANNEL$SUB_URL_API_MCQ_QUESTION_ANSWER_SUBMIT'),
              body: {
                'question_mcq_options_id':questionMcqOptionsId,
                'student_id':studentId,
                'quiz_id':quizId,
                'question_id':questionId,
                'uid':uid,
              }
          );
          // _showToast("${response.statusCode}");
          if (response.statusCode == 200) {

            if(currentQuestionNo.value == totalQuestionNo.value){
              updateAllQuestionSubmit(true);
              cancelTimer();
              Get.off(() => ExamDoneScreen());
             // Fluttertoast.cancel();
             // _showToast("all question submit");
            }
            else{
              updateQuestionListResponseStatusCode(0);
              Fluttertoast.cancel();
              _showToast("Submit success full");
              selectedValueUpdate(-1);
              updateQuestionMcqOptionsId("");
              updateQuestionType(0);
              getExamQuestion();
            }

          }
          else {

            //  _showToast("failed try again!");

          }
        } catch (e) {

          // Log(e.toString());
          _showToast(e.toString());
          // Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {

      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
    //updateIsFirstLoadRunning(false);
  }

  //submit short Question Answer
  void submitShortQuestionAnswer({
    required String answerText, required String studentId,
    required String quizId, required String questionId, required String uid
  }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await post(
              Uri.parse('$BASE_URL_EXAM_PANNEL$SUB_URL_API_SHORT_QUESTION_ANSWER_SUBMIT'),
              body: {
                'student_answer':answerText,
                'student_id':studentId,
                'quiz_id':quizId,
                'question_id':questionId,
                'uid':uid,
              }
          );
        //  _showToast("${response.statusCode}");
          if (response.statusCode == 200){
            if(currentQuestionNo.value == totalQuestionNo.value){
             // _showToast("all question submit");
              updateAllQuestionSubmit(true);
              cancelTimer();

              Get.off(() => ExamDoneScreen());
              // Get.to(ExamDoneScreen());


            }
            else{
            //  _showToast("Submit success full");
              updateQuestionListResponseStatusCode(0);
              shortQuestionNameController.value.clear();
              selectedValueUpdate(-1);
              updateQuestionMcqOptionsId("");
              updateQuestionType(0);

              getExamQuestion();
            }
          }
          else {
            //  _showToast("failed try again!");
          }
        } catch (e) {
          // Log(e.toString());
          _showToast(e.toString());
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
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  //utc to local convert and date return
  String utcToLocalDate(String value){
    try{

      var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss"); // you can change the format here
      var utcDate = dateFormat.format(DateTime.parse(value)); // pass the UTC time here
      var localDate = dateFormat.parse(utcDate, true).toLocal().toString();//convert local time

      // var dateFormat1 = DateFormat("hh:mm aa");
      var dateFormat2 = DateFormat("dd-MM-yyyy");

      String formattedTime = dateFormat.format(DateTime.parse(localDate));
      return formattedTime;
    }
    catch(Exception ){
      return "catch";
    }

  }

  loadUserIdFromSharePref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      updateExamEndTimeLocal(utcToLocalDate(sharedPreferences.getString(pref_user_exam_end_time).toString()));
     // updateExamEndTimeLocal(sharedPreferences.getString(pref_user_exam_end_time).toString());
    //  _showToast(sharedPreferences.getString(pref_user_exam_end_time).toString());

    } catch(e) {
      //code
    }

  }

}