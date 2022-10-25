import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateShortQuestionController extends GetxController {
  final shortQuestionNameController = TextEditingController().obs;

  var selectedValue = (-1).obs;

  var selectedValueText = "".obs;
  var answerOption="".obs;
  var correctAnswerArray="".obs;

  var optionList = [].obs;


  void optionListDataAdd(String option){
    optionList.add(option);
  }

  void selectedValueUpdate(int option){
    selectedValue(option);
  }

  updateSelectedValueText(String value ) {
    selectedValueText(value);
  }

  updateCorrectAnswerArray(String value ) {
    correctAnswerArray(value);
  }

  updateAnswerOption(String value) {
    answerOption(value);
  }

}