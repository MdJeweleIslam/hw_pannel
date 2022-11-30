
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Colors.dart';
import '../controller/user_profile_Edit_page_cintroller.dart';
import '../gradiant_icon.dart';
import 'background.dart';

class ProfileUpdateScreen extends StatelessWidget {
  final userProfileEditPageController = Get.put(UserProfileEditPageController());
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
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: awsEndColor
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(height: 0.3,
                      color: Colors.white,
                    ),

                    Expanded(child: SingleChildScrollView(

                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 30,),


                                CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: awsStartColor,
                                    backgroundImage: AssetImage('assets/images/person_male.png'),
                                    // backgroundImage: AssetImage('assets/images/profile.jpg'),
                                    radius: 44.5,
                                  ),
                                ),


                                const SizedBox(
                                  height: 20,
                                ),



                                _buildUserInformationSection(),


                                Container(
                                  margin: EdgeInsets.only(left: 10,right: 10,top: 30),
                                  child:  _buildUpdateButton(),),

                                const SizedBox(
                                  height: 20,
                                ),


                              ],
                            ),
                          )
                        ],
                      ),)),





                  ],
                )

              ],
            )



        ),
      ),
    );


  }

  Widget _buildUserInformationSection() {
    return Container(

      child: Column(
        children: [

          _buildTextFieldUserName(
            // hintText: 'Phone Number',
            obscureText: false,
            prefixedIcon:  GradientIcon(
              Icons.person,
              26,
              LinearGradient(
                colors: <Color>[
                  awsStartColor,
                  awsStartColor,
                  awsEndColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // prefixedIcon: const Icon(Icons.phone, color: Colors.appRed),
            labelText: "Full Name",
            editableEnabled: true,
            controller: userProfileEditPageController.userNameController.value,

          ),
          userInputSelectTopic(),
          SizedBox(height: 20,),


          _buildTextFieldUser(
            // hintText: 'Phone Number',
            obscureText: false,
            prefixedIcon:  GradientIcon(
              Icons.person,
              26,
              LinearGradient(
                colors: <Color>[
                  awsStartColor,
                  awsStartColor,
                  awsEndColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // prefixedIcon: const Icon(Icons.phone, color: Colors.appRed),
            labelText: "Phone Number",
            editableEnabled: false,
            controller: userProfileEditPageController.userPhoneController.value,

          ),
          SizedBox(height: 25,),
          _buildTextFieldUser(
            // hintText: 'Phone Number',
            obscureText: false,
            prefixedIcon:  GradientIcon(
              Icons.person,
              26,
              LinearGradient(
                colors: <Color>[
                  awsStartColor,
                  awsStartColor,
                  awsEndColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // prefixedIcon: const Icon(Icons.phone, color: Colors.appRed),
            labelText: "FB Profile URL",
            editableEnabled: false,
            controller: userProfileEditPageController.userFbUrlController.value,
          ),
        ],
      ),
    );
  }

  Widget userInputSelectTopic() {
    return Container(
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 00,right: 00,top: 20,bottom: 10,),
        decoration: BoxDecoration(
            color:Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(child: Obx(() =>
                DropdownButton2(
                  //   menuMaxHeight:55,
                  value: userProfileEditPageController.selectGenderId.value != null &&
                      userProfileEditPageController.selectGenderId.value.isNotEmpty ?
                  userProfileEditPageController.selectGenderId.value : null,
                  underline:const SizedBox.shrink(),
                  hint:Row(
                    children: const [
                      SizedBox(width: 20,),
                      Text("Select Gender",
                          style: TextStyle(
                              color: text_color,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                  isExpanded: true,

                  /// icon: SizedBox.shrink(),
                  buttonPadding: const EdgeInsets.only(left: 0, right: 14),

                  items: userProfileEditPageController.data.map((list) {
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
                      value: list["selectGenderId"].toString(),
                    );

                  },
                  ).toList(),
                  onChanged: (String? value) {

                    String data= userProfileEditPageController.selectGenderId(value.toString());
                    // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
                  },

                ),)
            )
          ],
        )
    );
  }

  //user name input field create
  Widget _buildTextFieldUserName({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
    required bool? editableEnabled,
    required TextEditingController controller,
  }){
    return Container(

      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          userProfileEditPageController.userNameLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextFormField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,
          enabled: editableEnabled,

          //focusNode: phoneFocusNode,
          controller: controller,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(18),
            // prefixIcon: prefixedIcon,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:awsEndColor, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:awsStartColor, width: .2),
            ),
            labelStyle: TextStyle(
              color:userProfileEditPageController.userNameLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),
          ),
          keyboardType: TextInputType.text,

        ),
      ),
    );
  }

  Widget _buildTextFieldUser({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
    required bool? editableEnabled,
    required TextEditingController controller,

  }){
    return Container(

      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
       //   userProfileEditPageController.userNameLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextFormField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,
          enabled: editableEnabled,

          //focusNode: phoneFocusNode,
          controller: controller,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(18),
            // prefixIcon: prefixedIcon,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:awsEndColor, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:awsStartColor, width: .2),
            ),
            labelStyle: TextStyle(
              color:userProfileEditPageController.userNameLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),
          ),
          keyboardType: TextInputType.text,

        ),
      ),
    );
  }


  Widget _buildUpdateButton() {
    return ElevatedButton(
      onPressed: () {

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
            "Submit",
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


}
