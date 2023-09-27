

import 'package:biding_app/views/screens/authentication_repository/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Category extends StatefulWidget{
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.black,
       title: Text("Bidding Sale System"),
     ),
     drawer: Drawer( child: ListView(
       // Important: Remove any padding from the ListView.
       padding: EdgeInsets.zero,
       children: [
         DrawerHeader(
           decoration: BoxDecoration(
               color: Colors.amberAccent

           ),
           child:   Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               new CircleAvatar(
                 radius: 40.0,
                 backgroundColor: const Color(0xFF778899),
                 child: new Image.asset(
                   'lib/utils/images/construction-min.png',
                 ), //For Image Asset

               ), Padding(
                 padding: const EdgeInsets.only(left:0,top:10),
                 child: Text("Ibad Karimi",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),),
               ),
               Padding(
                 padding: const EdgeInsets.only(left:0,top:5),
                 child: Text("ibadkarimi.10@gmail.com",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),),
               )
             ],
           ),

         ),
         ListTile(
           leading: Icon(Icons.home),
           title: const Text('Home',style: TextStyle(color: Colors.black),),
           onTap: () {
             // Update the state of the app.
             // ...
           },
         ),
         ListTile(
           leading: Icon(Icons.car_rental),
           title: const Text('Vehicle',style: TextStyle(color: Colors.black),),
           onTap: () {
             // Update the state of the app.
             // ...
           },
         ),
         ListTile(
           leading: Icon(Icons.real_estate_agent),
           title: const Text('Real State',style: TextStyle(color: Colors.black),),
           onTap: () {
             // Update the state of the app.
             // ...
           },
         ),
         ListTile(
           leading: Icon(Icons.agriculture),
           title: const Text('Aggriculture',style: TextStyle(color: Colors.black),),

           onTap: () {
             // Update the state of the app.
             // ...
           },
         ),
         ListTile(
           leading: GestureDetector(onTap:(){
             Get.offAll(()=>LoginFormWidget());
           },
             child:Icon(Icons.table_restaurant_sharp),),
           title: const Text('Furniture',style: TextStyle(color: Colors.black),),
           onTap: () {
             // Update the state of the app.
             // ...
           },
         ),
         ListTile(
           leading: Icon(Icons.login_rounded),
           title: GestureDetector(onTap:(){
             Get.offAll(()=>LoginFormWidget());
           },
               child: const Text('LogOut',style: TextStyle(color: Colors.black),)),
           onTap: () {
             // Update the state of the app.
             // ...
           },
         ),
       ],
     ),),

     body: SingleChildScrollView(
       scrollDirection: Axis.vertical,
       child: Column(  mainAxisAlignment:MainAxisAlignment.start,


children: [
Row(

  children: [

  Column(

        children: [
          GestureDetector(
            onTap: (){},
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
          Text("Cars",style: TextStyle(fontSize: 18.sp,color:Colors.black,fontWeight: FontWeight.w600),)
        ],
  ),

  Column(
        children: [
          GestureDetector(
            onTap: (){},
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
              onTap: (){},
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
              child: Text("Aggriculture",style: TextStyle(fontSize: 18.sp,color:Colors.black,fontWeight: FontWeight.w600),),
            )
          ],
        ),
        Column(

          children: [
            GestureDetector(
              onTap: (){},
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

  ],)


],),
     ),
   );
  }}
