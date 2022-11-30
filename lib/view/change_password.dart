
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Colors.dart';
import '../controller/change_password_page_controller.dart';
import '../gradiant_icon.dart';
import 'background.dart';

class ChangePasswordScreen extends StatelessWidget {
  final changePasswordPageController = Get.put(ChangePasswordPageController());
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
                            "Change Password",
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

                    Expanded(
                        child: Center(
                          child: SingleChildScrollView(


                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 30,right: 30,bottom: 20),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),


                                      Image.asset(
                                        'assets/images/privacy.png',
                                        height: 120,
                                        width: 120,
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      _buildUserInformationSection(),

                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10,top: 30),
                                        child:  _buildChangePasswordButton(),
                                      ),

                                      const SizedBox(
                                        height: 60,
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),),
                        )),

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

          _buildTextFieldPassword(
            obscureText: false,
            labelText: "Old Password",
            controller: changePasswordPageController.oldPasswordController.value,
          ),

          SizedBox(height: 25,),

          _buildNewPassword(
            obscureText: false,
            labelText: "New Password",
            controller: changePasswordPageController.newPasswordController.value,
          ),
          SizedBox(height: 25,),
          _buildNewConfirmPassword(
            obscureText: false,
            labelText: "Confirm Password",
            controller: changePasswordPageController.newConfirmPasswordController.value,
          ),

          SizedBox(height: 25,),

        ],
      ),
    );
  }

  //password input field create
  Widget _buildTextFieldPassword({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
    required TextEditingController controller,
  }) {
    return Material(
        color:transparent,
        child:

        Focus(
          onFocusChange: (hasFocus) {
            changePasswordPageController.passwordLevelTextColor.value = hasFocus ? hint_color1 : hint_color1;
          },
          child:  Obx(() =>


              TextField(
                controller: controller,
                cursorColor:awsCursorColor,
                cursorWidth: 1.5,
                textInputAction: TextInputAction.next,
                focusNode:changePasswordPageController.oldPasswordControllerFocusNode.value,
                onSubmitted:(_){
                  changePasswordPageController.newPasswordControllerFocusNode.value.requestFocus();
                    // context.nextEditableTextFocus()
                },
                obscureText: changePasswordPageController.isObscure.value,
                // obscuringCharacter: "*",
                style: const TextStyle(color: Colors.black, fontSize: 17),
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  // labelText: 'Password',
                  contentPadding: const EdgeInsets.all(18),
                  suffixIcon: IconButton(
                      color: awsColor,
                      icon: GradientIcon(
                        changePasswordPageController.isObscure.value ? Icons.visibility_off : Icons.visibility,
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

                      // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        changePasswordPageController.updateIsObscure(!changePasswordPageController.isObscure.value);
                      }),

                  filled: true,
                  fillColor: Colors.white,

                  prefixIcon: prefixedIcon,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: hint_color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'PTSans',
                  ),

                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color:awsEndColor, width: 1),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color:awsStartColor, width: .2),
                  ),
                  labelText: labelText,
                  labelStyle:  TextStyle(
                    color: changePasswordPageController.passwordLevelTextColor.value,
                  ),
                ),
              )),
        )

    );
  }

  Widget _buildNewPassword({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
    required TextEditingController controller,
  }) {
    return Material(
        color:transparent,
        child:

        Focus(
          onFocusChange: (hasFocus) {
            changePasswordPageController.passwordLevelTextColor.value = hasFocus ? hint_color : hint_color;
          },
          child:  Obx(() =>


              TextField(
                controller: controller,
                cursorColor:awsCursorColor,
                cursorWidth: 1.5,

                obscureText: changePasswordPageController.isObscureNewPassword.value,
                // obscuringCharacter: "*",
                focusNode:changePasswordPageController.newPasswordControllerFocusNode.value,
                onSubmitted:(_){
                  changePasswordPageController.newConfirmPasswordControllerFocusNode.value.requestFocus();
                },
                style: const TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  // labelText: 'Password',
                  contentPadding: const EdgeInsets.all(17),
                  suffixIcon: IconButton(
                      color: awsColor,
                      icon: GradientIcon(
                        changePasswordPageController.isObscureNewPassword.value ? Icons.visibility_off : Icons.visibility,
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

                      // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        changePasswordPageController.updateIsObscureNewPassword(!changePasswordPageController.isObscureNewPassword.value);
                      }),

                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: prefixedIcon,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: hint_color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'PTSans',
                  ),

                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color:awsEndColor, width: 1),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color:awsStartColor, width: .2),
                  ),
                  labelText: labelText,
                  labelStyle:  TextStyle(
                    color: changePasswordPageController.passwordLevelTextColor.value,
                  ),
                ),
              )),
        )

    );
  }

  Widget _buildNewConfirmPassword({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
    required TextEditingController controller,
  }) {
    return Material(
        color:transparent,
        child:

        Focus(
          onFocusChange: (hasFocus) {
            changePasswordPageController.passwordLevelTextColor.value = hasFocus ? hint_color : hint_color;
          },
          child:  Obx(() =>


              TextField(
                controller: controller,
                cursorColor:awsCursorColor,
                cursorWidth: 1.5,

                obscureText: changePasswordPageController.isObscureConfirmNewPassword.value,
                // obscuringCharacter: "*",
                focusNode:changePasswordPageController.newConfirmPasswordControllerFocusNode.value,
                onSubmitted:(_){
                 // changePasswordPageController.newPasswordControllerFocusNode.value.requestFocus();
                },
                style: const TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  // labelText: 'Password',
                  contentPadding: const EdgeInsets.all(17),
                  suffixIcon: IconButton(
                      color: awsColor,
                      icon: GradientIcon(
                        changePasswordPageController.isObscureConfirmNewPassword.value ? Icons.visibility_off : Icons.visibility,
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

                      // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        changePasswordPageController.updateIsObscureConfirmNewPassword(!changePasswordPageController.isObscureConfirmNewPassword.value);
                      }),

                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: prefixedIcon,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: hint_color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'PTSans',
                  ),

                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color:awsEndColor, width: 1),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color:awsStartColor, width: .2),
                  ),
                  labelText: labelText,
                  labelStyle:  TextStyle(
                    color: changePasswordPageController.passwordLevelTextColor.value,
                  ),
                ),
              )),
        )

    );
  }

  Widget _buildChangePasswordButton() {
    return ElevatedButton(
      onPressed: () {

        String oldPasswordTxt = changePasswordPageController.oldPasswordController.value.text;
        String newPasswordTxt = changePasswordPageController.newPasswordController.value.text;
        String confirmPasswordTxt = changePasswordPageController.newConfirmPasswordController.value.text;

        _inputValid(
            oldPassword: oldPasswordTxt,
            newPassword: newPasswordTxt,
            newConfirmPassword: confirmPasswordTxt);
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
            "Change Password",
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

  //input text validation check
  _inputValid({
    required String oldPassword,
    required String newPassword,
    required String newConfirmPassword}) {

    if (oldPassword.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Old password can't empty!");
      return false;
    }

    if (newPassword.isEmpty) {
      Fluttertoast.cancel();
      _showToast("New password can't empty!");
      return false;
    }
    if (newPassword.length < 8) {
      Fluttertoast.cancel();
      _showToast("New password must be 8 digit!");
      return false;
    }

    if (newConfirmPassword.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Confirm password can't empty!");
      return false;
    }
    if (newConfirmPassword.length < 8) {
      Fluttertoast.cancel();
      _showToast("Confirm password must be 8 digit!");
      return false;
    }

    if (newPassword!=newConfirmPassword) {
      Fluttertoast.cancel();
      _showToast("Confirm password do not match!");
      return false;
    }

    return true;
  }


}
