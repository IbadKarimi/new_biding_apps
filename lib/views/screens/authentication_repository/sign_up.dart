import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../controllers/user_controller.dart';
import '../../../model/UserModel.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpFormWidget extends StatefulWidget{
  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {

  bool _isLoading = false;


  @override
  final UserController userController = UserController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final _formKey=GlobalKey<FormState>();


  void _handleSignup(BuildContext context) async {

    setState(() {
      _isLoading = true; // Set loading state to true when login starts
    });

    String email = emailController.text.trim();
    String password = _passwordController.text.trim();
    String fullName = fullNameController.text.trim();
    String phoneNo = phoneNoController.text.trim();

    try {
      UserModel user = UserModel(email: email,
          password: password,
          fullName: fullName,
          phoneNo: phoneNo);
          User firebaseUser = await userController.InsertSignUp(user);
          Get.offAll(()=>HomePageView());
    }
    catch (e) {
      // Handle login error, e.g., show error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('SignUp failed. $e'),
      ));
    }
    finally {
      setState(() {
        _isLoading = false; // Set loading state to false after login attempt (success or failure)
      });
    }
  }








  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Form(

            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(top: 100.h,),

              child: Column(

                  children: [
                    Container
                      (width: 160.w,
                      height: 160.h,
                      child: Image.asset(
                          "lib/utils/images/BidPic.png"),),
                    Container(
                      height: 45.h,
                      width: 300.w,
                      margin: EdgeInsets.only(top: 30.h),
                      child: TextFormField(
                        controller:fullNameController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Full Name"),
                            prefixIcon: Icon(Icons.person_2_outlined)
                        ),

                      ),
                    ),

                    SizedBox(height: 10.h),

                    Container(
                      height: 45.h,
                      width: 300.w,
                      child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller:emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Email"),
                              prefixIcon: Icon(Icons.email_rounded)
                          )),),
                    SizedBox(height: 10.h),
                    Container(
                        height: 45.h,
                        width: 300.w,
                        child: TextFormField(
                          controller: phoneNoController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Phone No"),
                              prefixIcon: Icon(Icons.phone)

                          ),)),


                    SizedBox(height: 10.h),

                    Container(
                        height: 45.h,
                        width: 300.w,
                        child: TextFormField(

                          controller:_passwordController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Password"),
                              prefixIcon: Icon(Icons.fingerprint)

                          ),)),

                    Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          height: 45.h,
                          width: 250.w,
                          child: ElevatedButton(
                            onPressed: () => _handleSignup(context),
                            child: Text("SignUp", style: TextStyle(color: Colors
                                .white),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r))
                            ),),
                        )),


                    Center(
                      child: _isLoading
                          ? Padding(
                            padding: const EdgeInsets.only(top:10),
                            child: CircularProgressIndicator(),
                          ) // Show CircularProgressIndicator when loading
                          :Container(),)


                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }}
