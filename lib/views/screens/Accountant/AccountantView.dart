

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';


class AccountantView extends StatefulWidget{
  @override
  State<AccountantView> createState() => _AccountantViewState();
}

class _AccountantViewState extends State<AccountantView> {
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
        padding: EdgeInsets.only(top: 10.h, left: 60.w, bottom: 0.h),
        child:  Text(
          "Bid Approval ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),



      Container(
          margin: EdgeInsets.only(left:55.w,top:20.h),
          alignment: AlignmentDirectional.center,
          width:250.w,
          height: 250.h,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(0.r),
              border: Border.all(color: Colors.black,width: 1)
          ),

          child:Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Container(
                margin: EdgeInsets.only(left:0.w,top:0.h),

                width:320.w,
                height: 100.h,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("lib/utils/images/BidPic.png",)),

                    border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                ),

              ),
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
              Padding(
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
              Padding(
                padding: EdgeInsets.only(top: 5.h, left: 10, bottom: 0.h),
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
                padding: EdgeInsets.only(top: 5.h, left: 10, bottom: 0.h),
                child:  Text(
                  "1000000 RS",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  //----------Accept --------------------//
                  Container(
                    margin: EdgeInsets.only(top:10.h,left:0.w),
                    width: 80.w,
                    height: 35.h,
                    child: ElevatedButton(
                        onPressed: () {

                        },
                        // ignore: sort_child_properties_last
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  <
                                Widget>[
                              Center(
                                  child:
                                  Text(
                                    "Accept",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        10.sp),
                                  )),
                            ]),
                        style: ElevatedButton
                            .styleFrom(
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  20.0.r),
                            ),
                            backgroundColor:
                            Colors.lightGreen)),),

                  //----------------------Reject--------------------------//
                  Container(
                    margin: EdgeInsets.only(top:10.h,left:30.w),
                    width: 80.w,
                    height: 35.h,
                    child: ElevatedButton(
                        onPressed: () {

                        },
                        // ignore: sort_child_properties_last
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  <
                                Widget>[
                              Center(
                                  child:
                                  Text(
                                    "Reject",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        10.sp),
                                  )),
                            ]),
                        style: ElevatedButton
                            .styleFrom(
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  20.0.r),
                            ),
                            backgroundColor:
                            Colors.red)),),
                  //------------------------------------------------------//
                ],
              ),
            ],
          ),






      )]),
    ));}}