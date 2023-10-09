import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

PlatformFile? _getImageFile;
var picked;

class AddAgricultureView extends StatefulWidget{
  @override
  State<AddAgricultureView> createState() => _AddAgricultureViewState();
}

class _AddAgricultureViewState extends State<AddAgricultureView> {
  @override

  //-------------------------------------------
  final agricultureType = [

    "Wheat",
    'Cotton',
    'Apples',
    'SoyBean',
    'Rice',
    'Mango',
    'Potato',
    'Other',

  ];


  String _selectedValueAgricultureType = "Wheat";

  //----------------------------------------------
  final auctionType = [

    "Biding",
    'Fixed Auction',

  ];
  String _selectedValueAuctionType = "Biding";

  //-------------------------------------------------
  final workType = [

    "Cultivation",
    'Cutting Sale',

  ];
  String _selectedValueWorkType = "Cultivation";

  //-------------------------------------------------
  final areaType = [

    "Marla",
    'Kanal',
    'Acre',

  ];
  String _selectedValueAreaType = "Marla";



  TextEditingController range=TextEditingController();




  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [


                    //---------------------------------Type---------------//
                    Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                        child:  Text(
                          "Types of Crops",
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
                              value: _selectedValueAgricultureType,
                              items: agricultureType.map((e) {
                                return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValueAgricultureType = newValue as String;

                                });
                              },
                              isExpanded: true,
                            ))),

                    //------------------------Work Type-------------------------------//

                    Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                        child:  Text(
                          "Work type",
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
                              value: _selectedValueWorkType,
                              items: workType.map((e) {
                                return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValueWorkType = newValue as String;

                                });
                              },
                              isExpanded: true,
                            ))),

                    //--------------------------------Area Type-------------------//

                    Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                        child:  Text(
                          "Area type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Row(
                      children: [
                        Container(
                            width: 150.w,

                            margin:  EdgeInsets.only(top: 5.h,left:30.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: <BoxShadow>[]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedValueAreaType,
                                  items: areaType.map((e) {
                                    return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValueAreaType = newValue as String;

                                    });
                                  },
                                  isExpanded: true,
                                ))),
                        Container(
                          width: 150.w,
                          height: 35.h,

                          margin: EdgeInsets.only(top:5.h,left:5.w),
                          child: TextFormField(
                            controller: range,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(

                              label: Text("Range") ,prefixIcon:Icon(Icons.date_range),
                              border: OutlineInputBorder(),

                            ),),
                        ),

                      ],
                    ),

                    //-----------------------Auction type---------------//
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






                  ],)),


          ],


    );
  }
}