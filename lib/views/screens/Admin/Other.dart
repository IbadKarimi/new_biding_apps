

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';


import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


PlatformFile _getImageFile;
var picked;
class AddOtherView extends StatefulWidget{
  @override
  State<AddOtherView > createState() => _AddOtherViewState();
}

class _AddOtherViewState extends State<AddOtherView > {
  @override



  //-------------------------------------------
  final condition = [

    "New",
    'Old',
    'Other',

  ];
  String _selectedValueCondition = "New";

  //----------------------------------------------

  final auctionType = [

    "Biding",
    'Fixed Auction',

  ];
  String _selectedValueAuctionType = "Biding";
//----------------------------------------------------//


  TextEditingController categoryName=TextEditingController();




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

                //------------------------------Vehicle Type---------------//
                Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                    child:  Text(
                      "Write Category Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                Container(
                  width: 300.w,
                  height: 35.h,

                  margin: EdgeInsets.only(top:0.h,left:30.w),
                  child: TextFormField(
                    controller: categoryName,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(

                      label: Text("Category Name") ,prefixIcon:Icon(Icons.category),
                      border: OutlineInputBorder(),

                    ),),
                ),



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




                //-----------------------------------------------------//



                //------------------------------Fields-------------------------//














              ],)),


      ],

    );

  }
}