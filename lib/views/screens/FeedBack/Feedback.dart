


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';

class FeedBackView extends StatefulWidget{
  @override
  State<FeedBackView  > createState() => _FeedBackViewState();
}

class _FeedBackViewState extends State<FeedBackView  > {
  @override
  int index = 0;

  TextEditingController email=TextEditingController();
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
        padding:EdgeInsets.only(left:20.w,top:20.h),
        child: Text("Feed Back",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 16.sp),),
      ),
      Center(
        child: Container(
          width: 300.w,
          height: 45.h,
          margin: EdgeInsets.only(left:0.w,top:20.w),
          child: TextFormField(
            controller: email,

            decoration: InputDecoration(

              label: Text("Email") ,prefixIcon:Icon(Icons.email_rounded),
              border: OutlineInputBorder(),
            ),),
        ),
      ),

      Center(
        child: Container(
            height: 200.h,
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
                border: Border.all(color:Colors.grey, width: 1)),
            margin: EdgeInsets.only(top: 5.h, left: 0.w, bottom: 10.h),
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  new TextFormField(
                    keyboardType: TextInputType.multiline,

                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: "Type your messsage",
                      border: InputBorder.none,
                    ),
                  ),

                ])),
      ),
      Center(
        child:   Container(
          margin: EdgeInsets.only(top:30.h,bottom: 20.h),
          width: 250.w,
          height: 45.h,
          child:ElevatedButton(onPressed: (){



          }, child:  Text("Submit"),
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

    ])));}}