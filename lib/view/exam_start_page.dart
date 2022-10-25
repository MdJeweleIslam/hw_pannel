import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'package:marquee/marquee.dart';

import '../../Colors.dart';
import '../../NoDataFound.dart';
import '../../controller/exam_start_page_controller.dart';
import 'background.dart';



class ExamStartPageScreen extends StatelessWidget  {

  final examStartPageController = Get.put(ExamStartPageController());

  late String userId;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.backGroundColor,
          // backgroundColor: Colors.backGroundColor,
          body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Background(),
                  Column(
                    children: [
                      Container(margin: EdgeInsets.fromLTRB(00, 20, 00, 10),
                        height: 30,
                        child:  Column(
                          children: [
                            Expanded(
                                child: Marquee(
                                  text:examStartPageController.message.value,
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize:18,color: awsEndColor),
                                  scrollAxis: Axis.horizontal, //scroll direction
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: MediaQuery.of(context).size.width,
                                  velocity: 50.0, //speed
                                  pauseAfterRound: Duration(seconds: 1),
                                  startPadding: 10.0,
                                  accelerationDuration: Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration: Duration(milliseconds: 1000),
                                  decelerationCurve: Curves.easeOut,
                                )
                            )
                          ],
                        ),),


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
                        padding: EdgeInsets.only(left: 40,right: 40,top: 15,bottom: 15),
                        margin: EdgeInsets.only(left: 20,right: 20,top: 00,bottom: 00),
                        child: Column(

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    ("Question: "),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),

                                Obx(() =>
                                    Text(
                                        examStartPageController.currentQuestionNo.value,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),

                                ),

                                Obx(() =>
                                    Text((" of " +examStartPageController.totalQuestionNo.value),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),

                                ),


                              ],
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Remaining Time",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: awsEndColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5,),



                            Obx(() => Text(
                              examStartPageController.startTxt.value,

                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: awsStartColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),)


                          ],
                        ),
                      ),


                      if(examStartPageController.questionType.value=="1")...{
                        Expanded(child: Column(
                          children: <Widget>[
                            Expanded(child:  Column(
                              children: [

                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 00),
                                  child: Flex(direction: Axis.horizontal,
                                    children: [
                                      Text(("Q: "+"What is your hobby?"),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),

                                ),
                                Expanded(child: Container(
                                  color:  transparent,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: awsEndColor,
                                    ),
                                    child: ListView.builder(
                                      // itemCount: optionList == null ? 0 : optionList.length,
                                      itemCount: 4,
                                      shrinkWrap: false,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Obx(() => RadioListTile<int>(
                                            value: index,
                                            activeColor: awsEndColor,
                                            title: Text(
                                              examStartPageController.abcdList[index].toString()+
                                                  ". mcq_option_answer",
                                              // optionList[index]["mcq_option_answer"].toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            groupValue: examStartPageController.selectedValue.value,
                                            onChanged: (value){
                                              examStartPageController.selectedValueUpdate(index);

                                            }


                                        ))

                                          ;
                                      },
                                    ),
                                  ),
                                )),






                              ],
                            ),)
                          ],
                        ),),

                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: _buildNextButton_mcq_question("1"),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                          child: _buildSkipButton("1"),
                        ),



                      }
                      else if(examStartPageController.questionType.value=="2")...{
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 00),
                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Text(("Q: "+"What is cyber security?"),
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),

                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 14,bottom: 10),
                            child:Flex(
                              direction: Axis.vertical,
                              children: [

                                Expanded(child: _buildShortQuestionAnswerTextField()),


                                Container(
                                  margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                                  child: _buildNextButton_short_question("1"),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                                  child: _buildSkipButton("1"),
                                ),



                              ],
                            ),

                          ),
                        ),

                      }

                      else...{
                      Expanded(
                      child: NoDataFound().noItemFound("Question Not Found! try again! "),
                      ),
                      }


                    ],
                  )


                ],
              )



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
          hintStyle: TextStyle(
              color: Colors.grey
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget _buildNextButton_short_question(String questionId) {
    return ElevatedButton(
      onPressed: () {

        String shortQuestionAnswerTxt = examStartPageController.shortQuestionNameController.value.text;

        if (shortQuestionAnswerTxt.isEmpty) {
          Fluttertoast.cancel();
          _showToast("Answer can't empty");
          return;
        }

        // _submitShortQuestion(shortQuestionAnswerTxt,questionId);

      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [awsStartColor,awsEndColor],
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

  Widget _buildNextButton_mcq_question(String questionId) {
    return ElevatedButton(
      onPressed: () {

        if (examStartPageController.selectedValue.value==-1) {
          Fluttertoast.cancel();
          _showToast("please select answer! ");
          return;
        }else{
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

  Widget _buildSkipButton(String questionId) {
    return ElevatedButton(
      onPressed: () {

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
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }




}
