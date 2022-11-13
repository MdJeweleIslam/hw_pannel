import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hw_pannel/view/exam_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Colors.dart';

import '../api_service/sharePreferenceDataSaveName.dart';
import '../controller/home_page_controller.dart';
import 'background.dart';
import 'navigation_drawer_page.dart';

class HomePageScreen extends StatelessWidget {

  final examPageController = Get.put(HomePageController());

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final Uri _url = Uri.parse('https://arenawebsecurity.net/profile#paymentID');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backGroundColor,
          // backgroundColor: Colors.backGroundColor,
          key: _key,

          drawer: NavigationDrawerPasswordScreen(),
          body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Background(),

                  Column(
                    children: [

                      Container(
                        margin: const EdgeInsets.fromLTRB(00, 20, 00, 10),

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
                            Expanded(child: Text("Home Page",
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

                                const SizedBox(
                                  height: 20,
                                ),
                                _buildCardItem(
                                  fieldName: 'Batch Name',
                                  fieldValue: 'Test',
                                  imageLink: 'assets/images/batch_icon.png',

                                ),

                                _buildCardItem(
                                  fieldName: 'Total Pending Assignment',
                                  fieldValue: '1',
                                  imageLink: 'assets/images/assignment_pending_icon.png',

                                ),

                                _buildCardItem(
                                  fieldName: 'Number of Assignment Done',
                                  fieldValue: '2',
                                  imageLink: 'assets/images/submit_assignment1.png',

                                ),

                                Row(
                                  children: [
                                    Expanded(


                                      child: InkWell(
                                        onTap: (){
                                          _launchUrl();
                                        },
                                        child: _buildCardItem1(

                                          fieldValue: 'Pay Now',
                                          imageLink: 'assets/images/pay_now_icon.png',

                                        ),

                                      )
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          Get.to(ExamPageScreen());

                                        },
                                        child: _buildCardItem1(

                                          fieldValue: 'Start Exam',
                                          imageLink: 'assets/images/exam_icon.png',

                                        ),

                                      )
                                     )
                                  ],
                                ),



                                //_buildFinishedExamList()

                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ))),
    );
  }

  //finished exam list
  Widget _buildFinishedExamList() {
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
                borderRadius: const BorderRadius.only(
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

                ],
              ),
            );
          },
        )

      ],
    );
  }


  Widget _buildCardItem({required String fieldValue,required String fieldName,required String imageLink}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
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
          bottom: 20),
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 00),
      child:Row(
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    fieldValue,
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text(fieldName,
                    style: TextStyle(
                      fontWeight:
                      FontWeight.normal,
                      color: Colors.black.withOpacity(.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

            ],)

          ),

          Container(
            child: Image.asset(
              imageLink,
              width: 50,
              height: 50,
              color: Colors.black.withOpacity(.6),

            ),
          )
        ],
      ),
    );
  }


  Widget _buildCardItem1({required String fieldValue,required String imageLink}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
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
          bottom: 20),
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 00),
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                imageLink,
                width: 40,
                height: 40,
                color: Colors.black.withOpacity(.6),

              ),
            ),
            SizedBox(height: 15,),
            Text(
              fieldValue,
              style: TextStyle(
                fontWeight:
                FontWeight.bold,
                color: awsStartColor,
                fontSize: 20,
              ),
            ),



          ],),
      ),
    );
  }

  //join now url page redirect
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
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
    try {
      var storage =GetStorage();
      storage.read(hw_pannel_pref_user_uid);
      storage.read(hw_pannel_pref_user_id);
    } catch(e) {
      //code
    }

  }



  loadUserIdFromSharePref1() async {
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
