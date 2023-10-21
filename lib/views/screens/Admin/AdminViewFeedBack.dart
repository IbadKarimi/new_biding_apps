

import 'package:flutter/material.dart';



import 'package:biding_app/controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/user_controller.dart';
import '../../../model/HomePageModel.dart';
import '../../../model/UserModel.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';


class AdminFeedBackView extends StatefulWidget{
  @override
  State<AdminFeedBackView> createState() => _AdminFeedBackView();
}

class _AdminFeedBackView extends State<AdminFeedBackView> {
  UserController userController=UserController();

  List<UserModel> feeedBack=[];

  void initState() {


    userController.getFeedBack().then((value) {
      setState(() {
        feeedBack.addAll(value);
      });
    });

  }

  @override


  TextEditingController offer=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 30.w, bottom: 0.h),
                  child:  Text(
                    "Feed Backs ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),


                ////////////looof starts here//
                for(int i=0;i<feeedBack.length;i++)

                  Container(
                    margin: EdgeInsets.only(left:30.w,top:20.h),
                    alignment: AlignmentDirectional.center,
                    width:300.w,

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(0.r),
                        border: Border.all(color: Colors.black,width: 1)
                    ),

                    child:Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [





                        Column(
                          mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.h, left: 30.w, bottom: 0.h),
                              child:  Text(
                                "Email ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 30.h, bottom: 0.h),
                              child:  Text(
                                feeedBack[i].email,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                              child:  Text(
                                "Feed Backs ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              width: 180,

                              child: Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 30.w),
                                child:  Text(
                                  feeedBack[i].feedBack,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),

                      ],
                    ),






                  )]),
        ));}}