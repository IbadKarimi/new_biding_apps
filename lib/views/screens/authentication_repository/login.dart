
import 'package:biding_app/views/screens/authentication_repository/sign_up.dart';
import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
bool isVisible=false;

class LoginFormWidget extends StatefulWidget{
  @override
  State<LoginFormWidget > createState() => _LoginFormWidget ();
}

class _LoginFormWidget  extends State<LoginFormWidget > {
  @override
  //The instance to be injected


  final _formKey=GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();



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
                      controller: email,

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

                        controller: password,
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
                          child:ElevatedButton(onPressed: (){


                            if(_formKey.currentState.validate()){
                             Get.offAll(()=>Category());

                            }

                          }, child:  Text("Login"),
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






       ] )

                ]
            ),

          ),
        ),
      ),
    );
  }}






