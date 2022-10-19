import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Colors.dart';
import 'exam_page.dart';
import 'gradiant_icon.dart';





class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController? userNameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool _isObscure = true;

  late FocusNode phoneFocusNode;
  Color _userNameLevelTextColor = hint_color;
  Color _passwordLevelTextColor = hint_color;
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ).copyWith(top: 20),
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
                          height: 20,
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
                          height: 40,
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
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
      _showToast("resumed");
    }
  }


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
          setState(() => _userNameLevelTextColor = hasFocus ? hint_color : hint_color);
        },
        child: TextFormField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
         // maxLength: 13,
          // autofocus: false,

          //focusNode: phoneFocusNode,
          controller: userNameController,
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
              color:_userNameLevelTextColor,
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
      setState(() => _passwordLevelTextColor = hasFocus ? hint_color : hint_color);
    },
        child:  TextField(
          controller: passwordController,
          cursorColor:awsCursorColor,
          cursorWidth: 1.5,

          obscureText: _isObscure,
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
                  _isObscure ? Icons.visibility_off : Icons.visibility,
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
                  setState(() {
                    _isObscure = !_isObscure;
                  });
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
              color: _passwordLevelTextColor,
            ),
          ),
        ),

        )

    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () {

          String userNameTxt = userNameController!.text;
          String passwordTxt = passwordController!.text;
          if (_inputValid(userNameTxt, passwordTxt) == false) {
           _logInUser(userNameTxt, passwordTxt);
           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const ExamPageScreen()));


          }else {

          }
          //Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));
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


  _logInUser(String mobile, String password) async {
    // try {
    //   final result = await InternetAddress.lookup('example.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     print('connected');
    //     _showLoadingDialog(context,"Checking...");
    //     try {
    //       Response response = await post(Uri.parse('$BASE_URL_API$SUB_URL_API_SIGN_IN'),
    //           body: {'phone_number': mobile, 'password': password});
    //
    //       if (response.statusCode == 200) {
    //         Navigator.of(context).pop();
    //         setState(() {
    //           var data = jsonDecode(response.body.toString());
    //          saveUserInfo(data);
    //           if(data['data']["is_teacher"]==true){
    //             Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomeForTeacherScreen()));
    //
    //             // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomeForStudentScreen()));
    //           }else{
    //             Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomeForStudentScreen()));
    //
    //           }
    //
    //
    //         });
    //       }
    //       else if (response.statusCode == 201){
    //
    //         var data = jsonDecode(response.body);
    //         _reSendCode( user_id: data['data']["id"].toString());
    //
    //       }
    //       else if (response.statusCode == 400) {
    //         Navigator.of(context).pop();
    //         var data = jsonDecode(response.body.toString());
    //         Fluttertoast.cancel();
    //         //  _showToast(data['message'].toString());
    //         _showToast("phone or password not match!");
    //       }
    //       else {
    //         Navigator.of(context).pop();
    //         var data = jsonDecode(response.body.toString());
    //         Fluttertoast.cancel();
    //         _showToast(data['message'].toString());
    //       }
    //     } catch (e) {
    //       Navigator.of(context).pop();
    //       Fluttertoast.cancel();
    //       print(e.toString());
    //       _showToast("failed");
    //     }
    //   }
    // } on SocketException catch (e) {
    //   Fluttertoast.cancel();
    //   _showToast("No Internet Connection!");
    // }
  }

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





}


