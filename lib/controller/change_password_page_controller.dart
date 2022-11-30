import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../Colors.dart';

class ChangePasswordPageController extends GetxController {

  ///input box controller
  dynamic argumentData = Get.arguments;
  String currentRouteName = Get.currentRoute;

  final oldPasswordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;
  final newConfirmPasswordController = TextEditingController().obs;

  final  oldPasswordControllerFocusNode = FocusNode().obs;
  final  newPasswordControllerFocusNode = FocusNode().obs;
  final  newConfirmPasswordControllerFocusNode = FocusNode().obs;

  ///input box color and operation
  var userNameLevelTextColor = hint_color.obs;
  var passwordLevelTextColor = hint_color.obs;

  var isObscure = true.obs;
  var isObscureNewPassword = true.obs;
  var isObscureConfirmNewPassword = true.obs;

  @override
  void onInit() {
    super.onInit();

   // _showToast(argumentData[0]['first']);
   //  _showToast(Get.currentRoute.toString());
    _showToast(Get.previousRoute);
    _showToast(Get.previousRoute);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);

  }

  updateUserNameLevelTextColor(Color value) {
    userNameLevelTextColor(value);
  }

  updateIsObscure(var value) {
    isObscure(value);
  }

  updateIsObscureNewPassword(var value) {
    isObscureNewPassword(value);
  }
  updateIsObscureConfirmNewPassword(var value) {
    isObscureConfirmNewPassword(value);
  }

  updatePasswordLevelTextColor(Color value) {
    passwordLevelTextColor(value);
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
}