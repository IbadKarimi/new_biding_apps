import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:flutter/material.dart';

import '../../../controllers/user_controller.dart';
import '../../../model/UserModel.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileView extends StatefulWidget{
  @override
  State<EditProfileView > createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView > {

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
                      child: Text("Edit Your Profile", style: TextStyle(color: Colors
                          .black,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                    ),


                    Padding(
                      padding: EdgeInsets.only(left:30.0.w,top: 20.h),
                      child: Text("Update Your Name", style: TextStyle(color: Colors
                          .black,fontSize: 14.sp),),
                    ),

                    Container(
                      height: 45.h,
                      width: 300.w,
                      margin: EdgeInsets.only(top: 5.h,left: 30.w),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller:fullName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Full Name"),
                            prefixIcon: Icon(Icons.person_2_outlined)
                        ),

                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20.h,left: 230.w),
                      height: 35.h,
                      width: 100.w,
                      child: ElevatedButton(onPressed:
                          () async {
                        Get.offAll(()=>Category());
                        if (_formKey.currentState.validate()) {

                          try{
                            userController.updateName(fullName.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Name updated successfully!',style:TextStyle(color: Colors.black),),
                              ),
                            );
                          }catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString(),style: TextStyle(color: Colors.black),),
                              ),
                            );

                          }





                        }
                      }, child: Text("Update", style: TextStyle(color: Colors
                          .white),),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r))
                        ),),
                    ),

//----------------------------------------------------Update your Email----------------------------//


                    Divider(),

                    Padding(
                      padding: EdgeInsets.only(left:30.0.w,top: 20.h),
                      child: Text("Update Your Email", style: TextStyle(color: Colors
                          .black,fontSize: 14.sp),),
                    ),

                    Container(
                      height: 45.h,
                      width: 300.w,
                      margin: EdgeInsets.only(top: 5.h,left: 30.w),
                      child: TextFormField(
                        controller:email,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Email"),
                            prefixIcon: Icon(Icons.person_2_outlined)
                        ),

                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20.h,left: 230.w),
                      height: 35.h,
                      width: 100.w,
                      child: ElevatedButton(onPressed:
                          () async {

                        if (_formKey.currentState.validate()) {


                      try {
                        userController.updateEmail(email.text);
                        SnackBar(
                          content: Text('Email updated successfully!',style:TextStyle(color: Colors.black),),
                        );
                      }catch(e){
                        SnackBar(
                          content: Text(e.toString(),style:TextStyle(color: Colors.black),),
                        );
                      }


                        }
                      }, child: Text("Update", style: TextStyle(color: Colors
                          .white),),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r))
                        ),),
                    ),




                  //-------------------------------Update Your Password----------------------------------------//

                   Divider(),
                    Padding(
                      padding: EdgeInsets.only(left:30.0.w,top: 20.h),
                      child: Text("Update Your Password", style: TextStyle(color: Colors
                          .black,fontSize: 14.sp),),
                    ),

                    Container(
                      height: 45.h,
                      width: 300.w,
                      margin: EdgeInsets.only(top: 5.h,left: 30.w),
                      child: TextFormField(
                        controller:fullName,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Old Paaword"),
                            prefixIcon: Icon(Icons.person_2_outlined)
                        ),

                      ),
                    ),
                    Container(
                      height: 45.h,
                      width: 300.w,
                      margin: EdgeInsets.only(top: 5.h,left: 30.w),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller:fullName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("New Paaword"),
                            prefixIcon: Icon(Icons.person_2_outlined)
                        ),

                      ),
                    ),
                    Container(
                      height: 45.h,
                      width: 300.w,
                      margin: EdgeInsets.only(top: 5.h,left: 30.w),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller:fullName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Confirm Paaword"),
                            prefixIcon: Icon(Icons.person_2_outlined)
                        ),

                      ),
                    ),



                    Container(
                      margin: EdgeInsets.only(top: 20.h,left: 230.w),
                      height: 35.h,
                      width: 100.w,
                      child: ElevatedButton(onPressed:
                          () async {
                        Get.offAll(()=>Category());
                        if (_formKey.currentState.validate()) {

                         // UserModel userModel=UserModel();

                   /*       userModel.email=email.text;
                          userModel.email=password.text;

                          bool isData=await userController.handleSignup(userModel);

                          if(isData){


                          }*/



                        }
                      }, child: Text("Update", style: TextStyle(color: Colors
                          .white),),
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
