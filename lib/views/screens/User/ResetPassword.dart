import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:flutter/material.dart';

import '../../../controllers/signUp_controller.dart';
import '../../../model/UserModel.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordView extends StatefulWidget{
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView > {

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
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Form(

            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(top: 10.h,),

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left:30.0.w),
                      child: Text("Reset Password", style: TextStyle(color: Colors
                          .black,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                    ),




//----------------------------------------------------Update your Email----------------------------//









                    //-------------------------------Update Your Password----------------------------------------//


                    Padding(
                      padding: EdgeInsets.only(left:30.0.w,top: 20.h),
                      child: Text("Password", style: TextStyle(color: Colors
                          .black,fontSize: 14.sp),),
                    ),

                    Container(
                      height: 45.h,
                      width: 300.w,
                      margin: EdgeInsets.only(top: 5.h,left: 30.w),
                      child: TextFormField(
                        controller:fullName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.person_2_outlined)
                        ),

                      ),
                    ),
                    Container(
                      height: 45.h,
                      width: 300.w,
                      margin: EdgeInsets.only(top: 5.h,left: 30.w),
                      child: TextFormField(
                        controller:fullName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("New Paaword"),
                            prefixIcon: Icon(Icons.person_2_outlined)
                        ),

                      ),
                    ),




                    Container(
                      margin: EdgeInsets.only(top: 20.h,left: 210.w),
                      height: 35.h,
                      width: 120.w,
                      child: ElevatedButton(onPressed:
                          () async {
                        Get.offAll(()=>Category());
                        if (_formKey.currentState.validate()) {





                        }
                      },

                        child: Text("Reset Password", style: TextStyle(color: Colors
                          .white,fontSize: 12.sp),),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r))
                        ),),
                    ),




                    //--------------------------------------------------------------------------------------//







                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }}
