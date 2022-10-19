import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee/marquee.dart';
import 'package:ntp/ntp.dart';

import 'Colors.dart';
import 'background/background.dart';
import 'exam_start_page.dart';

class ExamPageScreen extends StatefulWidget {
  const ExamPageScreen({Key? key}) : super(key: key);

  @override
  State<ExamPageScreen> createState() => _ExamPageScreenState();
}

class _ExamPageScreenState extends State<ExamPageScreen> {
  bool _isCountingStatus = false;
  String _time = "4:00";
  late Timer _timer;
  int _start = 4 * 60;

  late String userId;

  String _startTxt = "00:00:00";

  String _upcomingExamText = "Up Coming";
  String getTime = "";

  int otp_coundown_second = 0;

  //

  diffSecond1() {
    DateTime dt1 = DateTime.parse("2021-12-23 11:50:50");
    DateTime dt2 = DateTime.parse("2021-12-23 11:50:40");
    Duration diff = dt1.difference(dt2);

    // otp_coundown_second=40;
    if (diff.inSeconds > 0) {
      otp_coundown_second = diff.inSeconds;
    }
  }

  diffSecond() {
    DateTime dt1 = DateTime.parse("2021-12-23 11:50:40");
    DateTime dt2 = DateTime.parse("2021-12-23 11:50:30");
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
        if (second <= 0) {
          setState(() {
            _upcomingExamText = "Start Exam";
            _isCountingStatus = true;
            timer.cancel();
          });
        } else {
          setState(() {
            second--;
            _startTxt = _printDuration(Duration(seconds: second));
          });
        }
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHour = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHour:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();

    // DateTime dt2 = DateTime.parse("2021-12-23 9:47:00");
    diffSecond1();
    _isCountingStatus = false;
    startTimer(otp_coundown_second);

    //controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

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
                      Container(
                        margin: EdgeInsets.fromLTRB(00, 20, 00, 10),
                        height: 30,
                        child: Column(
                          children: [
                            Expanded(
                                child: Marquee(
                              text:
                                  'Working for Application upgrade. Sorry for the inconvenience!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: awsEndColor),
                              scrollAxis: Axis.horizontal,
                              //scroll direction
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: MediaQuery.of(context).size.width,
                              velocity: 70.0,
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

                      Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/aws.png",
                                  width: 180,
                                  height: 90,
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
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "User Name: ",
                                            style: TextStyle(
                                              fontWeight:
                                              FontWeight.w500,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "Sabbir001",
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
                                            "Batch : ",
                                            style: TextStyle(
                                              fontWeight:
                                              FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "Test",
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
                                      //int otp_coundown_second=300;
                                      //int otp_coundown_second=300;
                                      Container(
                                          margin: EdgeInsets.fromLTRB(
                                              20, 30, 20, 00),
                                          child: InkWell(
                                            onTap: () {
                                              // diffSecond();
                                              // _showToast( "click");
                                              // _showToast( diffSecond(dt1,dt2).toString());
                                              //  Duration duration=diffSecond(dt1,dt2);

                                              // _showToast( '$duration.inMinutes.remainder(60)');
                                              // _showToast(duration.inDays.toString());

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                      const ExamStartPageScreen()));
                                            },
                                            child: _buildButtonDesign(
                                                endColor: awsEndColor,
                                                startColor:
                                                awsStartColor,
                                                textValue: "Running"),
                                          )),
                                    ],
                                  ),
                                ),
                                Text(getTime),
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
                                          child: Text(
                                            _startTxt,
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

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "User Name: ",
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight.w500,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "Sabbir001",
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
                                            "Batch : ",
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "Test",
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
                                          main();
                                          //  getNtpTime();
                                          // if(_upcomingExamText=="Start Exam"){
                                          //   _showToast("Ready to exam!");
                                          // }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              20, 20, 20, 00),
                                          child: _buildButtonDesign(
                                              endColor: awsEndColor,
                                              startColor:
                                                  awsStartColor,
                                              textValue:
                                                  _upcomingExamText),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                _buildWhatYouWillLearnList()

                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ))),
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

    setState(() {
      // _showToast(' $_myTime');
      getTime = 'Device time: $_myTime' +
          '\nNtp time: $_ntpTime' +
          '\nDevice utc: $devicedateUtc' +
          '\nNtp utc: $ntpdateUtc';
    });

    return;
  }

  // Future<void> getNtpTime() async {
  //   DateTime _myTime;
  //   DateTime _ntpTime;
  //   DateTime _phoneTime;
  //
  //   /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
  //   try{
  //     _myTime = await NTP.now();
  //     setState((){
  //       _showToast(' $_myTime');
  //       getTime=
  //       //   'device time: $_phoneTime'+
  //       '\nMy time: $_myTime';
  //       //+'\nNTP time: $_ntpTime'+
  //       //     '\nDifference: ${_phoneTime.difference(_myTime).inMilliseconds}ms'+
  //       //     '\nDifference: ${_myTime.difference(_phoneTime).inMilliseconds}ms';
  //       // getTime= 'My time: $_myTime'+'\nNTP time: $_ntpTime'+'\nDifference: ${_myTime.difference(_ntpTime).inMilliseconds}ms';
  //     });
  //   }
  //   catch(e){
  //     _showToast(e.toString());
  //   }
  //
  //  // _phoneTime = await DateTime.now();
  //
  //   /// Or get NTP offset (in milliseconds) and add it yourself
  //   // final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
  //   // _ntpTime = _myTime.add(Duration(milliseconds: offset));
  //  // _showToast(message)
  //
  //
  //   // print('My time: $_myTime');
  //   // print('NTP time: $_ntpTime');
  //   // print('Difference: ${_myTime.difference(_ntpTime).inMilliseconds}ms');
  // }

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


  Widget _buildWhatYouWillLearnList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //shimmer design
        ListView.builder(
          itemCount: 4,
          // itemCount: orderRoomList == null ? 0 : orderRoomList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
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
                      Text(
                        "Test",
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
          },
        )

      ],
    );
  }

  Widget _buildFinishedExamCardDesign(){

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
              Text(
                "Test",
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

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
