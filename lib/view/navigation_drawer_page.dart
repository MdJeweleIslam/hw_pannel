import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:hw_pannel/view/log_in_page.dart';
 import 'package:marquee/marquee.dart';

import '../../../gradiant_icon.dart';
import '../../Colors.dart';
 import '../../controller/forget_password_page_controller.dart';
import 'background.dart';

class NavigationDrawerPasswordScreen extends StatelessWidget {

 // final forgetPasswordPageController = Get.put(ForgetPasswordPageController());


  late String userId;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            _buildUserDrawerHeader(),
            Divider(
              color: Colors.grey,
            ),

            _buildDrawerItem(
                text: 'Submit Assignment',
                textIconColor: awsEndColor,
                onTap: ()=>navigate(0),
                iconLink: 'assets/images/submit_assignment1.png',
                tileColor: Colors.transparent,
            ),

            _buildDrawerItem(
              text: 'Join Class',
              textIconColor: awsEndColor,
              onTap: ()=>navigate(1),
              iconLink: 'assets/images/join_class_icon.png',
              tileColor: Colors.transparent,
            ),

            _buildDrawerItem(
              text: 'Support Topic',
              textIconColor: awsEndColor,
              onTap: ()=>navigate(2),
              iconLink: 'assets/images/support_icon.png',
              tileColor: Colors.transparent,
            ),

            _buildDrawerItem(
              text: 'Change Password',
              textIconColor: awsEndColor,
              onTap: ()=>navigate(3),
              iconLink: 'assets/images/change_password_icon.png',
              tileColor: Colors.transparent,
            ),

            _buildDrawerItem(
              text: 'Log Out',
              textIconColor: awsEndColor,
              onTap: ()=>navigate(3),
              iconLink: 'assets/images/log_out_icon.png',
              tileColor: Colors.transparent,
            ),

        ],
        ),
      )

    );


  }


  Widget _buildUserDrawerHeader() {
    return UserAccountsDrawerHeader(
        accountName: Text("Abdullah",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
        ),
        accountEmail:  Text(
          "abdullah272056@gmail.com",
          style: TextStyle(
              color: Colors.white,
              fontSize: 15
          ),
        ),


      currentAccountPicture:
      CircleAvatar(
        radius: 35,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: awsStartColor,
          backgroundImage: AssetImage('assets/images/person_male.png'),
          radius: 34,
        ),
      ),

      decoration: BoxDecoration(
        color: awsStartColor,
      ),

      currentAccountPictureSize: Size.square(70),

    );
  }


  Widget _buildDrawerItem({

    required String text,
    required String iconLink,
    required Color textIconColor,
    required Color tileColor,
    required VoidCallback onTap,

  }) {
    return ListTile(
      leading: Image.asset(
        height: 20.0,
        width: 20.0,
        iconLink,
        fit: BoxFit.fill,
        color: awsEndColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: textIconColor,
          fontSize: 15,
        ),),
      tileColor: tileColor,
      onTap: onTap,
    );
  }




  _inputValid(String email) {
    if (email.isEmpty) {
      Fluttertoast.cancel();
      _showToast("E-mail can't empty");
      return;
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      Fluttertoast.cancel();
      _showToast("Enter valid email");
      return;
    }
    return false;
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

  navigate(int index){

  }



}
