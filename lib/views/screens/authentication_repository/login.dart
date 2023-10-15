
import 'package:biding_app/controllers/user_controller.dart';
import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:biding_app/views/screens/authentication_repository/sign_up.dart';
import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/UserModel.dart';
bool isVisible=false;

class LoginFormWidget extends StatefulWidget{
  @override
  State<LoginFormWidget > createState() => _LoginFormWidget ();
}

 class _LoginFormWidget  extends State<LoginFormWidget >{
  @override
  //The instance to be injected
  bool _isLoading = false;

  final _formKey=GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserController _authController = UserController(); // Create an instance of AuthController

  void _signIn() async {

    setState(() {
      _isLoading = true; // Set loading state to true when login starts
    });

    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      await _authController.signIn(email, password);
      Get.offAll(()=>HomePageView());
      // Handle successful login here, e.g., navigate to the next screen
    } catch (e) {
      // Handle login error, e.g., show error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login failed. $e'),
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
        child: Form(

          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(top:60.h),

            child: Column(

                children: [
                  Container(width: 160.w,height: 160.h,child: Image.asset("lib/utils/images/BidPic.png"),),

                  SizedBox( height:10.h),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, left: 0, bottom: 10.h),
                    child:  Text(
                      "Welcome Back !",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 0, bottom: 10.h),
                      child: Text(
                        "make it work,make it right,make it fast",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )),

                  SizedBox(
                    width: 300.w,
                    height: 45.h,
                    child: TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Colors.black),

                      decoration: InputDecoration(

                        label: Text("Email") ,prefixIcon:Icon(Icons.email_rounded),
                        border: OutlineInputBorder(),
                      ),),
                  ),
                  SizedBox( height:10.h),


                  SizedBox(
                      width: 300.w,
                      height: 45.h,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),

                        controller: passwordController,
                        decoration: InputDecoration(label: Text("Password") ,prefixIcon:Icon(Icons.fingerprint),
                          border: OutlineInputBorder(),

                        ),)),
                  Stack(
                    alignment:AlignmentDirectional.topStart ,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.offAll(()=>SignUpFormWidget());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h, left: 280.w, bottom: 0),
                          child:  Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:7.h),
                        child: Center(child:isVisible==true? CircularProgressIndicator():Container()),
                      ),
                      Center(
                        child:   Container(
                          margin: EdgeInsets.only(top:60.h,bottom: 20.h),
                          width: 250.w,
                          height: 45.h,
                          child:ElevatedButton(onPressed:_signIn,





                           child:  Text("Login"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape:
                                RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black, width: 1.w),
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      5.0.r),
                                ),
                              )),),
                      ),






       ] ),
            Center(
                child: _isLoading
                    ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                    :Container(),)
                ]
            ),

          ),
        ),
      )
    );
  }}






