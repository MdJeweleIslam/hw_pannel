import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hw_pannel/api_service/sharePreferenceDataSaveName.dart';

import '../Colors.dart';
import '../view/exam_page.dart';
 import 'api_service.dart';

class LogInApiService {


  //login api call
  userLogIn({
    required String userName,
    required String password,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          showLoadingDialog("Checking");

          var response = await http
              .post(Uri.parse('$BASE_URL_API$SUB_URL_API_LOG_IN'), body: {
            'username': userName,
            'password': password,
          });

        //  _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            _showToast("success");
            var data = jsonDecode(response.body);
             saveUserInfo(
               user_id:data['data']['user_id'].toString(),
               name: data['data']['username'].toString(),
               batch: data['data']['batch'].toString(),
               fullName: data['data']['fullname'].toString(),
               user_type:data['data']['user_type'].toString(),
             );


            Get.offAll(ExamPageScreen());


          } else if (response.statusCode == 403) {
            var data = jsonDecode(response.body);
            _showToast(data['msg']);
          } else {
            var data = jsonDecode(response.body);
            _showToast(data['message']);
          }
        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {
          Get.back();

          /// Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }


  void saveUserInfo({required String name,required String fullName,required String batch,required String user_type, required String user_id}) async {
    try {

      var storage =GetStorage();
      storage.write(pref_user_name, name);
      storage.write(pref_full_name, fullName);
      storage.write(pref_user_batch, batch);
      storage.write(pref_user_type, user_type);
      storage.write(pref_user_id, user_id);

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

  void showLoadingDialog(String message) {

    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
       // backgroundColor: Colors.white.withOpacity(.8),
        content: Wrap(
          children: [
            Container(
              alignment: Alignment.center,
               // margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 20),
                child:Column(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height:50,
                      width: 50,
                      margin: EdgeInsets.only(top: 10),
                      child: CircularProgressIndicator(
                        backgroundColor: awsStartColor,
                        color: awsEndColor,
                        strokeWidth: 6,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child:Text(
                        message,
                        style: const TextStyle(fontSize: 25,),
                      ),
                    ),

                  ],
                ),
            )
          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
  }

  //toast create
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
