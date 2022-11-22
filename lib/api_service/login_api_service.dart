import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hw_pannel/api_service/sharePreferenceDataSaveName.dart';
import 'package:hw_pannel/controller/home_page_controller.dart';
import 'package:hw_pannel/controller/log_in_page_controller.dart';
import 'package:hw_pannel/view/HomePage.dart';

import '../Colors.dart';
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

          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_LOG_IN'),
          // var response = await http.post(Uri.parse('https://hw.arenaclass.stream/apk/login/'),
              body: {
            'username': userName,
            'password': password,
          }
          );

        //  _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
           // _showToast("success");
            var data = jsonDecode(response.body);

            if(data['data']['user_type'].toString()=="student"){
              saveUserInfo(
                user_id:data['data']['user_id'].toString(),
                name: data['data']['username'].toString(),
                batch: data['data']['batch'].toString(),
                batch_name: data['data']['batch_name'].toString(),
                fullName: data['data']['fullname'].toString(),
                user_type:data['data']['user_type'].toString(),
                user_api_key: data['data']['api_key'].toString(),
                pending_assignment_count: data['data']['pending'].toString(),
                done_assignment_count: data['data']['done'].toString(),
                total_assignment_count: data['data']['total'].toString(),
              );

              userCrossLogIn(
                apiKey: data["data"]["api_key"].toString(),
                password: password,

              );
            }else{
              Get.back();
              _showToast("User name or password not match!");

            }

           // Get.offAll(HomePageScreen());

          }
          else if (response.statusCode == 403) {
            Get.back();
            var data = jsonDecode(response.body);
            _showToast("User name or password not match!");
          }
          else {
            Get.back();
            var data = jsonDecode(response.body);
            _showToast(data['message']);
          }

        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {
        //  Get.back();

          /// Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }


  //cross login api call
  userCrossLogIn({
    required String apiKey,
    required String password,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          var response = await http.get(Uri.parse('$BASE_URL_API$SUB_URL_API_CROSSS_LOG_IN$apiKey/'),);

            // _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
          // Get.back();

          List data = jsonDecode(response.body);
          saveUserEmail(email: data[0]["email"].toString());
           userAutoLogIn(
               username: data[0]["username"].toString(),
               email: data[0]["email"].toString(),
               phone_number: data[0]["phone"].toString(),
               gender: data[0]["genders"].toString(),
               password: password,
               api_key: apiKey,
               batch: data[0]["batch"].toString()
           );

          }

          else {
            Get.back();
            var data = jsonDecode(response.body);
            _showToast(data['message']);
          }


        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {
          // Get.back();

          /// Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }



  //auto login with exam panel
  userAutoLogIn({
    required String username,
    required String email,
    required String phone_number,
    required String gender,
    required String password,
    required String api_key,
    required String batch,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
        //  var response = await http.post(Uri.parse('$BASE_URL_EXAM_PANNEL$SUB_URL_API_AUTO_LOG_IN'),
          var response = await http.post(
              // Uri.parse('http://192.168.1.4:8002/api/auto-login/'),

              Uri.parse('$BASE_URL_EXAM_PANNEL$SUB_URL_API_AUTO_LOG_IN'),
              body: {
                'username': username,
                'email': email,
                'phone_number': phone_number,
                'gender': gender,
                'password': password,
                'api_key': api_key,
                'batch': batch
          });

          if (response.statusCode == 200) {
            Get.back();
            var data = jsonDecode(response.body);

            saveUserUId(uId: data['uid'].toString(), id: data['id'].toString(),
                accessToken: data['access_token'].toString(), refreshToken: data['refresh_token'].toString());



            final logInPageController = Get.put(LogInPageController());
            logInPageController.userNameController.value.text="";
            logInPageController.passwordController.value.text="";

            Get.offAll(()=>HomePageScreen())?.then((value) => Get.delete<HomePageController>());

          }
          else if (response.statusCode == 403) {
            Get.back();
            var data = jsonDecode(response.body);
            _showToast(data['message']);
          }
          else {
            Get.back();
            var data = jsonDecode(response.body);
            _showToast(data['message']);
          }


        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {
          //  Get.back();

          /// Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  ///hw panel user data save with share pref
  void saveUserInfo({
    required String name,
    required String fullName,
    required String batch,
    required String batch_name,
    required String user_type,
    required String user_id,
    required String user_api_key,
    required String pending_assignment_count,
    required String done_assignment_count,
    required String total_assignment_count,
  }) async {
    try {
      var storage =GetStorage();
      storage.write(pref_user_name, name);
      storage.write(pref_full_name, fullName);
      storage.write(pref_user_batch, batch);
      storage.write(pref_user_batch_name, batch_name);
      storage.write(pref_user_type, user_type);
      storage.write(pref_user_id, user_id);
      storage.write(pref_user_api_key, user_api_key);

      //
      storage.write(pref_user_total_pending_assignment_count, pending_assignment_count);
      storage.write(pref_user_total_done_assignment_count, done_assignment_count);
      storage.write(pref_user_total_assignment_count, total_assignment_count);

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

  ///exam panel user data save with share pref
  void saveUserUId({required String uId,required String id,required String accessToken,required String refreshToken,}) async {
    try {
      var storage =GetStorage();
      storage.write(exam_pannel_pref_user_uid, uId);
      storage.write(exam_panel_pref_user_id, id);


      storage.write(exam_panel_user_access_token, accessToken);
      storage.write(exam_panel_user_refresh_token, refreshToken);

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

  ///user email save with share pref
  void saveUserEmail({required String email}) async {
    try {

      var storage =GetStorage();
      storage.write(pref_user_email, email);

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
