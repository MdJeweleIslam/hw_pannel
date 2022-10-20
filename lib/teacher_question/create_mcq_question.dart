import 'dart:convert';

import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Colors.dart';
import '../api_service/sharePreferenceDataSaveName.dart';


class CreateMCQQuestionScreen extends StatefulWidget {
  String quiz_id;
  String classRoomName;


  CreateMCQQuestionScreen(this.quiz_id, this.classRoomName);

  @override
  State<CreateMCQQuestionScreen> createState() => _CreateMCQQuestionScreenState(this.quiz_id,this.classRoomName);
}

class _CreateMCQQuestionScreenState extends State<CreateMCQQuestionScreen> {
  String _quiz_id;
  String _classRoomName;


  _CreateMCQQuestionScreenState(this._quiz_id, this._classRoomName);

  TextEditingController? _shortQuestionNameController = TextEditingController();
  TextEditingController? _shortQuestionOptionNameController = TextEditingController();
  TextEditingController? _classRoomNameUpdateController = TextEditingController();
  bool _isObscure = true;

  TextEditingController? otpEditTextController = new TextEditingController();


  bool shimmerStatus = true;

  List optionList = [];

  var teacherIndividualClassRoomQuizListResponse;

  int selectedValue = -1;
  String selectedValueText ="";

  String correct_answer_array="";
  String answer_option="";

  String _userName="",_fullName="",_userBatch="",_userType="",_userId="";


  @override
  @mustCallSuper
  initState() {
    super.initState();

    loadUserIdFromSharePref().then((_) {
      //_getAllQuestionList(_accessToken);
    });

  }

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

                    Expanded(child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return  Padding(
                            padding:
                            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            //const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 10),
                            child:SingleChildScrollView(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[

                                    Container(
                                      color:  transparent,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: awsStartColor,
                                        ),
                                        child: Column(
                                          children: [

                                            ListView.builder(
                                              itemCount: optionList == null ? 0 : optionList.length,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return RadioListTile<int>(
                                                    value: index,
                                                    activeColor: awsEndColor,
                                                    title: Text(
                                                      optionList[index].toString(),
                                                      style: TextStyle(fontSize: 16),
                                                    ),
                                                    groupValue: selectedValue,
                                                    onChanged: (value) => setState(() {
                                                      selectedValue = index;
                                                      selectedValueText="Cox's Bazar";
                                                    })
                                                );
                                              },
                                            ),


                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          )
                          ;
                        }),)

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
      controller: _shortQuestionNameController,
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
      controller: _shortQuestionOptionNameController,
      minLines: 2,
      maxLines: null,
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

        String shortQuestionTxt = _shortQuestionNameController!.text;

        if (shortQuestionTxt.isEmpty) {
          Fluttertoast.cancel();
          _showToast("question can't empty");
          return;
        }

        answer_option="";
        if(optionList.length>=2){
          for(int i=0; i<optionList.length; i++){
            if(answer_option==null|| answer_option.isEmpty){
              answer_option=optionList[i];
            }else{
              answer_option=answer_option+","+optionList[i];
            }

          }
        }else{
          _showToast("Add option");
          return;
        }
        correct_answer_array="";
        if(selectedValue==-1){
          _showToast(" please select answer");
          return;
        }
        else{
          for(int i=0; i<optionList.length; i++){
            if(correct_answer_array==null|| correct_answer_array.isEmpty){

              if(selectedValue==i){
                correct_answer_array="1";
              }
              else{
                correct_answer_array="0";
              }

            }else{
              if(selectedValue==i){
                correct_answer_array=correct_answer_array+","+"1";
              }
              else{
                correct_answer_array=correct_answer_array+","+"0";
        }

            }
          }
        }



       _createMCQQuestion(shortQuestionTxt,answer_option,correct_answer_array);

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
            if(optionList.length<6){
              String optionTxt = _shortQuestionOptionNameController!.text;

              if (optionTxt.isEmpty) {
                Fluttertoast.cancel();
                _showToast("Option can't empty");
                return;
              }
              optionList.add(optionTxt);
              _shortQuestionOptionNameController?.clear();

            }
            else{

            }

            setState(() {

            });
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
      setState(() {

        _userName= sharedPreferences.getString(pref_user_name )??"";
        _fullName= sharedPreferences.getString(pref_full_name )??"";
        _userBatch=  sharedPreferences.getString(pref_user_batch )??"";
        _userType= sharedPreferences.getString(pref_user_type )??"";
        _userId= sharedPreferences.getString(pref_user_id )??"";


      });
    } catch(e) {
      //code
    }

  }

}
