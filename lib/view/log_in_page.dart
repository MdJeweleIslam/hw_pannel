import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Colors.dart';
import '../../api_service/api_service.dart';
import '../../api_service/login_api_service.dart';
import '../../api_service/sharePreferenceDataSaveName.dart';
import '../../controller/create_mcg_question_controller.dart';
import '../../controller/log_in_page_controller.dart';
 import 'fotget_password_page.dart';
import '../../gradiant_icon.dart';





class LogInScreen extends StatelessWidget {

  final logInPageController = Get.put(LogInPageController());



 // TextEditingController? userNameController = TextEditingController();
 // TextEditingController? passwordController = TextEditingController();
 //  bool _isObscure = true;

 // late FocusNode phoneFocusNode;
 // Color _userNameLevelTextColor = hint_color;
 // Color _passwordLevelTextColor = hint_color;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.backGroundColor,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
             // Background(),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 20),

                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 40,
                    // ).copyWith(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/aws.png",
                                width: 160,
                                height: 80,
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 40,
                        ),



                        //phone number input
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
                          labelText: "User Name",

                        ),
                        const SizedBox(
                          height: 25,
                        ),



                        //password input
                        _buildTextFieldPassword(
                          // hintText: 'Password',
                          obscureText: true,
                          prefixedIcon:
                          GradientIcon(
                            Icons.lock,
                            26,
                            const LinearGradient(
                              colors: <Color>[
                                awsStartColor,
                                awsStartColor,
                                awsEndColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          )
                          ,
                          labelText: "Password",
                        ),

                        const SizedBox(
                          height: 45,
                        ),
                        _buildLoginButton(),
                        const SizedBox(
                          height: 25,
                        ),

                        InkWell(
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontFamily: 'PT-Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color:awsMixedColor,
                            ),
                          ),
                          onTap: () {
                            Get.to(ForgetPasswordScreen());
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ForgetPasswordScreen()));
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        _buildSignUpQuestion(),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )

            ],
          )

          ,
        ),
      ),
    );
  }
  final Uri _url = Uri.parse('https://www.arenawebsecurity.net/');



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
      _showToast("resumed");
    }
  }


  //user name input field create
  Widget _buildTextFieldUserName({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          logInPageController.userNameLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextFormField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
         // maxLength: 13,
          // autofocus: false,

          //focusNode: phoneFocusNode,
          controller: logInPageController.userNameController.value,
        //  textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            prefixIcon: prefixedIcon,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:awsEndColor, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:awsStartColor, width: .2),
            ),
            labelStyle: TextStyle(
              color:logInPageController.userNameLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),
          ),
          keyboardType: TextInputType.text,
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
          //   LengthLimitingTextInputFormatter(
          //     13,
          //   ),
          // ],
        ),
      ),
    );
  }


