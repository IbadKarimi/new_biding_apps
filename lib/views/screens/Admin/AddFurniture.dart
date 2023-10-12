



import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


PlatformFile _getImageFile;
var picked;

class AddFurnitureView extends StatefulWidget{
  @override
  State<AddFurnitureView> createState() => _AddFurnitureViewState();
}

class _AddFurnitureViewState extends State<AddFurnitureView> {
  @override
  //-------------------------------------------
  final makingMaterial = [

    "Wood",
    'Steel',
    'Other',

  ];
  String _selectedValuemMakingMaterial = "Wood";

  //-------------------------------------------

  final condition = [

    "New",
    'Old',
    'Other',

  ];
  String _selectedValueCondition = "New";

  //----------------------------------------------

  final selectTypes = [

    "Chairs",
    'Sofas',
    'Desk',
    'Cupboards',
    'Tables',
    'Cabinets',
    'Beds',
    'Other',

  ];
  String _selectedValueSelectTypes = "Chairs";

  //-------------------------------------------


  final auctionType = [

    "Biding",
    'Fixed Auction',

  ];
  String _selectedValueAuctionType = "Biding";










  Widget build(BuildContext context) {
    return  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [



//----------------------------------------------Ist drop down
                    Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                        child:  Text(
                          "Making Material",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                        width: 300.w,

                        margin:  EdgeInsets.only(top: 5.h,left:30.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: <BoxShadow>[]),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              value: _selectedValuemMakingMaterial,
                              items: makingMaterial.map((e) {
                                return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValuemMakingMaterial = newValue as String;

                                });
                              },
                              isExpanded: true,
                            ))),


                    //--------------------------Condition Drop Down---------------//
                    Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                        child:  Text(
                          "Condition",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                        width: 300.w,

                        margin:  EdgeInsets.only(top: 5.h,left:30.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: <BoxShadow>[]),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              value: _selectedValueCondition,
                              items: condition.map((e) {
                                return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValueCondition = newValue as String;

                                });
                              },
                              isExpanded: true,
                            ))),



                    //------------------------------Select Types
                    Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                        child:  Text(
                          "Select Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                        width: 300.w,

                        margin:  EdgeInsets.only(top: 5.h,left:30.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: <BoxShadow>[]),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              value: _selectedValueSelectTypes,
                              items: selectTypes.map((e) {
                                return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValueSelectTypes = newValue as String;

                                });
                              },
                              isExpanded: true,
                            ))),

                    //--------------------Auction type=------------------/


                    Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                        child:  Text(
                          "Auction Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                        width: 300.w,

                        margin:  EdgeInsets.only(top: 5.h,left:30.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: <BoxShadow>[]),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              value: _selectedValueAuctionType,
                              items: auctionType.map((e) {
                                return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValueAuctionType = newValue as String;

                                });
                              },
                              isExpanded: true,
                            ))),




                    //--------------------------Auction Type---------------------------//












                  ],)),


          ],


    );
  }
}