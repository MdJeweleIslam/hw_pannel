
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Colors.dart';
import '../controller/submit_assignment_page_controller.dart';
import 'background.dart';

class SubmitAssignmentScreen extends StatelessWidget {

final submitAssignmentPageController = Get.put(SubmitAssignmentPageController());



  // late String userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  backGroundColor,
        // backgroundColor: Colors.backGroundColor,
        body:SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:Stack(
              children: [
                Background(),
                Column(
                  children: [
                    Container(
                      margin:  EdgeInsets.fromLTRB(00, 15, 00, 10),

                      child: Row(
                        children: [
                          const SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              Get.back();
                            },
                            child:  Container(

                              margin: EdgeInsets.only(left: 20,top: 10,right: 10,bottom: 10),

                              child:const Icon(Icons.arrow_back_ios,
                                size: 22,
                                color: awsEndColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(child:
                          Text(
                            "Assignment Submit",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: awsEndColor
                            ),
                          ))
                        ],
                      ),
                    ),
                    Expanded(child: Container(
                      padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Image.asset(
                              "assets/images/aws.png",
                              width: 180,
                              height: 90,
                            ),

                            userInputSelectTopic(),
                            _buildSubmitAssignmentUrlTextField(),

                            const SizedBox(
                              height: 50,
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child:  _buildSubmitAssignmentButton(),),

                            const SizedBox(
                              height: 20,
                            ),


                          ],
                        ),
                      ),
                    )),
                  ],
                )

              ],
            )



        ),
      ),
    );


  }

  Widget userInputSelectTopic() {
    return Container(
        height: 55,

        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 00,right: 00,top: 40,bottom: 20,),

        decoration: BoxDecoration(
            color:Colors.black.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(child: Obx(() =>
            DropdownButton2(


              //   menuMaxHeight:55,
              value: submitAssignmentPageController.selectAssignmentId.value != null &&
                  submitAssignmentPageController.selectAssignmentId.value.isNotEmpty ?
              submitAssignmentPageController.selectAssignmentId.value : null,
              underline:const SizedBox.shrink(),
              hint:Row(
                children: const [
                  SizedBox(width: 20,),
                  Text("Select Your assignment",
                      style: TextStyle(
                          color: text_color,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              isExpanded: true,

              /// icon: SizedBox.shrink(),
              buttonPadding: const EdgeInsets.only(left: 0, right: 14),

              items: submitAssignmentPageController.data.map((list) {
                return DropdownMenuItem(

                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      const SizedBox(width: 20,),
                      Expanded(child: Text(
                          list["assignment_url"].toString(),
                          textAlign: TextAlign.left,
                          style:  TextStyle(
                              color: text_color,

                              //color: intello_text_color,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),),


                      const SizedBox(width: 20,),

                    ],
                  ),

                  // Text(list["country_name"].toString()),
                  value: list["assignment_id"].toString(),
                );

              },
              ).toList(),
              onChanged: (String? value) {

               String data= submitAssignmentPageController.selectAssignmentId(value.toString());
               // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
              },

            ),)
            )
          ],
        )
    );
  }

  Widget _buildSubmitAssignmentButton() {
    return ElevatedButton(
      onPressed: () {
        String submitAssignmentLinkTxt = submitAssignmentPageController.assignmentLinkController.value.text;
        if (_inputValid(assignmentUrlText: submitAssignmentLinkTxt,
            selectedValueId: submitAssignmentPageController.selectAssignmentId.value) == false) {

          submitAssignmentPageController.submitAssignment(
              submitUrl: submitAssignmentLinkTxt,
              topicId: submitAssignmentPageController.selectAssignmentId.value,
              studentId:submitAssignmentPageController.hw_studentId.value
          );
        }




      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [awsStartColor,awsEndColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Container(

          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Submit Assignment",
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


  Widget _buildSubmitAssignmentUrlTextField({
    String? hintText,
    String? labelText,
  }) {
    return TextFormField(
      controller: submitAssignmentPageController.assignmentLinkController.value,
      minLines: 3,
      maxLines: 6,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: 'Submit Assignment Url',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
    );
  }


  _inputValid({required String assignmentUrlText,required String selectedValueId}) {
    if (selectedValueId.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Please select assignment topic!");
      return;
    }
    if (assignmentUrlText.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Assignment link can't empty!");
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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator(
                          backgroundColor: awsEndColor,
                          color: awsStartColor,
                          strokeWidth: 5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Checking...",
                          style: TextStyle(fontSize: 20,color:awsMixedColor),
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


}
