import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Colors.dart';

class LogInPageController extends GetxController {
  final userNameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;


  var userNameLevelTextColor = hint_color.obs;
  var passwordLevelTextColor = hint_color.obs;
  var phoneFocusNode = FocusNode().obs;
  var isObscure = true.obs;


  var selectedValueText = "".obs;
  var answerOption="".obs;
  var correctAnswerArray="".obs;

  var optionList = [].obs;



  updateAnswerOption(String value) {
    answerOption(value);
  }


  updateUserNameLevelTextColor(Color value) {
    userNameLevelTextColor(value);
  }

  updateIsObscure(var value) {
    isObscure(value);
  }
  updatePasswordLevelTextColor(Color value) {
    passwordLevelTextColor(value);
  }



  // getApi() async {
  //   try{
  //    // isDataLoading(true);
  //     Response response = await http.post(
  //         Uri.tryParse('http://dummyapi.io/data/v1/user')!,
  //         headers: {'app-id': '6218809df11d1d412af5bac4'}
  //     );
  //     if(response.statusCode == 200){
  //       ///data successfully
  //
  //       var result = jsonDecode(response.body);
  //
  //
  //     }else{
  //       ///error
  //     }
  //   }catch(e){
  //     // log('Error while getting data is $e');
  //     // print('Error while getting data is $e');
  //   }finally{
  //    // isDataLoading(false);
  //   }
  // }



}