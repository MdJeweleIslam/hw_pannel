import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Colors.dart';

class LogInPageController extends GetxController {

  ///input box controller
  final userNameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;


  ///input box color and operation
  var userNameLevelTextColor = hint_color.obs;
  var passwordLevelTextColor = hint_color.obs;
  var phoneFocusNode = FocusNode().obs;
  var isObscure = true.obs;



  updateUserNameLevelTextColor(Color value) {
    userNameLevelTextColor(value);
  }

  updateIsObscure(var value) {
    isObscure(value);
  }
  updatePasswordLevelTextColor(Color value) {
    passwordLevelTextColor(value);
  }



}