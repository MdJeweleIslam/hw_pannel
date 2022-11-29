
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hw_pannel/view/log_in_page.dart';
import 'package:hw_pannel/view/submit_assignment.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../Colors.dart';
import '../controller/exam_page_controller.dart';
import '../controller/exam_start_page_controller.dart';
import '../controller/home_page_controller.dart';
import '../controller/log_in_page_controller.dart';
import '../controller/navigation_drawer_page_controller.dart';

class NavigationDrawerPasswordScreen extends StatelessWidget {
  String name,email;

  NavigationDrawerPasswordScreen(this.name,this.email);

  final navigationDrawerPageController = Get.put(NavigationDrawerPageController());
  late String userId;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            _buildUserDrawerHeader(),
            Divider(
              color: Colors.grey,
            ),

            _buildDrawerItem(
                text: 'Submit Assignment',
                textIconColor: awsEndColor,
                onTap: () {
                  Get.to(()=> SubmitAssignmentScreen());
                },
                iconLink: 'assets/images/submit_assignment1.png',
                tileColor: Colors.transparent,
            ),

            _buildDrawerItem(
              text: 'Join Class',
              textIconColor: awsEndColor,
              onTap: ()=>navigate(1),
              iconLink: 'assets/images/join_class_icon.png',
              tileColor: Colors.transparent,
            ),

            _buildDrawerItem(
              text: 'My Profile',
              textIconColor: awsEndColor,
              onTap: ()=>navigate(2),
              iconLink: 'assets/images/support_icon.png',
              tileColor: Colors.transparent,
            ),


            _buildDrawerItem(
              text: 'Support Topic',
              textIconColor: awsEndColor,
              onTap: ()=>navigate(2),
              iconLink: 'assets/images/support_icon.png',
              tileColor: Colors.transparent,
            ),

            _buildDrawerItem(
              text: 'Change Password',
              textIconColor: awsEndColor,
              onTap: ()=>navigate(3),
              iconLink: 'assets/images/change_password_icon.png',
              tileColor: Colors.transparent,
            ),

            _buildDrawerItem(
              text: 'Log Out',
              textIconColor: awsEndColor,
              onTap: (){

                Get.delete<LogInPageController>();
                Get.delete<HomePageController>();
                Get.delete<ExamPageController>();
                Get.delete<ExamStartPageController>();


                Get.offAll(()=> LogInScreen());

              },
              iconLink: 'assets/images/log_out_icon.png',
              tileColor: Colors.transparent,
            ),

            Expanded(child: Container(
              alignment: Alignment.bottomCenter,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  Text("Developed by",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),


                  GradientText(
                    "Arena Web Technology",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                    colors: [
                      awsStartColor,
                     // Colors.black.withOpacity(0.1),
                      awsEndColor,
                    ],
                  ),

                  SizedBox(height: 20,)
                ],

              ),
            ))

        ],
        ),
      )

    );


  }

  Widget _buildUserDrawerHeader() {
    return UserAccountsDrawerHeader(
        accountName:Text(
          name,
         // navigationDrawerPageController.userName.value,
          // "Abdullah",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
        accountEmail:Text(
          email,
          // "abdullah272056@gmail.com",
          style: TextStyle(
              color: Colors.white,
              fontSize: 15
          ),
        ),


      currentAccountPicture:
      CircleAvatar(
        radius: 35,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: awsStartColor,
          backgroundImage: AssetImage('assets/images/person_male.png'),
          radius: 34.5,
        ),
      ),

      decoration: BoxDecoration(
        color: awsStartColor,
      ),

      currentAccountPictureSize: Size.square(70),

    );
  }

  Widget _buildDrawerItem({
    required String text,
    required String iconLink,
    required Color textIconColor,
    required Color tileColor,
    required VoidCallback onTap,

  }) {
    return ListTile(
      leading: Image.asset(
        height: 20.0,
        width: 20.0,
        iconLink,
        fit: BoxFit.fill,
        color: awsEndColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: textIconColor,
          fontSize: 15,
        ),),
      tileColor: tileColor,
      onTap: onTap,
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

  navigate(int index){

  }
  
}
