import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:flutter/material.dart';

import '../../../controllers/signUp_controller.dart';
import '../../../model/UserModel.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpFormWidget extends StatefulWidget{
  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {

  @override
  //The instance to be injected

  final email=TextEditingController();
  final password=TextEditingController();
  final fullName=TextEditingController();
  final phoneNo=TextEditingController();


  final _formKey=GlobalKey<FormState>();
  UserController userController=UserController();


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
                        controller:fullName,
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

                          controller:email,
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
                          controller: phoneNo,
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

                          controller:password,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Password"),
                              prefixIcon: Icon(Icons.fingerprint)

                          ),)),

                    Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          height: 45.h,
                          width: 300.w,
                          child: ElevatedButton(onPressed: () async {
                            Get.offAll(()=>Category());
                            if (_formKey.currentState!.validate()) {

                              UserModel userModel=UserModel();

                              userModel.email=email.text;
                              userModel.email=password.text;

                              bool isData=await userController.handleSignup(userModel);

                              if(isData){


                              }



                            }
                          }, child: Text("SignUp", style: TextStyle(color: Colors
                              .white),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r))
                            ),),
                        )),





                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }}
