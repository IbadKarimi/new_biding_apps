

import 'package:biding_app/model/VehicleModel.dart';
import 'package:biding_app/views/screens/Admin/AddAgriculture.dart';
import 'package:biding_app/views/screens/Aggriculture/AggricultureView.dart';
import 'package:biding_app/views/screens/Furniture/FurnitureView.dart';
import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:biding_app/views/screens/RealState/RealStateView.dart';
import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:biding_app/views/screens/authentication_repository/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Vehicle/VehiclesView.dart';


class Category extends StatefulWidget{
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:CustomAppBar(),
     drawer:CustomDrawer(),

     body: SingleChildScrollView(
       scrollDirection: Axis.vertical,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,


children: [
Row(


  children: [

  Column(

        children: [
          GestureDetector(
            onTap: (){
              Get.to(()=>HomePageView());
            },
            child: Container(
              width: 150.w,
              height:200.h,

              margin: EdgeInsets.only(left:25.w,top:60.h),

              decoration: BoxDecoration(
                  color: Color(0xFFFFFDB58),
                  borderRadius: BorderRadius.circular(15.r)
              ),
              child:Icon(Icons.home,size: 80.r,)
),
          ),
          Text("Home",style: TextStyle(fontSize: 18.sp,color:Colors.black,fontWeight: FontWeight.w600),)
        ],
  ),

  Column(
        children: [
          GestureDetector(
            onTap: (){  Get.to(()=>RealStateView());},
            child: Container(
                width: 150.w,
                height:200.h,
                margin: EdgeInsets.only(left:10.w,top:60.h),

                decoration: BoxDecoration(
                    color: Color(0xFFFFFDB58),
                    borderRadius: BorderRadius.circular(10.r)
                ),
                child:Icon(Icons.real_estate_agent,size: 80.r,)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:10.w),
            child: Text("Real State",selectionColor:Colors.black,style: TextStyle(fontSize: 18.sp,color:Colors.black,fontWeight: FontWeight.w600),),
          )
        ],
  ),


],),
  Row(children: [


        Column(
          children: [
            GestureDetector(
              onTap: (){  Get.to(()=>AgricultureView());},
              child: Container(
                  width: 150.w,
                  height:200.h,
                  margin: EdgeInsets.only(left:25.w,top:30.h),

                  decoration: BoxDecoration(
                      color: Color(0xFFFFFDB58),
                      borderRadius: BorderRadius.circular(10.r)
                  ),
                  child:Icon(Icons.agriculture,size: 80.r,)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:15.w),
              child: Text("Agriculture",style: TextStyle(fontSize: 18.sp,color:Colors.black,fontWeight: FontWeight.w600),),
            )
          ],
        ),
        Column(

          children: [
            GestureDetector(
              onTap: (){  Get.to(()=>FurnitureView());},
              child: Container(
                  width: 150.w,
                  height:200.h,
                  margin: EdgeInsets.only(left:10.w,top:30.h),

                  decoration: BoxDecoration(
                      color: Color(0xFFFFFDB58),
                      borderRadius: BorderRadius.circular(10.r)
                  ),
                  child:Icon(Icons.table_restaurant_sharp,size: 80.r,)
              ),
            ), Padding(
              padding:  EdgeInsets.only(left:10.w),
              child: Text("Furniture",style: TextStyle(fontSize: 18.sp,color:Colors.black,fontWeight: FontWeight.w600),),
            )
          ],
        )

  ],),
  Column(
    mainAxisAlignment: MainAxisAlignment.start,

    children: [
      GestureDetector(
        onTap: (){
          Get.to(()=>VehicleView());
        },
        child: Container(
            width: 150.w,
            height:200.h,

            margin: EdgeInsets.only(left:25.w,top:60.h),

            decoration: BoxDecoration(
                color: Color(0xFFFFFDB58),
                borderRadius: BorderRadius.circular(15.r)
            ),
            child:Icon(Icons.car_rental,size: 80.r,)
        ),
      ),
      Text("Vehicle",style: TextStyle(fontSize: 18.sp,color:Colors.black,fontWeight: FontWeight.w600),)
    ],
  ),

],),
     ),
   );
  }}



