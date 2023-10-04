import 'dart:ui';

import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Admin/AddVehicle.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../authentication_repository/login.dart';



class VehicleView extends StatefulWidget{
  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {
  @override
  int index = 0;

  TextEditingController offer=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:CustomAppBar(),
        drawer:CustomDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(  mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 20.w, bottom: 0.h),
                  child:  Text(
                    "Vehicles",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 120.w, bottom: 0.h),
                  child:  Text(
                    "Add Products",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 0.w, bottom: 0.h),
          child: IconButton(onPressed: (){    Get.to(()=>AddVehicleView());}, icon: Icon(Icons.add_circle_outline,color: Colors.blue,size: 30,)))
              ],),

              for(int i=0;i<10;i++)
              Column(
              children: [

                Container(
                  margin: EdgeInsets.only(left:20.w,top:20.h),
                  alignment: AlignmentDirectional.center,
                  width:320.w,
                  height: 400.h,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(0.r),
                      border: Border.all(color: Colors.black,width: 1)
                  ),

                child:Column(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: []),

                    Container(
                      margin: EdgeInsets.only(left:0.w,top:0.h),

                      width:320.w,
                      height: 180.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("lib/utils/images/BidPic.png",)),

                          border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 10, bottom: 0.h),
                      child:  Text(
                        "Toyota Corolla",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 10.w),
                      child:  Text(
                        "This is my favourite Car I am giving it low cost",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 10, bottom: 0.h),
                      child:  Text(
                        "Price",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 10, bottom: 0.h),
                      child:  Text(
                        "1000000 RS",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top:10.h,left:0.w),
                        width: 160.w,
                        height: 45.h,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 0),
                                        child: AlertDialog(
                                            shape:
                                            const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        10.0))),


                                            content:Container(
                                              width: 250.w,
                                              height: 250.h,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                Text(
                                                  "Offer",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                      color: Colors
                                                          .black,
                                                      fontSize:
                                                      16.sp),
                                                ),


                                                Padding(
                                                  padding: const EdgeInsets.only(top:20,bottom: 10),
                                                  child: Text(
                                                    "Enter your offer",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize:
                                                        16.sp),
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: 250.w,
                                                  height: 45.h,
                                                  child: TextFormField(
                                                    controller: offer,

                                                    decoration: InputDecoration(

                                                      label: Text("10,0000") ,
                                                      border: OutlineInputBorder(),
                                                    ),),
                                                ),

                                              Padding(
                                                padding:EdgeInsets.only(top:70.h),
                                                child: Row(
                                                  children: [

                                                    Container(
                                                      margin: EdgeInsets.only(left:10.w),
                                                      width: 100.w,
                                                      height: 40.h,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();

                                                        },
                                                        // ignore: sort_child_properties_last
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:  <
                                                                Widget>[
                                                              Center(
                                                                  child:
                                                                  Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                        12.sp),
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
                                                            const Color(
                                                                0xFF363B42)),),
                                                    ),
                                                    Container(
                                                      width: 100.w,
                                                      height: 40.h,
                                                      margin: EdgeInsets.only(left:10.w),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          showDialog(context: context, builder:(BuildContext context){
                                                           return AlertDialog(
                                                             shape: RoundedRectangleBorder(borderRadius:
                                                             BorderRadius.all(
                                                                 Radius.circular(
                                                                     10.0))),
                                                             content: Container(
                                                               width: 250.w,
                                                               height: 250.h,
                                                               child: Column(
                                                                 mainAxisAlignment: MainAxisAlignment.start,

                                                                   children:
                                                                   [
                                                                     Container(width: 100.w,height:100.h,
                                                                     margin: EdgeInsets.only(top:30.h),

                                                                     decoration:BoxDecoration(
                                                                       image: DecorationImage(
                                                                           image: AssetImage("lib/utils/images/accept.png")
                                                                       ),
                                                                     ) ),
                                                                     Center(
                                                                         child:
                                                                         Padding(
                                                                           padding: EdgeInsets.only(top:10.h,bottom: 20.h),
                                                                           child: Text(
                                                                             "Congragulations ! Your offer sent to Bidding Sale System ",
                                                                             style: TextStyle(
                                                                               fontWeight: FontWeight.w600,
                                                                                 color: Colors
                                                                                     .green,
                                                                                 fontSize:
                                                                                 12.sp),
                                                                           ),
                                                                         )),

                                                                     Container(
                                                                       margin: EdgeInsets.only(left:5.w),
                                                                       width: 100.w,
                                                                       height: 40.h,
                                                                       child: ElevatedButton(
                                                                         onPressed: () {
                                                                           Navigator.of(context).push(
                                                                               MaterialPageRoute(
                                                                                   builder:
                                                                                       (context) =>
                                                                                       VehicleView()));

                                                                         },
                                                                         // ignore: sort_child_properties_last
                                                                         child: Row(
                                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                                             children:  <
                                                                                 Widget>[
                                                                               Center(
                                                                                   child:
                                                                                   Text(
                                                                                     "Ok",
                                                                                     style: TextStyle(
                                                                                         color: Colors
                                                                                             .white,
                                                                                         fontSize:
                                                                                         12.sp),
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
                                                                             const Color(
                                                                                 0xFF363B42)),),
                                                                     ),
                                                                   ]),
                                                             ),

                                                           );

                                                          });




                                                        },
                                                        // ignore: sort_child_properties_last

                                                        //------------------------ok approval-------------//
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:  <
                                                                Widget>[
                                                              Center(
                                                                  child:
                                                                  Text(
                                                                    "Ok",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                        12.sp),
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
                                                            const Color(
                                                                0xFF363B42)),),
                                                    ),
                                                  ],
                                                ),
                                              )

                                              ],),
                                            )



                                        ));});



                            },
                            // ignore: sort_child_properties_last
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  <
                                    Widget>[
                                  Center(
                                      child:
                                      Text(
                                        "Bid Now",
                                        style: TextStyle(
                                            color: Colors
                                                .white,
                                            fontSize:
                                            16.sp),
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
                    ),
                  ],
                ),
                ),
              ],
              ),
            ],
          ),
        )
           );}}