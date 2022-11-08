import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

class ExamPageScreen extends StatelessWidget {

  final examPageController = Get.put(ExamPageController());

 // String _userName="",_fullName="",_userBatch="",_userType="",_userId="";

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.backGroundColor,
          // backgroundColor: Colors.backGroundColor,
          key: _key,

          drawer: NavigationDrawerPasswordScreen(),
          body:RefreshIndicator(
            color: Colors.white,
            backgroundColor: Colors.purple,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {

              examPageController.onInit();

              await Future.delayed(const Duration(seconds: 1));
              //updateDataAfterRefresh();
            },
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Background(),

                    Column(
                      children: [

                        Container(
                          margin: const EdgeInsets.fromLTRB(00, 15, 00, 10),

                          child: Row(
                            children: [
                              const SizedBox(width: 20,),
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

                        Expanded(
                            child: SingleChildScrollView(
                              child: Column(
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

                                  _buildFinishedExamList(),

                                  Text("list end"),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: const BorderRadius.only(
                                  //         topRight:
                                  //         Radius.circular(10.0),
                                  //         bottomRight:
                                  //         Radius.circular(10.0),
                                  //         topLeft:
                                  //         Radius.circular(10.0),
                                  //         bottomLeft:
                                  //         Radius.circular(10.0)),
                                  //     color:
                                  //     Colors.black.withOpacity(.1),
                                  //   ),
                                  //   padding: EdgeInsets.only(
                                  //       left: 20,
                                  //       right: 20,
                                  //       top: 20,
                                  //       bottom: 00),
                                  //   margin: EdgeInsets.only(
                                  //       left: 20,
                                  //       right: 20,
                                  //       top: 20,
                                  //       bottom: 00),
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             "User Name: ",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               fontSize: 18,
                                  //               color: Colors.black,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             "Sabbir001",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: awsMixedColor,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             "Batch : ",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: Colors.black,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             "Test",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: awsMixedColor,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             "Start Time: ",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: Colors.black,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             "17:40:00",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: awsMixedColor,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             "End Time: ",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: Colors.black,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             "18:40:00",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: awsMixedColor,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             "Duration: ",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: Colors.black,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             "60 Minutes",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: awsMixedColor,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5,
                                  //       ),
                                  //       Row(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             "Exam Date: ",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: Colors.black,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             "2022-10-11",
                                  //             style: TextStyle(
                                  //               fontWeight:
                                  //               FontWeight.w500,
                                  //               color: awsMixedColor,
                                  //               fontSize: 18,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       //int otp_coundown_second=300;
                                  //       //int otp_coundown_second=300;
                                  //       Container(
                                  //           margin: EdgeInsets.fromLTRB(
                                  //               20, 30, 20, 00),
                                  //           child: InkWell(
                                  //             onTap: () {
                                  //               examPageController.cancelTimer();
                                  //
                                  //               Get.to(ExamStartPageScreen());
                                  //
                                  //
                                  //             },
                                  //             child: _buildButtonDesign(
                                  //                 endColor: awsEndColor,
                                  //                 startColor:
                                  //                 awsStartColor,
                                  //                 textValue: "Running"),
                                  //           )),
                                  //     ],
                                  //   ),
                                  // ),
                                  Obx(() =>
                                      Text(examPageController.getTime.value),

                                  ),

                                  Container(
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
                                            Text(
                                              "17:40:00",
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.w500,
                                                color: awsMixedColor,
                                                fontSize: 18,
                                              ),
                                            ),
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
                                            Text(
                                              "18:40:00",
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.w500,
                                                color: awsMixedColor,
                                                fontSize: 18,
                                              ),
                                            ),
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
                                            Text(
                                              "60 Minutes",
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.w500,
                                                color: awsMixedColor,
                                                fontSize: 18,
                                              ),
                                            ),
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
                                            Text(
                                              "2022-10-11",
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.w500,
                                                color: awsMixedColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Start Exam

                                        InkResponse(
                                          onTap: () {

                                            //   examPageController.main();
                                            // main();
                                            //  getNtpTime();

                                            if(examPageController.upcomingExamText.value=="Start Exam"){
                                              _showToast("Ready to exam!");
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
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),



                                ],
                              ),
                            )),
                      ],
                    )
                  ],
                )),
          )




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
      {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //shimmer design
        Obx(() =>
        ListView.builder(
          itemCount:examPageController.classRoomQuizList.length,
          // itemCount: orderRoomList == null ? 0 : orderRoomList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if(examPageController.classRoomQuizList[index].isComplete==false){
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
                       Get.to(ExamStartPageScreen(
                         quizId:"${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizId}",
                       ));
                       // _showToast( "${examPageController.classRoomQuizList[index].quizTimeInfo[0].quizId}" );
                        }else{
                          Fluttertoast.cancel();
                          _showToast("Your exam time is not start!");
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

          },
        )
        )
      ],
    );
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
