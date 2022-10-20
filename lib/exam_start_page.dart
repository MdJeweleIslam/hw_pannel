import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hw_pannel/time_over.dart';

import 'package:marquee/marquee.dart';

import 'Colors.dart';
import 'NoDataFound.dart';
import 'background/background.dart';

class ExamStartPageScreen extends StatefulWidget {
  const ExamStartPageScreen({Key? key}) : super(key: key);

  @override
  State<ExamStartPageScreen> createState() => _ExamPageScreenState();
}

class _ExamPageScreenState extends State<ExamStartPageScreen> {


  bool _isCountingStatus=false;
  String _time="4:00";
  late Timer _timer;
  int _start = 4 * 60;

  late String userId;

  String _startTxt = "00:00:00";

  String _upcomingExamText="Up Coming";

  int otp_coundown_second=0;

  int selectedValue = -1;

  TextEditingController? _shortQuestionNameController = TextEditingController();
  String questionType = "1";

  diffSecond1(){
    DateTime dt1 = DateTime.parse("2021-12-23 11:50:30");
    DateTime dt2 = DateTime.parse("2021-12-23 11:50:00");
    Duration diff = dt1.difference(dt2);

    // otp_coundown_second=40;
    if(diff.inSeconds>0 ){
      otp_coundown_second=diff.inSeconds;
    }
  }

  var abcd=["(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)"];

  @override
  @mustCallSuper
  void initState() {
    super.initState();

    // DateTime dt2 = DateTime.parse("2021-12-23 9:47:00");
    diffSecond1();
    _isCountingStatus=false;
    startTimer(otp_coundown_second);

    //controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }
String _message="If you click 'Skip' or 'Submit' button, You will can not go back previous page.";

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
                                  text:_message ,
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
                                Text(
                                    ("1"),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    (" of " +"20"),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
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
                            Text(
                              _startTxt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: awsStartColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),


                      if(questionType=="1")...{
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
                                        return

                                          RadioListTile<int>(
                                              value: index,
                                              activeColor: Colors.appRed,
                                              title: Text(
                                                abcd[index].toString()+
                                                ". mcq_option_answer",
                                                // optionList[index]["mcq_option_answer"].toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              groupValue: selectedValue,
                                              onChanged: (value) => setState(() {
                                                selectedValue = index;
                                                // selected_question_mcq_options_id=optionList[index]["question_mcq_options_id"];
                                              })
                                          );
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
                      else if(questionType=="2")...{
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
      controller: _shortQuestionNameController,
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

        String shortQuestionAnswerTxt = _shortQuestionNameController!.text;

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

        if (selectedValue==-1) {
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

  diffSecond() {

    DateTime dt1 = DateTime.parse("2021-12-23 11:50:00");
    DateTime dt2 = DateTime.parse("2021-12-23 11:20:00");
    Duration diff = dt1.difference(dt2);

    // otp_coundown_second=40;
    _showToast(diff.inSeconds.toString());
    //otp_coundown_second=diff.inSeconds;
  }

  void startTimer(int second) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (second == 0) {
          setState(() {

            _upcomingExamText="Start Exam";
            _isCountingStatus=true;
            _startTxt="Exam Time Finished";
            timer.cancel();
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const TimeOverScreen()));
          });
        } else {
          setState(() {
            second--;
            _startTxt=_printDuration(Duration(seconds: second));
          });
        }
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2,"0");
    String twoDigitHour = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHour:$twoDigitMinutes:$twoDigitSeconds";
  }

}
