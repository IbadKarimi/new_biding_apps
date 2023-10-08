



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

class AddRealStateView extends StatefulWidget{
  @override
  State<AddRealStateView > createState() => _AddRealStateViewState();
}

class _AddRealStateViewState extends State<AddRealStateView> {
  @override


  //-------------------------------------------
  final type = [

    "Residential House",
    'Commercial Plot',


  ];
  String _selectedValueType = "Residential House";

  //-------------------------------------------

  final areaType = [

    "Marla",
    'Kanal',
    'Acre',

  ];
  String _selectedValueAreaType = "Marla";

  //----------------Auction---------------------------


  final auctionType = [

    "Biding",
    'Fixed Auction',

  ];
  String _selectedValueAuctionType = "Biding";

  //--------------------------------------------


  TextEditingController noOfFloors=TextEditingController();
  TextEditingController range=TextEditingController();
  TextEditingController noOfBedrooms=TextEditingController();
  TextEditingController noOfBathrooms=TextEditingController();

  var pickedProfilePhoto;




  Widget build(BuildContext context) {
    return
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [
                    Container(
                        width: 300.w,
                        height: 35.h,
                        margin:  EdgeInsets.only(top: 5.h,left:30.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: <BoxShadow>[]),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              value: _selectedValueType,
                              items: type.map((e) {
                                return DropdownMenuItem(child: Text(e), value: e);
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedValueType = newValue as String;

                                });
                              },
                              isExpanded: true,
                            ))),

                    //-----------------Area Type text--------------//
                    Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 0.h),
                        child:  Text(
                          "Area Type.",
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
                            height: 35.h,
                            margin:  EdgeInsets.only(top: 5.h,left:30.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: <BoxShadow>[]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedValueAreaType,
                                  items: areaType.map((e) {
                                    return DropdownMenuItem(child: Text(e), value: e);
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValueAreaType = newValue as String;

                                    });
                                  },
                                  isExpanded: true,
                                ))),
                        Container(
                          width: 145.w,
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
                //---------------------------------Residential View Only------------------//
                    if(_selectedValueType=="Residential House")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 5.h),
                            child:  Text(
                              "No of Floors.",
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
                            controller: noOfFloors,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(

                              label: Text("No of Floors") ,prefixIcon:Icon(Icons.home),
                              border: OutlineInputBorder(),

                            ),),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 5.h),
                            child:  Text(
                              "No of Bedrooms.",
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
                            controller: noOfBedrooms,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(

                              label: Text("No of Bedrooms") ,prefixIcon:Icon(Icons.bed),
                              border: OutlineInputBorder(),

                            ),),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 5.h),
                            child:  Text(
                              "No of Bathrooms.",
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
                            controller: noOfBathrooms,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(

                              label: Text("No of Bathrooms") ,prefixIcon:Icon(Icons.bathroom),
                              border: OutlineInputBorder(),

                            ),),
                        ),

                      ],
                    ),

                    //----------------------------Residential House View End Here---------------//


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
                        height: 38.h,
                        margin:  EdgeInsets.only(top: 5.h,left:30.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: <BoxShadow>[]),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              value: _selectedValueAuctionType,
                              items: auctionType.map((e) {
                                return DropdownMenuItem(child: Text(e), value: e);
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