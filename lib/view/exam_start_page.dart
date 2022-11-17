import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:marquee/marquee.dart';

import '../../Colors.dart';
import '../../NoDataFound.dart';
import '../../controller/exam_start_page_controller.dart';
import 'background.dart';

class ExamStartPageScreen extends StatelessWidget {
  String quizId;
  ExamStartPageScreen({required this.quizId});

  final examStartPageController = Get.put(ExamStartPageController());
  late String userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backGroundColor,
          // backgroundColor: Colors.backGroundColor,
          body:RefreshIndicator(
            color: Colors.white,
            backgroundColor: Colors.blue,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {

              examStartPageController.onInit();

              await Future.delayed(const Duration(seconds: 1));
              //updateDataAfterRefresh();
            },
            child:

            CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: Column(
                    children: <Widget>[

                      Expanded(child: Stack(
                        children: [
                          Background(),
                          Obx(() => Column(
                            children: [



                              Container(
                                margin: EdgeInsets.fromLTRB(00, 20, 00, 10),
                                height: 30,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Marquee(
                                          text: examStartPageController.message.value,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: awsEndColor),
                                          scrollAxis: Axis.horizontal,
                                          //scroll direction
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          blankSpace: MediaQuery.of(context).size.width,
                                          velocity: 50.0,
                                          //speed
                                          pauseAfterRound: Duration(seconds: 1),
                                          startPadding: 10.0,
                                          accelerationDuration: Duration(seconds: 1),
                                          accelerationCurve: Curves.linear,
                                          decelerationDuration:
                                          Duration(milliseconds: 1000),
                                          decelerationCurve: Curves.easeOut,
                                        ))
                                  ],
                                ),
                              ),

                              Obx(() =>
                                  Text(
                                    "current time: " +
                                        examStartPageController.currentTimeUtc
                                            .value
                                    ,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: awsEndColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Obx(() =>
                                  Text(
                                    "Exam End time: " +
                                        examStartPageController.examEndTimeUtc
                                            .value
                                       // examStartPageController.utcToLocalDate(examStartPageController.examEndTimeLocal.value)
                                    ,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: awsEndColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)),
                                  color: Colors.black.withOpacity(.1),
                                ),
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, top: 15, bottom: 15),
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 00, bottom: 00),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(("Question: "),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                        Obx(
                                              () =>
                                              Text(
                                                  examStartPageController
                                                      .currentQuestionNo.value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight
                                                          .w500)),
                                        ),
                                        Obx(
                                              () =>
                                              Text(
                                                  (" of " +

                                                      examStartPageController
                                                          .totalQuestionNo
                                                          .value),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight
                                                          .w500)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Remaining Time",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: awsEndColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Obx(
                                          () =>
                                          Text(
                                            examStartPageController.startTxt
                                                .value,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: awsStartColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: Column(

                                children: [
                                  if(examStartPageController.questionListResponseStatusCode.value == 200)...{

                                    // short question section

                                    if (examStartPageController.questionType.value == 1) ...{
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 20,
                                              bottom: 00),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Obx(() =>
                                                Text(
                                                    "Q: " + "${examStartPageController
                                                        .shortQuestionModel.value
                                                        .data![0].questionName}"
                                                    ,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                            ),
                                          )


                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 14,
                                              bottom: 10),
                                          child: Flex(
                                            direction: Axis.vertical,
                                            children: [
                                              Expanded(
                                                  child:
                                                  _buildShortQuestionAnswerTextField()),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 20, right: 20, top: 10,bottom: 20),
                                                child:
                                                _buildNextButton_short_question(),
                                              ),
                                              // Container(
                                              //   margin: EdgeInsets.only(
                                              //       left: 20,
                                              //       right: 20,
                                              //       top: 20,
                                              //       bottom: 20),
                                              //   child: _buildSkipButton("1"),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    }
                                    // mcq question section
                                    else if (examStartPageController.questionType.value == 2) ...{
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 20,
                                                        bottom: 00),
                                                    child: Flex(
                                                      direction: Axis.horizontal,
                                                      children: [
                                                        // .
                                                        Obx(() =>
                                                            Text(
                                                                "Q: " +
                                                                    "${examStartPageController
                                                                        .mcqQuestionDataModel
                                                                        .value
                                                                        .data![0]
                                                                        .questionName}"
                                                                ,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),),

                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                        color: transparent,
                                                        child: Theme(
                                                          data: Theme.of(context)
                                                              .copyWith(
                                                            unselectedWidgetColor:
                                                            awsEndColor,
                                                          ),
                                                          child: Obx(() =>
                                                              ListView.builder(
                                                                itemCount: examStartPageController
                                                                    .mcqQuestionDataModel
                                                                    .value.data![0]
                                                                    .questionsOptions ==
                                                                    null ? 0
                                                                    : examStartPageController
                                                                    .mcqQuestionDataModel
                                                                    .value.data![0]
                                                                    .questionsOptions
                                                                    .length,
                                                                // itemCount: 4,

                                                                // physics: NeverScrollableScrollPhysics(),
                                                                // shrinkWrap: true,
                                                                shrinkWrap: true,
                                                                primary: false,
                                                              //  physics: NeverScrollableScrollPhysics(),
                                                                itemBuilder: (
                                                                    context, index) {
                                                                  return Obx(() =>
                                                                      RadioListTile<
                                                                          int>(

                                                                          value: index,
                                                                          activeColor: awsEndColor,
                                                                          title: Text(
                                                                            examStartPageController
                                                                                .abcdList[index]
                                                                                .toString() +
                                                                                " ${examStartPageController
                                                                                    .mcqQuestionDataModel
                                                                                    .value
                                                                                    .data![0]
                                                                                    .
                                                                                questionsOptions[index]
                                                                                    .mcqOptionAnswer}",
                                                                            // optionList[index]["mcq_option_answer"].toString(),
                                                                            style: TextStyle(
                                                                                fontSize: 16),
                                                                          ),
                                                                          groupValue:
                                                                          examStartPageController
                                                                              .selectedValue
                                                                              .value,
                                                                          onChanged: (
                                                                              value) {
                                                                            // _showToast(examStartPageController.mcqQuestionDataModel.value.data![0].
                                                                            // questionsOptions[index].questionMcqOptionsId.toString());
                                                                            examStartPageController
                                                                                .selectedValueUpdate(
                                                                                index);

                                                                            examStartPageController
                                                                                .updateQuestionMcqOptionsId(
                                                                                examStartPageController
                                                                                    .mcqQuestionDataModel
                                                                                    .
                                                                                value
                                                                                    .data![0]
                                                                                    .questionsOptions[index]
                                                                                    .questionMcqOptionsId
                                                                                    .toString());
                                                                          }));



                                                                },
                                                              ),

                                                          ),


                                                        ),
                                                      )

                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 20),
                                        child: _buildNextButton_mcq_question(),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(
                                      //       left: 20,
                                      //       right: 20,
                                      //       top: 20,
                                      //       bottom: 20),
                                      //   child: _buildSkipButton("1"),
                                      // ),
                                    }
                                    //no question found
                                    else...{
                                        Expanded(
                                          child: NoDataFound().noItemFound(
                                              "Question Not Found! try again! "),
                                        ),
                                      }

                                  }
                                  else if (examStartPageController.questionListResponseStatusCode.value == 201) ...{
                                    Expanded(

                                      child: NoDataFound()
                                          .noItemFound("Your response already submitted!"),
                                    ),
                                  }
                                  else if (examStartPageController.questionListResponseStatusCode.value == 203) ...{
                                      Expanded(
                                        child: NoDataFound().noItemFound("Quiz time over!"),
                                      ),
                                    }
                                    else if (examStartPageController.questionListResponseStatusCode.value == 204) ...{
                                        Expanded(
                                          child: NoDataFound().noItemFound("Quiz not Start!"),
                                        ),
                                      }
                                      else if (examStartPageController.questionListResponseStatusCode.value == 400) ...{
                                          Expanded(
                                            child: NoDataFound().noItemFound("Quiz not Created!"),
                                          ),
                                        }
                                        else if (examStartPageController.questionListResponseStatusCode.value == 401) ...{
                                            Expanded(
                                              child: NoDataFound().noItemFound("Quiz not Start!"),
                                            ),
                                          }
                                          else if (examStartPageController.questionListResponseStatusCode.value == 402) ...{
                                              Expanded(
                                                child: NoDataFound().noItemFound("Quiz time over!"),
                                              ),
                                            }
                                            else if (examStartPageController.questionListResponseStatusCode.value == 403) ...{
                                                Expanded(
                                                  child: NoDataFound()
                                                      .noItemFound("Your teacher did not create quiz time!"),
                                                ),
                                              }
                                              else if (examStartPageController.questionListResponseStatusCode.value == 404) ...{
                                                  Expanded(
                                                    child: NoDataFound()
                                                        .noItemFound("Exam not start in this moment!"),
                                                  ),
                                                }
                                                else ...{
                                                    Expanded(
                                                      child: Center(
                                                        child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                          child: CircularProgressIndicator(
                                                            backgroundColor: awsStartColor,
                                                            color: awsEndColor,
                                                            strokeWidth: 5,
                                                          ),
                                                        ),


                                                      ),
                                                    ),

                                                  }
                                ],
                              ))


                            ],
                          ))
                        ],
                      )),

                    ],
                  ),
                ),
              ],
            ) ,


            // SizedBox(
            //     width: double.infinity,
            //     height: double.infinity,
            //     child: Stack(
            //       children: [
            //         Background(),
            //         Obx(() => Column(
            //           children: [
            //
            //
            //
            //             Container(
            //               margin: EdgeInsets.fromLTRB(00, 20, 00, 10),
            //               height: 30,
            //               child: Column(
            //                 children: [
            //                   Expanded(
            //                       child: Marquee(
            //                         text: examStartPageController.message.value,
            //                         style: TextStyle(
            //                             fontWeight: FontWeight.w500,
            //                             fontSize: 18,
            //                             color: awsEndColor),
            //                         scrollAxis: Axis.horizontal,
            //                         //scroll direction
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         blankSpace: MediaQuery.of(context).size.width,
            //                         velocity: 50.0,
            //                         //speed
            //                         pauseAfterRound: Duration(seconds: 1),
            //                         startPadding: 10.0,
            //                         accelerationDuration: Duration(seconds: 1),
            //                         accelerationCurve: Curves.linear,
            //                         decelerationDuration:
            //                         Duration(milliseconds: 1000),
            //                         decelerationCurve: Curves.easeOut,
            //                       ))
            //                 ],
            //               ),
            //             ),
            //
            //             Obx(() =>
            //                 Text(
            //                   "current time: " +
            //                       examStartPageController.currentTimeUtc
            //                           .value
            //                   ,
            //                   textAlign: TextAlign.center,
            //                   style: const TextStyle(
            //                       color: awsEndColor,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w500),
            //                 )),
            //             Obx(() =>
            //                 Text(
            //                   "Exam End time: " +
            //                       examStartPageController.utcToLocalDate(examStartPageController.examEndTimeLocal.value)
            //                       ,
            //                   textAlign: TextAlign.center,
            //                   style: const TextStyle(
            //                       color: awsEndColor,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w500),
            //                 )),
            //             Container(
            //               alignment: Alignment.center,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.only(
            //                     topRight: Radius.circular(10.0),
            //                     bottomRight: Radius.circular(10.0),
            //                     topLeft: Radius.circular(10.0),
            //                     bottomLeft: Radius.circular(10.0)),
            //                 color: Colors.black.withOpacity(.1),
            //               ),
            //               padding: EdgeInsets.only(
            //                   left: 40, right: 40, top: 15, bottom: 15),
            //               margin: EdgeInsets.only(
            //                   left: 20, right: 20, top: 00, bottom: 00),
            //               child: Column(
            //                 children: [
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment
            //                         .center,
            //                     children: [
            //                       Text(("Question: "),
            //                           style: TextStyle(
            //                               color: Colors.black,
            //                               fontSize: 15,
            //                               fontWeight: FontWeight.w500)),
            //                       Obx(
            //                             () =>
            //                             Text(
            //                                 examStartPageController
            //                                     .currentQuestionNo.value,
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontSize: 15,
            //                                     fontWeight: FontWeight
            //                                         .w500)),
            //                       ),
            //                       Obx(
            //                             () =>
            //                             Text(
            //                                 (" of " +
            //
            //                                     examStartPageController
            //                                         .totalQuestionNo
            //                                         .value),
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontSize: 15,
            //                                     fontWeight: FontWeight
            //                                         .w500)),
            //                       ),
            //                     ],
            //                   ),
            //                   SizedBox(
            //                     height: 10,
            //                   ),
            //                   Text(
            //                     "Remaining Time",
            //                     textAlign: TextAlign.center,
            //                     style: const TextStyle(
            //                         color: awsEndColor,
            //                         fontSize: 16,
            //                         fontWeight: FontWeight.w500),
            //                   ),
            //                   SizedBox(
            //                     height: 5,
            //                   ),
            //                   Obx(
            //                         () =>
            //                         Text(
            //                           examStartPageController.startTxt
            //                               .value,
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               color: awsStartColor,
            //                               fontSize: 20,
            //                               fontWeight: FontWeight.bold),
            //                         ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //
            //             if(examStartPageController.questionListResponseStatusCode.value == 200)...{
            //
            //
            //
            //               // short question section
            //
            //               if (examStartPageController.questionType.value ==
            //                   1) ...{
            //                 Padding(
            //                     padding: EdgeInsets.only(
            //                         left: 10,
            //                         right: 10,
            //                         top: 20,
            //                         bottom: 00),
            //                     child: Align(
            //                       alignment: Alignment.centerLeft,
            //                       child: Obx(() =>
            //                           Text(
            //                               "Q: " + "${examStartPageController
            //                                   .shortQuestionModel.value
            //                                   .data![0].questionName}"
            //                               ,
            //                               style: TextStyle(
            //                                   color: Colors.black87,
            //                                   fontSize: 18,
            //                                   fontWeight:
            //                                   FontWeight.w500)),
            //                       ),
            //                     )
            //
            //
            //                 ),
            //                 Expanded(
            //                   child: Padding(
            //                     padding: EdgeInsets.only(
            //                         left: 10,
            //                         right: 10,
            //                         top: 14,
            //                         bottom: 10),
            //                     child: Flex(
            //                       direction: Axis.vertical,
            //                       children: [
            //                         Expanded(
            //                             child:
            //                             _buildShortQuestionAnswerTextField()),
            //                         Container(
            //                           margin: EdgeInsets.only(
            //                               left: 20, right: 20, top: 10,bottom: 20),
            //                           child:
            //                           _buildNextButton_short_question(),
            //                         ),
            //                         // Container(
            //                         //   margin: EdgeInsets.only(
            //                         //       left: 20,
            //                         //       right: 20,
            //                         //       top: 20,
            //                         //       bottom: 20),
            //                         //   child: _buildSkipButton("1"),
            //                         // ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               }
            //               // mcq question section
            //               else if (examStartPageController.questionType.value ==
            //                   2) ...{
            //                 Expanded(
            //                   child: Column(
            //                     children: <Widget>[
            //                       Expanded(
            //                         child: Column(
            //                           children: [
            //                             Padding(
            //                               padding: EdgeInsets.only(
            //                                   left: 10,
            //                                   right: 10,
            //                                   top: 20,
            //                                   bottom: 00),
            //                               child: Flex(
            //                                 direction: Axis.horizontal,
            //                                 children: [
            //                                   // .
            //                                   Obx(() =>
            //                                       Text(
            //                                           "Q: " +
            //                                               "${examStartPageController
            //                                                   .mcqQuestionDataModel
            //                                                   .value
            //                                                   .data![0]
            //                                                   .questionName}"
            //                                           ,
            //                                           style: TextStyle(
            //                                               color: Colors
            //                                                   .black87,
            //                                               fontSize: 18,
            //                                               fontWeight:
            //                                               FontWeight
            //                                                   .w500)),),
            //
            //                                 ],
            //                               ),
            //                             ),
            //                             Expanded(
            //                                 child: Container(
            //                                   color: transparent,
            //                                   child: Theme(
            //                                     data: Theme.of(context)
            //                                         .copyWith(
            //                                       unselectedWidgetColor:
            //                                       awsEndColor,
            //                                     ),
            //                                     child: Obx(() =>
            //                                         ListView.builder(
            //                                           itemCount: examStartPageController
            //                                               .mcqQuestionDataModel
            //                                               .value.data![0]
            //                                               .questionsOptions ==
            //                                               null ? 0
            //                                               : examStartPageController
            //                                               .mcqQuestionDataModel
            //                                               .value.data![0]
            //                                               .questionsOptions
            //                                               .length,
            //                                           // itemCount: 4,
            //                                           shrinkWrap: false,
            //                                           physics:
            //                                           const NeverScrollableScrollPhysics(),
            //                                           itemBuilder: (
            //                                               context, index) {
            //                                             return Obx(() =>
            //                                                 RadioListTile<
            //                                                     int>(
            //
            //                                                     value: index,
            //                                                     activeColor: awsEndColor,
            //                                                     title: Text(
            //                                                       examStartPageController
            //                                                           .abcdList[index]
            //                                                           .toString() +
            //                                                           " ${examStartPageController
            //                                                               .mcqQuestionDataModel
            //                                                               .value
            //                                                               .data![0]
            //                                                               .
            //                                                           questionsOptions[index]
            //                                                               .mcqOptionAnswer}",
            //                                                       // optionList[index]["mcq_option_answer"].toString(),
            //                                                       style: TextStyle(
            //                                                           fontSize: 16),
            //                                                     ),
            //                                                     groupValue:
            //                                                     examStartPageController
            //                                                         .selectedValue
            //                                                         .value,
            //                                                     onChanged: (
            //                                                         value) {
            //                                                       // _showToast(examStartPageController.mcqQuestionDataModel.value.data![0].
            //                                                       // questionsOptions[index].questionMcqOptionsId.toString());
            //                                                       examStartPageController
            //                                                           .selectedValueUpdate(
            //                                                           index);
            //
            //                                                       examStartPageController
            //                                                           .updateQuestionMcqOptionsId(
            //                                                           examStartPageController
            //                                                               .mcqQuestionDataModel
            //                                                               .
            //                                                           value
            //                                                               .data![0]
            //                                                               .questionsOptions[index]
            //                                                               .questionMcqOptionsId
            //                                                               .toString());
            //                                                     }));
            //                                           },
            //                                         ),),
            //
            //
            //                                   ),
            //                                 )),
            //                           ],
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //                 Container(
            //                   margin: EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 20),
            //                   child: _buildNextButton_mcq_question(),
            //                 ),
            //                 // Container(
            //                 //   margin: EdgeInsets.only(
            //                 //       left: 20,
            //                 //       right: 20,
            //                 //       top: 20,
            //                 //       bottom: 20),
            //                 //   child: _buildSkipButton("1"),
            //                 // ),
            //               }
            //               //no question found
            //               else...{
            //                   Expanded(
            //                     child: NoDataFound().noItemFound(
            //                         "Question Not Found! try again! "),
            //                   ),
            //                 }
            //
            //             }
            //             else if (examStartPageController.questionListResponseStatusCode.value == 201) ...{
            //               Expanded(
            //
            //                 child: NoDataFound()
            //                     .noItemFound("Your response already submitted!"),
            //               ),
            //             }
            //             else if (examStartPageController.questionListResponseStatusCode.value == 203) ...{
            //                 Expanded(
            //                   child: NoDataFound().noItemFound("Quiz time over!"),
            //                 ),
            //               }
            //               else if (examStartPageController.questionListResponseStatusCode.value == 204) ...{
            //                   Expanded(
            //                     child: NoDataFound().noItemFound("Quiz not Start!"),
            //                   ),
            //                 }
            //                 else if (examStartPageController.questionListResponseStatusCode.value == 400) ...{
            //                     Expanded(
            //                       child: NoDataFound().noItemFound("Quiz not Created!"),
            //                     ),
            //                   }
            //                   else if (examStartPageController.questionListResponseStatusCode.value == 401) ...{
            //                       Expanded(
            //                         child: NoDataFound().noItemFound("Quiz not Start!"),
            //                       ),
            //                     }
            //                     else if (examStartPageController.questionListResponseStatusCode.value == 402) ...{
            //                         Expanded(
            //                           child: NoDataFound().noItemFound("Quiz time over!"),
            //                         ),
            //                       }
            //                       else if (examStartPageController.questionListResponseStatusCode.value == 403) ...{
            //                           Expanded(
            //                             child: NoDataFound()
            //                                 .noItemFound("Your teacher did not create quiz time!"),
            //                           ),
            //                         }
            //                         else if (examStartPageController.questionListResponseStatusCode.value == 404) ...{
            //                             Expanded(
            //                               child: NoDataFound()
            //                                   .noItemFound("Exam not start in this moment!"),
            //                             ),
            //                           }
            //                           else ...{
            //                               Expanded(
            //                                 child: Center(
            //                                   child: SizedBox(
            //                                     height: 80,
            //                                     width: 80,
            //                                     child: CircularProgressIndicator(
            //                                       backgroundColor: awsStartColor,
            //                                       color: awsEndColor,
            //                                       strokeWidth: 5,
            //                                     ),
            //                                   ),
            //
            //
            //                                 ),
            //                               ),
            //
            //                             }
            //           ],
            //         ))
            //       ],
            //     )),
          )


          ),
    );
  }

  Widget _buildShortQuestionAnswerTextField({
    String? hintText,
    String? labelText,
  }) {
    return TextFormField(
      controller: examStartPageController.shortQuestionNameController.value,
      minLines: 5,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: 'Write your answer',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }

  Widget _buildNextButton_short_question() {
    return ElevatedButton(
      onPressed: () {
        String shortQuestionAnswerTxt =
            examStartPageController.shortQuestionNameController.value.text;

        if (shortQuestionAnswerTxt.isEmpty) {
          Fluttertoast.cancel();
          _showToast("Answer can't empty");
          return;
        }



        examStartPageController.submitShortQuestionAnswer(
            answerText:shortQuestionAnswerTxt,
            questionId:examStartPageController.shortQuestionModel.value.data![0].questionId.toString(),
            quizId: examStartPageController.shortQuestionModel.value.data![0].quizId.toString(),
            studentId: examStartPageController.studentId.value,
            uid: examStartPageController.hw_panel_uid.value);

        // _submitShortQuestion(shortQuestionAnswerTxt,questionId);
      },
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
            "Submit Short",
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

  Widget _buildNextButton_mcq_question() {
    return ElevatedButton(
      onPressed: () {
        if (examStartPageController.questionMcqOptionsId.value.isEmpty) {
          Fluttertoast.cancel();
          _showToast("Please select answer! ");
          return;
        }

        else {

          examStartPageController.submitMcqQuestionAnswer(
              questionMcqOptionsId:examStartPageController.questionMcqOptionsId.value,
              questionId:examStartPageController.mcqQuestionDataModel.value.data![0].questionId.toString(),
              quizId: examStartPageController.mcqQuestionDataModel.value.data![0].quizId.toString(),
              studentId: examStartPageController.studentId.value,
              uid: examStartPageController.hw_panel_uid.value);

          // _showToast(question_mcq_options_id);
          // selected_question_mcq_options_id=optionList[selectedValue]["question_mcq_options_id"].toString();
          // _submitMCQQuestion(selected_question_mcq_options_id,questionId);
          // _showToast(selected_question_mcq_options_id);



        }
      },
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
            "Submit Mcq",
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

  Widget _buildSkipButton1(String questionId) {
    return ElevatedButton(
      onPressed: () {
        examStartPageController.cancelTimer();
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [awsMixedColor, awsMixedColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Skip Question",
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

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // String utcToLocalDate(String value){
  //   try{
  //
  //     var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss"); // you can change the format here
  //     var utcDate = dateFormat.format(DateTime.parse(value)); // pass the UTC time here
  //     var localDate = dateFormat.parse(utcDate, true).toLocal().toString();//convert local time
  //
  //     // var dateFormat1 = DateFormat("hh:mm aa");
  //     var dateFormat2 = DateFormat("dd-MM-yyyy");
  //
  //     String formattedTime = dateFormat.format(DateTime.parse(localDate));
  //     return formattedTime;
  //   }
  //   catch(Exception ){
  //     return "catch";
  //   }
  //
  // }
}
