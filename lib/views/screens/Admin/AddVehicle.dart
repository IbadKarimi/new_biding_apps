

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';


import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


PlatformFile? _getImageFile;
var picked;
class AddVehicleView extends StatefulWidget{
  @override
  State<AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  @override

  //-------------------------------------------
  final vehicleType = [

    "Car",
    'Motor Cycle',
    'Buses',
    'Heavy Truck',
    'Other',

  ];
  String _selectedValueVehicleType = "Car";

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


  TextEditingController vehicleName=TextEditingController();
  TextEditingController modelNo=TextEditingController();
  TextEditingController registrationYear=TextEditingController();
  TextEditingController registrationArea=TextEditingController();
  TextEditingController enginePower=TextEditingController();
  TextEditingController fuelType=TextEditingController();



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
                         "Vehicle Type",
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
                             value: _selectedValueVehicleType,
                             items: vehicleType.map((e) {
                               return DropdownMenuItem(child: Text(e), value: e);
                             }).toList(),
                             onChanged: (newValue) {
                               setState(() {
                                 _selectedValueVehicleType = newValue as String;

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
                       height: 38.h,
                       margin:  EdgeInsets.only(top: 5.h,left:30.w),
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.black38, width: 1),
                           borderRadius: BorderRadius.circular(5.r),
                           boxShadow: <BoxShadow>[]),
                       child: DropdownButtonHideUnderline(
                           child: DropdownButtonFormField(
                             value: _selectedValueCondition,
                             items: condition.map((e) {
                               return DropdownMenuItem(child: Text(e), value: e);
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




                   //-----------------------------------------------------//



                   //------------------------------Fields-------------------------//






                   Padding(
                       padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 5.h),
                       child:  Text(
                         "Vehicle Name.",
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
                       controller: vehicleName,
                       style: TextStyle(color: Colors.black),
                       decoration: InputDecoration(

                         label: Text("Vehicle Name") ,prefixIcon:Icon(Icons.title_outlined),
                         border: OutlineInputBorder(),

                       ),),
                   ),
                   Padding(
                       padding: EdgeInsets.only(top: 5.h, left: 30.w, ),
                       child:  Text(
                         "Model No.",
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 14.sp,
                           fontWeight: FontWeight.w600,
                         ),
                       )),
                   Container(
                     width: 300.w,
                     height: 35.h,

                     margin: EdgeInsets.only(top:5.h,left:30.w),
                     child: TextFormField(
                       controller: modelNo,
                       style: TextStyle(color: Colors.black),
                       decoration: InputDecoration(

                         label: Text("Model No") ,prefixIcon:Icon(Icons.description),
                         border: OutlineInputBorder(),

                       ),),
                   ),
                   Padding(
                       padding: EdgeInsets.only(top: 5.h, left: 30.w, ),
                       child:  Text(
                         "Registration Area",
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 14.sp,
                           fontWeight: FontWeight.w600,
                         ),
                       )),
                   Container(
                     width: 300.w,
                     height: 35.h,

                     margin: EdgeInsets.only(top:5.h,left:30.w),
                     child: TextFormField(
                       controller: registrationArea,
                       style: TextStyle(color: Colors.black),
                       decoration: InputDecoration(

                         label: Text("Registration Area") ,prefixIcon:Icon(Icons.area_chart_outlined),
                         border: OutlineInputBorder(),

                       ),),
                   ),

                   Padding(
                       padding: EdgeInsets.only(top: 5.h, left: 30.w, ),
                       child:  Text(
                         "Registration Year",
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 14.sp,
                           fontWeight: FontWeight.w600,
                         ),
                       )),
                   Container(
                     width: 300.w,
                     height: 35.h,

                     margin: EdgeInsets.only(top:5.h,left:30.w),
                     child: TextFormField(
                       controller: registrationArea,
                       style: TextStyle(color: Colors.black),
                       decoration: InputDecoration(

                         label: Text("Registration Year") ,prefixIcon:Icon(Icons.calendar_month),
                         border: OutlineInputBorder(),

                       ),),
                   ),

                   Padding(
                       padding: EdgeInsets.only(top: 5.h, left: 30.w, ),
                       child:  Text(
                         "Engine Power",
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 14.sp,
                           fontWeight: FontWeight.w600,
                         ),
                       )),
                   Container(
                     width: 300.w,
                     height: 35.h,

                     margin: EdgeInsets.only(top:5.h,left:30.w),
                     child: TextFormField(
                       controller: registrationArea,
                       style: TextStyle(color: Colors.black),
                       decoration: InputDecoration(

                         label: Text("Engine Power") ,prefixIcon:Icon(Icons.power),
                         border: OutlineInputBorder(),

                       ),),
                   ),






                           ],)),


                   ],

       );

  }
}