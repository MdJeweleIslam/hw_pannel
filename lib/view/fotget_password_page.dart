
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:marquee/marquee.dart';

import '../../../gradiant_icon.dart';
import '../../Colors.dart';
 import '../../controller/forget_password_page_controller.dart';
import 'background.dart';

class ForgetPasswordScreen extends StatelessWidget {

  final forgetPasswordPageController = Get.put(ForgetPasswordPageController());



  late String userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  backGroundColor,
        // backgroundColor: Colors.backGroundColor,
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:Stack(
              children: [
                Background(),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ).copyWith(
                        top: 10,
                        bottom: 60,
                      ),
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
                                  width: 180,
                                  height: 90,
                                )
                              ],
                            ),
                          ),
                          // Image.asset('assets/images/profile.jpg'),
                          const Text(
                            "",
                            style: TextStyle(
                              fontFamily: 'PT-Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          // Image.asset('assets/images/profile.jpg'),

                          Container(
                            height: 50,
                            child:  Column(
                                children: [
                                  Expanded(
                                      child: Marquee(
                                        text: 'Working for Application upgrade. Sorry for the inconvenience!',
                                        style: TextStyle(fontWeight: FontWeight.w400, fontSize:20),
                                        scrollAxis: Axis.horizontal, //scroll direction
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        blankSpace: MediaQuery.of(context).size.width,
                                        velocity: 50.0, //speed
                                        pauseAfterRound: Duration(seconds: 1),
                                        startPadding: 10.0,
                                        accelerationDuration: Duration(seconds: 1),
                                        accelerationCurve: Curves.linear,
                                        decelerationDuration: Duration(milliseconds: 1000),
                                        decelerationCurve: Curves.easeOut,
                                      )
                                  )
                                ],
                          ),),

                          const SizedBox(
                            height: 60,
                          ),
                          _buildTextFieldEmail(
                            // hintText: 'Phone Number',
                            obscureText: false,
                            prefixedIcon:  GradientIcon(
                              Icons.email,
                              24,
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

                            labelText: "Email",
                          ),

                          const SizedBox(
                            height: 40,
                          ),

                          _buildNextButton(),
                          const SizedBox(
                            height: 20,
                          ),

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



        ),
      ),
    );


  }


  Widget _buildTextFieldEmail({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color: transparent,
      child: TextField(
        controller: forgetPasswordPageController.emailController.value,
        cursorColor: awsCursorColor,
        cursorWidth: 1.5,
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: prefixedIcon,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:awsEndColor, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: awsStartColor, width: .2),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: hint_color,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color:hint_color,
            fontWeight: FontWeight.normal,
            fontFamily: 'PTSans',
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }



  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        String emailTxt = forgetPasswordPageController.emailController.value.text;
        if (_inputValid(emailTxt) == false) {

          _sendEmailForOtp(emailTxt);
        } else {}


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
            "Next",
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
  _sendEmailForOtp(String email) async {
    // try {
    //   final result = await InternetAddress.lookup('example.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     _showLoadingDialog(context);
    //     try {
    //       Response response = await post(
    //           Uri.parse('$BASE_URL_API$SUB_URL_API_FORGRT_PASSWORD'),
    //           body: {
    //             'email': email,
    //           });
    //       Navigator.of(context).pop();
    //       if (response.statusCode == 200) {
    //         setState(() {
    //          // _showToast("success");
    //           var data = jsonDecode(response.body.toString());
    //           userId = data['data']["user_id"].toString();
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) =>
    //                       VerificationResetPasswordScreen(userId)));
    //         });
    //       } else if (response.statusCode == 401) {
    //         var data = jsonDecode(response.body.toString());
    //         _showToast(data['message']);
    //       } else {
    //         var data = jsonDecode(response.body.toString());
    //         //print(data['message']);
    //         _showToast(data['message']);
    //       }
    //     } catch (e) {
    //       Navigator.of(context).pop();
    //       print(e.toString());
    //     }
    //   }
    // } on SocketException catch (_) {
    //   Fluttertoast.cancel();
    //   _showToast("No Internet Connection!");
    // }
  }


  _inputValid(String email) {
    if (email.isEmpty) {
      Fluttertoast.cancel();
      _showToast("E-mail can't empty");
      return;
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      Fluttertoast.cancel();
      _showToast("Enter valid email");
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
