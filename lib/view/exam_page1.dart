import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Colors.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../controller/exam_page_controller.dart';
import 'background.dart';
import 'exam_start_page.dart';
import 'navigation_drawer_page.dart';

class ExamPageScreen1 extends StatelessWidget {

  final examPageController = Get.put(ExamPageController());

  // final examPageController = Get.put(ExamPageController());

  // String _userName="",_fullName="",_userBatch="",_userType="",_userId="";

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        // backgroundColor: Colors.backGroundColor,
        key: _key,

        drawer: NavigationDrawerPasswordScreen(examPageController.fullName.value,examPageController.email.value),
        body:RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.blue,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {

            examPageController.onInit();

            await Future.delayed(const Duration(seconds: 1));
            //updateDataAfterRefresh();
          },
          child:  Column(
            children: [

              Expanded(child: Stack(

                children: [
                  Background(),
                  Expanded(child:

                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(00, 15, 00, 10),

                        child: Row(
                          children: [
                            const SizedBox(width: 10,),
                            InkWell(
                              onTap: (){
                                _key.currentState!.openDrawer();
                              },
                              child:  Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0),
                                      bottomLeft: Radius.circular(5.0)),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(7),

                                child:const Icon(Icons.menu_rounded,
                                  size: 22,
                                  color: awsEndColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(child: Text("Exam List",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: awsEndColor
                              ),
                            ))
                          ],
                        ),
                      ),
                      Expanded(child:  ListView.builder( // outer ListView
                        itemCount: 1,
                        itemBuilder: (_, index) {
                          return  Column(
                            children: [
                              Image.asset(
                                "assets/images/aws.png",
                                width: 180,
                                height: 90,
                              ),
                              Obx(() => Text("current time: "+examPageController.currentDateTime.value)),
                              Obx(() => Text("start time: "+examPageController.startDateTime.value)),
                              Obx(() => Text("end time: "+examPageController.endDateTime.value)),
                              Obx(() => Text("end time utc: "+examPageController.endDateTimeUtc.value)),
                              _buildFinishedExamList()
                            ],
                          );

                        },
                      ),)
                    ],
                  ),

                  ),



                ],
              )),



            ],
          ),

        ),

      ),
    );
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

    ///dfff
    // setState(() {
    //
    //   getTime = 'Device time: $_myTime' +
    //       '\nNtp time: $_ntpTime' +
    //       '\nDevice utc: $devicedateUtc' +
    //       '\nNtp utc: $ntpdateUtc';
    // });

    return;
  }

  Widget _buildButtonDesign1(
      {required Color startColor,
        required Color endColor}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(0)),
      ),
      child: Container(
          height: 50,
          alignment: Alignment.center,
          child:Obx(() => Text(
            examPageController.upcomingExamText.value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),)
      ),
    );
  }

  Widget _buildButtonDesign(
      {required String textValue,
        required Color startColor,
        required Color endColor}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(0)),
      ),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          textValue,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  //finished exam list
  Widget _buildFinishedExamList() {
    return Obx(() =>
        ListView.builder(
          itemCount:examPageController.classRoomQuizList.length,
          shrinkWrap: true, // 1st add
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            //if false then exam not complete
            //if true then exam has been complete
            if(examPageController.classRoomQuizList[index].isComplete==false){

              if(
              diffSecond(DateTime.parse(examPageController.endDateTime.value),
                DateTime.parse(examPageController.currentDateTime.value),
              )){
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight:
                        Radius.circular(10.0),
                        bottomRight:
                        Radius.circular(10.0),
                        topLeft:
                        Radius.circular(10.0),
                        bottomLeft:
                        Radius.circular(10.0)),
                    color:
                    Colors.black.withOpacity(.1),
                  ),
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 00),
                  margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 00),
                  child: Column(
                    children: [

                      Container(
                        margin: const EdgeInsets.only(
                            right: 20.0,
                            top: 20,
                            left: 10,
                            bottom: 20),
                        child: Align(
                          alignment:
                          Alignment.topCenter,
                          child:

                          Obx(() =>
                              Text(
                                examPageController.startTxt.value,
                                textAlign:
                                TextAlign.center,
                                style: const TextStyle(
                                    color: awsEndColor,
                                    fontSize: 25,
                                    fontWeight:
                                    FontWeight.bold),
                              ),

                          ),

                        ),
                      ),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          const Text(
                            "User Name: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Obx(() => Text(
                            examPageController.userName.value,
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: awsMixedColor,
                              fontSize: 18,
                            ),
                          ))
                          ,
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "Batch : ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() => Text(
                            examPageController.userBatch.value,
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: awsMixedColor,
                              fontSize: 18,
                            ),
                          ))
                          ,
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Time: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() =>
                              Text(

                                utcToLocalTime("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"
                                    +" ${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartTime}"),
                                // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartTime}" ,
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w500,
                                  color: awsMixedColor,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "End Time: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() =>
                              Text(

                                utcToLocalTime("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"
                                    +" ${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizEndTime}"),
                                // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizEndTime}",

                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w500,
                                  color: awsMixedColor,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "Duration: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() =>
                              Text(
                                //"${examPageController.classRoomQuizList[index].quizDuration} Minutes",
                                "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizDuration} Minutes" ,
                                //"quration",
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w500,
                                  color: awsMixedColor,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "Exam Date: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() =>
                              Text(


                                utcToLocalDate("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"),

                                // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}" ,
                                //  "${examPageController.classRoomQuizList[index].quizStartDate}",

                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w500,
                                  color: awsMixedColor,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),

                      InkResponse(
                        onTap: () {


                          if(examPageController.isExamStart==1){
                            //  _showToast("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizId}");
                            saveUserQuizId(quizId: "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizId}");
                            Get.to(ExamStartPageScreen(
                              quizId:"${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizId}",
                            ));
                            // _showToast( "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizId}" );
                          }else{
                            Fluttertoast.cancel();
                            _showToast("Exam not started yet!");
                            /// _showToast("Your exam time is not start!");
                          }

                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              20, 20, 20, 00),
                          child: _buildButtonDesign1(
                            endColor: awsEndColor,
                            startColor:
                            awsStartColor,

                            //  _upcomingExamText
                          ),


                        ),
                      )
                    ],
                  ),
                );
              }
              else{
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight:
                        Radius.circular(10.0),
                        bottomRight:
                        Radius.circular(10.0),
                        topLeft:
                        Radius.circular(10.0),
                        bottomLeft:
                        Radius.circular(10.0)),
                    color:
                    Colors.black.withOpacity(.1),
                  ),
                  padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 00),
                  margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Time: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() =>
                              Text(

                                utcToLocalTime("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"
                                    +" ${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartTime}"),
                                // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartTime}" ,
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w500,
                                  color: awsMixedColor,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "End Time: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() =>
                              Text(

                                utcToLocalTime("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"
                                    +" ${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizEndTime}"),
                                // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizEndTime}",

                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w500,
                                  color: awsMixedColor,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "Duration: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() =>
                              Text(
                                //"${examPageController.classRoomQuizList[index].quizDuration} Minutes",
                                "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizDuration} Minutes" ,
                                //"quration",
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w500,
                                  color: awsMixedColor,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            "Exam Date: ",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Obx(() =>
                              Text(


                                utcToLocalDate("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"),

                                // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}" ,
                                //  "${examPageController.classRoomQuizList[index].quizStartDate}",

                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w500,
                                  color: awsMixedColor,
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              20, 20, 20, 00),
                          child: InkWell(
                            onTap: (){


                            },
                            child: _buildButtonDesign(
                                endColor: awsMixedColor,
                                startColor: awsMixedColor,
                                textValue: "View Details"),
                          )
                      ),


                    ],
                  ),
                );
              }
            }
            else{
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight:
                      Radius.circular(10.0),
                      bottomRight:
                      Radius.circular(10.0),
                      topLeft:
                      Radius.circular(10.0),
                      bottomLeft:
                      Radius.circular(10.0)),
                  color:
                  Colors.black.withOpacity(.1),
                ),
                padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 00),
                margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          "Start Time: ",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Obx(() =>
                            Text(

                              utcToLocalTime("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"
                                  +" ${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartTime}"),
                              // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartTime}" ,
                              style: TextStyle(
                                fontWeight:
                                FontWeight.w500,
                                color: awsMixedColor,
                                fontSize: 18,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          "End Time: ",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Obx(() =>
                            Text(

                              utcToLocalTime("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"
                                  +" ${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizEndTime}"),
                              // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizEndTime}",

                              style: TextStyle(
                                fontWeight:
                                FontWeight.w500,
                                color: awsMixedColor,
                                fontSize: 18,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          "Duration: ",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Obx(() =>
                            Text(
                              //"${examPageController.classRoomQuizList[index].quizDuration} Minutes",
                              "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizDuration} Minutes" ,
                              //"quration",
                              style: TextStyle(
                                fontWeight:
                                FontWeight.w500,
                                color: awsMixedColor,
                                fontSize: 18,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          "Exam Date: ",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Obx(() =>
                            Text(


                              utcToLocalDate("${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}"),

                              // "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizStartDate}" ,
                              //  "${examPageController.classRoomQuizList[index].quizStartDate}",

                              style: TextStyle(
                                fontWeight:
                                FontWeight.w500,
                                color: awsMixedColor,
                                fontSize: 18,
                              ),
                            )),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            20, 20, 20, 00),
                        child: InkWell(
                          onTap: (){


                          },
                          child: _buildButtonDesign(
                              endColor: awsMixedColor,
                              startColor: awsMixedColor,
                              textValue: "View Details"),
                        )
                    ),


                  ],
                ),
              );
            }

          },
        )
    );
  }

  bool  diffSecond(DateTime dt1,DateTime dt2,) {

    /// dt1-dt2
    Duration diff = dt1.difference(dt2);

    if (diff.inSeconds > 0) {
      // _showToast('> 0');
      return true;

    }else{
      return false;
      // _showToast("elsse");
    }
  }

  void saveUserQuizId({required String quizId}) async {
    try {

      var storage =GetStorage();
      storage.write(hw_panel_pref_quiz_id, quizId);

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

  //utc to local convert and time return
  String utcToLocalTime(String value){
    try{
      var dateFormat = DateFormat("dd-MM-yyyy hh:mm aa"); // you can change the format here
      var utcDate = dateFormat.format(DateTime.parse(value)); // pass the UTC time here
      var localDate = dateFormat.parse(utcDate, true).toLocal().toString();//convert local time

      // var dateFormat1 = DateFormat("hh:mm aa");
      var dateFormat2 = DateFormat("hh:mm:ss aa");

      String formattedTime = dateFormat2.format(DateTime.parse(localDate));
      return formattedTime;
    }
    catch(Exception ){
      return "catch";
    }



  }

  //utc to local convert and date return
  String utcToLocalDate(String value){
    try{
      var dateFormat = DateFormat("dd-MM-yyyy hh:mm aa"); // you can change the format here
      var utcDate = dateFormat.format(DateTime.parse(value)); // pass the UTC time here
      var localDate = dateFormat.parse(utcDate, true).toLocal().toString();//convert local time

      // var dateFormat1 = DateFormat("hh:mm aa");
      var dateFormat2 = DateFormat("dd-MM-yyyy");

      String formattedTime = dateFormat2.format(DateTime.parse(localDate));
      return formattedTime;
    }
    catch(Exception ){
      return "catch";
    }



  }

  //create button
  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [awsStartColor, awsEndColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Finished",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
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


  ///get data from share pref
  loadUserIdFromSharePref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      // setState(() {
      //
      //   _userName= sharedPreferences.getString(pref_user_name )??"";
      //   _fullName= sharedPreferences.getString(pref_full_name )??"";
      //   _userBatch=  sharedPreferences.getString(pref_user_batch )??"";
      //   _userType= sharedPreferences.getString(pref_user_type )??"";
      //   _userId= sharedPreferences.getString(pref_user_id )??"";
      //
      //
      // });
    } catch(e) {
      //code
    }

  }

}