//password input field create
  Widget _buildTextFieldPassword({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Material(
    color:transparent,
    child:

    Focus(
      onFocusChange: (hasFocus) {
     logInPageController.passwordLevelTextColor.value = hasFocus ? hint_color : hint_color;
    },
    child:  TextField(
          controller: logInPageController.passwordController.value,
          cursorColor:awsCursorColor,
          cursorWidth: 1.5,

          obscureText: logInPageController.isObscure.value,
          // obscuringCharacter: "*",
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            // border: InputBorder.none,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            // labelText: 'Password',
            contentPadding: const EdgeInsets.all(15),
            suffixIcon: IconButton(
                color: awsColor,
                icon: GradientIcon(
                  logInPageController.isObscure.value ? Icons.visibility_off : Icons.visibility,
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
                  logInPageController.updateIsObscure(!logInPageController.isObscure.value);
                }),

            filled: true,
            fillColor: Colors.white,
            prefixIcon: prefixedIcon,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.hint_color,
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
              color: logInPageController.passwordLevelTextColor.value,
            ),
          ),
        ),
    )

    );
  }

  //join now url page redirect
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  //login button create
  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () {

          String userNameTxt = logInPageController.userNameController.value.text;
          String passwordTxt = logInPageController.passwordController.value.text;
          if (_inputValid(userNameTxt, passwordTxt)== false) {


            LogInApiService().userLogIn(userName: userNameTxt, password: passwordTxt);

          }


        },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [awsStartColor,awsEndColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Container(

          height: 50,
          alignment: Alignment.center,
          child:  const Text(
            "Login",
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

  //join now asking
  Widget _buildSignUpQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Expanded(child: RichText(
        //   text: TextSpan(
        //     text: "Don't have an account with ",
        //     style: DefaultTextStyle.of(context).style,
        //     children:  <TextSpan>[
        //       TextSpan(text: 'Arena Web Security', style: TextStyle(fontWeight: FontWeight.bold)),
        //       TextSpan(text: ' yet?'),
        //
        //
        //     ],
        //   ),
        // ),),

        const Text(
          "Don't have an Account? ",
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        InkWell(
          child: const Text(
            'Join Now',
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:awsMixedColor,
            ),
          ),
          onTap: () {
            _launchUrl();
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ChooseRoleScreen()));
          },
        ),
      ],
    );
  }

  //input text validation check
  _inputValid(String userName, String password) {
    if (userName.isEmpty) {
      Fluttertoast.cancel();
      _showToast("User name can't empty");
      return;
    }

    if (password.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Password can't empty");
      return;
    }
    if (password.length < 8) {
      Fluttertoast.cancel();
      _showToast("Password can't smaller than 8 digit");
      return;
    }

    return false;
  }


  // //login api call
  // _userLogIn({
  //   required String userName,
  //   required String password,
  // }) async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       showLoadingDialog(context, "Checking...");
  //       try {
  //         Response response =
  //         await post(Uri.parse('$BASE_URL_API$SUB_URL_API_LOG_IN'), body: {
  //           'username': userName,
  //           'password': password,
  //         });
  //         Navigator.of(context).pop();
  //         // _showToast(response.statusCode.toString());
  //
  //         if (response.statusCode == 200) {
  //           _showToast("success");
  //            var data = jsonDecode(response.body);
  //           //
  //           saveUserInfo(data);
  //
  //          // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const ExamPageScreen()));
  //
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               builder: (BuildContext context) =>
  //                  ExamPageScreen(),
  //             ),
  //                 (route) => false,
  //           );
  //
  //
  //         }
  //
  //         else if (response.statusCode == 403) {
  //           setState(() {
  //             //_showToast("success");
  //             var data = jsonDecode(response.body);
  //             _showToast(data['msg']);
  //
  //           });
  //         }
  //         else {
  //           var data = jsonDecode(response.body);
  //           _showToast(data['message']);
  //         }
  //       } catch (e) {
  //         Navigator.of(context).pop();
  //         //print(e.toString());
  //       }
  //     }
  //   } on SocketException catch (_) {
  //     Fluttertoast.cancel();
  //     _showToast("No Internet Connection!");
  //   }
  // }

  //save data with share pref
  void saveUserInfo(var userInfo) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

      sharedPreferences.setString(pref_user_name, userInfo['data']['username'].toString());
      sharedPreferences.setString(pref_full_name, userInfo['data']['fullname'].toString());
      sharedPreferences.setString(pref_user_batch, userInfo['data']['batch'].toString());
      sharedPreferences.setString(pref_user_type, userInfo['data']['user_type'].toString());
      sharedPreferences.setString(pref_user_id, userInfo['data']['user_id'].toString());



    } catch (e) {

      //code


    }


    // sharedPreferences.setString(pref_user_UUID, userInfo['data']["user_name"].toString());
    // sharedPreferences.setBool(pref_login_firstTime, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_cartID, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_county, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_city, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_state, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_nid, userInfo['data']["user_name"].toString());
    // sharedPreferences.setString(pref_user_nid, userInfo['data']["user_name"].toString());


  }

  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  //loading dialog crete
  void showLoadingDialog(BuildContext context, String message) {
    showDialog(
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
                        const SizedBox(
                          width: 10,
                        ),
                        const CircularProgressIndicator(
                          backgroundColor: awsStartColor,
                          color: awsEndColor,
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


}


