import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Colors.dart';
import '../../controller/create_mcg_question_controller.dart';




class CreateMCQQuestionScreen extends StatelessWidget  {

  String quiz_id;
  String classRoomName;

  final createMcqQuestionController = Get.put(CreateMcqQuestionController());
  CreateMCQQuestionScreen(this.quiz_id, this.classRoomName);

  var teacherIndividualClassRoomQuizListResponse;

  String _userName="",_fullName="",_userBatch="",_userType="",_userId="";


  // @override
  // @mustCallSuper
  // initState() {
  //   super.initState();
  //   loadUserIdFromSharePref().then((_) {
  //     //_getAllQuestionList(_accessToken);
  //   });
  //
  // }

  @override
  Widget build(BuildContext context)  {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.backGroundColor,
        appBar: AppBar(
            leading: IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            title:  Text(
              "Create MCQ Question",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),

            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[awsStartColor,awsStartColor],
                ),
              ),
            )),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.purple,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));

            //updateDataAfterRefresh();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ).copyWith(top: 5, bottom: 10),
            child:Flex(
              direction: Axis.vertical,
              children: [
                const SizedBox(height: 20,),
                Expanded(child:Flex(
                   direction:Axis.vertical,
                  children: [
                    _buildTextField(),
                    const SizedBox(height: 15,),
                    _buildAddButton(),
                    SizedBox(height: 15,),

                    Expanded(child: Obx(() =>
                        ListView.builder(
                          itemCount: createMcqQuestionController.optionList== null ? 0 : createMcqQuestionController.optionList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Obx(() =>RadioListTile<int>(
                              value: index,
                              activeColor: awsEndColor,
                              title: Text(
                                '${createMcqQuestionController.optionList[index]}',
                                style: TextStyle(fontSize: 16),
                              ),
                              groupValue: createMcqQuestionController.selectedValue.value,
                              onChanged: (value){
                                createMcqQuestionController.selectedValueUpdate(index);
                                createMcqQuestionController.updateSelectedValueText(value.toString());

                              },

                            ) );

                          },
                        ),

                    //     ListView.builder(
                    //  // scrollDirection: Axis.vertical,
                    //   padding: EdgeInsets.all(10),
                    //   itemCount: createMcqQuestionController.testList.length,
                    //   itemBuilder: (context, index){
                    //     return RadioListTile<int>(
                    //         value: index,
                    //         activeColor: awsEndColor,
                    //         title: Text(
                    //           '${createMcqQuestionController.testList[index]}',
                    //           style: TextStyle(fontSize: 16),
                    //         ),
                    //         groupValue: createMcqQuestionController.selectedValue,
                    //         onChanged: (value){
                    //
                    //         }
                    //       // onChanged: (value) => setState(() {
                    //       //   selectedValue = index;
                    //       //   selectedValueText="Cox's Bazar";
                    //       // })
                    //     );
                    //   }
                    //
                    // )

                    ),),



                    // Expanded(child: StatefulBuilder(
                    //     builder: (BuildContext context, StateSetter setState) {
                    //       return  Padding(
                    //         padding:
                    //         EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    //         //const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 10),
                    //         child:SingleChildScrollView(
                    //           child: Padding(
                    //             padding:
                    //             const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 10),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //
                    //                 Container(
                    //                   color:  transparent,
                    //                   child: Theme(
                    //                     data: Theme.of(context).copyWith(
                    //                       unselectedWidgetColor: awsStartColor,
                    //                     ),
                    //                     child: Column(
                    //                       children: [
                    //
                    //                         ListView.builder(
                    //                           itemCount: optionList == null ? 0 : optionList.length,
                    //                           shrinkWrap: true,
                    //                           physics: const NeverScrollableScrollPhysics(),
                    //                           itemBuilder: (context, index) {
                    //                             return RadioListTile<int>(
                    //                                 value: index,
                    //                                 activeColor: awsEndColor,
                    //                                 title: Text(
                    //                                   optionList[index].toString(),
                    //                                   style: TextStyle(fontSize: 16),
                    //                                 ),
                    //                                 groupValue: selectedValue,
                    //                                 onChanged: (value) => setState(() {
                    //                                   selectedValue = index;
                    //                                   selectedValueText="Cox's Bazar";
                    //                                 })
                    //                             );
                    //                           },
                    //                         ),
                    //
                    //
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //
                    //                 const SizedBox(
                    //                   height: 15,
                    //                 ),
                    //
                    //                 const SizedBox(
                    //                   height: 15,
                    //                 ),
                    //
                    //
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //       ;
                    //     }),)

                  ],
                )),

                _buildSaveButton(),
                const SizedBox(height: 15,),


              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    String? hintText,
    String? labelText,
  }) {
    return TextFormField(
      controller: createMcqQuestionController.shortQuestionNameController.value,

      // _shortQuestionNameController,
      minLines: 4,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: 'Enter your question',
          hintStyle: TextStyle(
              color: Colors.grey
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget _buildOptionTextField({
    String? hintText,
    String? labelText,
  }) {
    return TextFormField(
      controller: createMcqQuestionController.shortQuestionOptionNameController.value,
      minLines: 1,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: 'Enter option',
          hintStyle: TextStyle(
              color: Colors.grey
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          )
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {

       // String shortQuestionTxt = _shortQuestionNameController!.text;

        String shortQuestionTxt = createMcqQuestionController.shortQuestionNameController.value.text;

        if (shortQuestionTxt.isEmpty) {
          Fluttertoast.cancel();
          _showToast("Question name can't empty!");
          return;
        }

        // answer_option="";
        createMcqQuestionController.updateAnswerOption("");


        if(createMcqQuestionController.optionList.length>=2){
          for(int i=0; i<createMcqQuestionController.optionList.length; i++){
            if(createMcqQuestionController.answerOption.value==null||createMcqQuestionController.answerOption.value.isEmpty){
              createMcqQuestionController.updateAnswerOption(createMcqQuestionController.optionList[i]);
            //  answer_option=createMcqQuestionController.optionList[i];
            }else{
              createMcqQuestionController.updateAnswerOption(
                  createMcqQuestionController.answerOption.value+","+createMcqQuestionController.optionList[i]);
              // answer_option=createMcqQuestionController.answerOption.value+","+createMcqQuestionController.optionList[i];
            }

          }
        }
        else{
          _showToast("Please add more option!");
          return;
        }

        // correct_answer_array="";
        createMcqQuestionController.updateCorrectAnswerArray("");


        if(createMcqQuestionController.selectedValue.value==-1){
          _showToast(" please select answer");
          return;
        }
        else{
          for(int i=0; i<createMcqQuestionController.optionList.length; i++){
            if(createMcqQuestionController.correctAnswerArray.value ==null|| createMcqQuestionController.correctAnswerArray.value.isEmpty){

              if(createMcqQuestionController.selectedValue.value==i){
               // correct_answer_array="1";
                createMcqQuestionController.updateCorrectAnswerArray("1");
              }
              else{
               // correct_answer_array="0";
                createMcqQuestionController.updateCorrectAnswerArray("0");
              }

            }else{
              if(createMcqQuestionController.selectedValue.value==i){
                createMcqQuestionController.updateCorrectAnswerArray(createMcqQuestionController.correctAnswerArray.value+","+"1");
              //  correct_answer_array=createMcqQuestionController.correctAnswerArray+","+"1";
              }
              else{
                createMcqQuestionController.updateCorrectAnswerArray(createMcqQuestionController.correctAnswerArray.value+","+"0");
               // correct_answer_array=createMcqQuestionController.correctAnswerArray+","+"0";
        }

            }
          }
        }

       _createMCQQuestion(shortQuestionTxt,createMcqQuestionController.answerOption.value,createMcqQuestionController.correctAnswerArray.value);

      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ awsStartColor,  awsEndColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Save",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return  Flex(direction: Axis.horizontal,
      children: [
        Expanded(child: _buildOptionTextField(),),
        SizedBox(width: 10,),
        InkResponse(
          child: Ink(

            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ awsMixedColor,  awsMixedColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(7.0)),
            child: Container(
              height: 50,
              padding: EdgeInsets.only(left: 15,right: 15),
              alignment: Alignment.center,
              child: Text(
                "Add",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PT-Sans',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onTap: (){
            if(createMcqQuestionController.optionList.length<6){
              String optionTxt = createMcqQuestionController.shortQuestionOptionNameController.value.text;

              if (optionTxt.isEmpty) {
                Fluttertoast.cancel();
                _showToast("Option can't empty!");
                return;
              }

              createMcqQuestionController.optionListDataAdd(optionTxt);


              createMcqQuestionController.shortQuestionOptionNameController.value.clear();

            }
            else{

            }

            // setState(() {
            //
            // });
          },
        ),
        SizedBox(width: 10,),
      ],
    );
  }


  _createMCQQuestion(String question, option,answerSelected ) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   print('connected');
      //   _showLoadingDialog(context,"Checking...");
      //   try {
      //     Response response = await post(
      //         Uri.parse('$BASE_URL_API$SUB_URL_API_CREATE_MCQ_QUESTION'),
      //         headers: {
      //           "Authorization": "Token $_accessToken",
      //         },
      //         body: {'question_name': question,
      //           "is_mcq_questions":"true",
      //           'teacher_id':_userId,
      //           'quiz_id':_quiz_id,
      //           'mcq_option_answer':option,
      //           'is_correct_answer':answerSelected
      //
      //         });
      //
      //     if (response.statusCode == 201){
      //
      //       Navigator.of(context).pop();
      //       _showToast("Success");
      //       Navigator.push(context,MaterialPageRoute(builder: (context)=> CreateQuestionTeacherScreen(_quiz_id,_classRoomName)));
      //
      //       var data = jsonDecode(response.body);
      //
      //     }
      //     else {
      //       Navigator.of(context).pop();
      //       var data = jsonDecode(response.body.toString());
      //       Fluttertoast.cancel();
      //       _showToast(data['message'].toString());
      //     }
      //   } catch (e) {
      //     Navigator.of(context).pop();
      //     Fluttertoast.cancel();
      //     print(e.toString());
      //     _showToast("failed১");
      //   }
      // }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  void _showLoadingDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(

          child: Wrap(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 20, bottom: 20),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        const CircularProgressIndicator(
                          backgroundColor: Colors.appRed,
                          strokeWidth: 5,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          message,
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ))
            ],
            // child: VerificationScreen(),
          ),
        );
      },
    );
  }

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

  ///get data from share pref
  loadUserIdFromSharePref() async {
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
