
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hw_pannel/view/change_password.dart';
import 'package:hw_pannel/view/fotget_password_page.dart';
import 'package:hw_pannel/view/log_in_page.dart';
import 'package:hw_pannel/view/user_profile.dart';
import 'package:hw_pannel/view/user_profile_update.dart';
import 'Colors.dart';


void main() {
  GetStorage.init();
  runApp( MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor:awsStartColor,
    systemNavigationBarColor:awsEndColor,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // LogInScreen(),
            LogInScreen(),
            // ChangePasswordScreen(),
           //Arena@1324
           //  Is CN=Arena Web Security, OU=Arena, O=Arena, L=Dhaka, ST=Dhaka, C=BD correct?

            //   LogInScreen(),
           /// ExamDoneScreen(),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
      _showToast("resumed");
    }
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}