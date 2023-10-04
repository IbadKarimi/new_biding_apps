

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';


class MyBids extends StatefulWidget{
  @override
  State<MyBids> createState() => _MyBidsState();
}

class _MyBidsState extends State<MyBids> {
  @override
  int index = 0;

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
                    "My Bids ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),


                ////////////looof starts here//
                for(int i=0;i<10;i++)
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



                        Container(
                          margin: EdgeInsets.only(left:0.w,top:0.h),

                          width:100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("lib/utils/images/BidPic.png",)),


                          ),

                        ),

                        Column(
                          mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 10, bottom: 0.h),
                              child:  Text(
                                "Toyota Corolla",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              width: 180,

                              child: Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w),
                                child:  Text(
                                  "This is my favourite Car I am giving it low cost",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                              child:  Text(
                                "Price",
                                style: TextStyle(

                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                              child:  Text(
                                "RS 100,000 ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 10.w,bottom: 10.h),
                              child:  Center(
                                child: Text(
                                  "Your offer is RS 70,000 ",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
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