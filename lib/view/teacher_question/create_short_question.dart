
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Colors.dart';
import '../../controller/create_short_question_controller.dart';

class CreateShortQuestionScreen extends StatelessWidget  {
  String quiz_id;
  String classRoomName;
  final createShortQuestionController = Get.put(CreateShortQuestionController());

  CreateShortQuestionScreen(this.quiz_id, this.classRoomName);

  String _userName="",_fullName="",_userBatch="",_userType="",_userId="";
  bool shimmerStatus = true;

  List teacherIndividualClassRoomQuizList = [];
  var teacherIndividualClassRoomQuizListResponse;

  // @override
  // @mustCallSuper
  // initState() {
  //   super.initState();
  //   // _getTeacherRoomDataList();
  //   loadUserIdFromSharePref().then((_) {
  //     // _getTeacherIndividualClassroomQuizList(_classRoomId,_accessToken);
  //   });
  //   //loadUserIdFromSharePref();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
            leading: IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white,
              size: 22,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            title: Text(
              "Create Written Question",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize:20,
                fontWeight: FontWeight.normal,
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[ awsStartColor, awsStartColor],
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
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
              // padding: const EdgeInsets.symmetric(
              //   horizontal: 8,
              // ).copyWith(top: 5, bottom: 10),
              child:Flex(
                direction: Axis.vertical,
                children: [
                  SizedBox(height: 20,),
                  Expanded(child: _buildTextField()),
                  _buildSaveButton(),
                  SizedBox(height: 15,)

                ],
              ),

            )),
      ),
    );
  }

  Widget _buildTextField({
    String? hintText,
    String? labelText,
  }) {
    return TextFormField(
      controller: createShortQuestionController.shortQuestionNameController.value,
      minLines: 5,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: 'Enter your question',
          hintStyle: TextStyle(
              color: Colors.grey
          ),

          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:awsEndColor, width: 1.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:awsStartColor, width: .5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {

        String shortQuestionTxt = createShortQuestionController.shortQuestionNameController.value.text;

        if (shortQuestionTxt.isEmpty) {
          Fluttertoast.cancel();
          _showToast("Question name can't empty!");
          return;
        }

        _createShortQuestion(shortQuestionTxt);
        ///////////
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient:  LinearGradient(
              colors: [ awsStartColor, awsEndColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: const Text(
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

  _createShortQuestion(String question ) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   print('connected');
      //   _showLoadingDialog(context,"Checking...");
      //   try {
      //     Response response = await post(
      //         Uri.parse('$BASE_URL_API$SUB_URL_API_CREATE_SHORT_QUESTION'),
      //         headers: {
      //           "Authorization": "Token $_accessToken",
      //         },
      //         body: {'question_name': question,
      //           "is_short_questions":"true",
      //           'teacher_id':_userId,
      //           'quiz_id':_quiz_id});
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
                          backgroundColor: Colors.red,
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
