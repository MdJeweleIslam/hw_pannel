
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Colors.dart';
 import '../controller/exam_start_page_controller.dart';
import 'background.dart';
import 'exam_page.dart';

class ExamDoneScreen extends StatelessWidget {
  final examStartPageController = Get.put(ExamStartPageController()).timer?.cancel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                     Expanded(child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       // color: Colors.blueGrey,
                       children: [
                         Image.asset(
                           "assets/images/icon_response_submit.png",
                           height: 100.0,
                           width: 100.0,

                         ),
                         SizedBox(height: 30,),
                         Text(
                           "Thank You!",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                               color: Colors.black.withOpacity(.7),
                               fontSize: 30,
                               fontWeight: FontWeight.bold),
                         ),
                         SizedBox(height: 10,),
                         Text(
                           "Your answered was successfully submitted.",
                           textAlign: TextAlign.center,
                           style:   TextStyle(
                               color: Colors.black.withOpacity(.5),
                               fontSize: 15,
                               fontWeight: FontWeight.w500),
                         ),
                       ],
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
        Get.off(ExamPageScreen());
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
