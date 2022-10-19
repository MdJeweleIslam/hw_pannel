import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:marquee/marquee.dart';

import '../gradiant_icon.dart';
import 'Colors.dart';
import 'background/background.dart';
import 'exam_page.dart';

class TimeOverScreen extends StatefulWidget {
  const TimeOverScreen({Key? key}) : super(key: key);

  @override
  State<TimeOverScreen> createState() => _TimeOverScreenState();
}

class _TimeOverScreenState extends State<TimeOverScreen> {
  TextEditingController? _emailController = new TextEditingController();
  bool _isObscure = true;
  bool _isCountingStatus=false;
  String _time="4:00";
  late Timer _timer;
  int _start = 4 * 60;

  late String userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      //  backgroundColor: Colors.backGroundColor,
        // backgroundColor: Colors.backGroundColor,
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:Stack(
              children: [
                Background(),
               Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Expanded(child: Container(
                       // color: Colors.blueGrey,
                       child:  Image.asset(
                         "assets/images/time_up.gif",
                         height: 200.0,
                         // height: double.infinity,
                         width: 300.0,
                         // width: double.infinity,
                       ),
                     ),),

                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child:  _buildHomeButton(),
                    )
                   ],
                 ),
               )

              ],
            )



        ),
      ),
    );


  }


  Widget _buildHomeButton() {
    return ElevatedButton(
      onPressed: () {

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const ExamPageScreen()));

      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [awsStartColor,awsEndColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Container(

          height: 50,
          alignment: Alignment.center,
          child:  const Text(
            "Go Home",
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

}
