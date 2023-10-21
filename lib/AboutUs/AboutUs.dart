


import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomAppBar(),
     drawer: CustomDrawer(),
     bottomNavigationBar: CustomBottomNavigationBar(),
     body:Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: EdgeInsets.only(left:20.w,top:20.h),
           child: Text("About Us",style: TextStyle(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w600),),
         ),

         Padding(
           padding: EdgeInsets.only(left:20.w,top:20.h),
           child: Text(
'''Biding Sale System is your trusted partner for all your auction needs. Whether you're buying or selling
we provide a seamless and secure platform for your bidding experience.''',
    style: TextStyle(color: Colors.grey,fontSize: 14.sp,fontWeight: FontWeight.w500),),
         ),
         Padding(
           padding: EdgeInsets.only(left:20.w,top:20.h),
           child: Text("Contact Information :",style: TextStyle(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w600),),
         ),

         Row(children: [
           Padding(
             padding: EdgeInsets.only(left:20.w,top:20.h),
             child: Text("Phone No  :",style: TextStyle(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w600),),
           ),
           Padding(
             padding: EdgeInsets.only(left:5.w,top:20.h),
             child: Text("03425949630",style: TextStyle(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w500),),
           ),
         ],),

         Row(children: [
           Padding(
             padding: EdgeInsets.only(left:20.w,top:20.h),
             child: Text("Email :",style: TextStyle(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w600),),
           ),
           Padding(
             padding: EdgeInsets.only(left:5.w,top:20.h),
             child: Text("ibadkarimi.10@gmail.com",style: TextStyle(color: Colors.blue,fontSize: 14.sp,fontWeight: FontWeight.w500),),
           ),
         ],)


       ],)
   );
  }

}