import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Colors.dart';

class ChangePasswordPageController extends GetxController {

  ///input box controller

  final oldPasswordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;
  final newConfirmPasswordController = TextEditingController().obs;


  ///input box color and operation
  var userNameLevelTextColor = hint_color.obs;
  var passwordLevelTextColor = hint_color.obs;


  var isObscure = true.obs;
  var isObscureNewPassword = true.obs;
  var isObscureConfirmNewPassword = true.obs;



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



}