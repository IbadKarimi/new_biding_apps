



import 'package:biding_app/views/screens/Admin/AddFurniture.dart';
import 'package:biding_app/views/screens/Admin/AddRealState.dart';
import 'package:biding_app/views/screens/Admin/Other.dart';
import 'package:biding_app/views/screens/Vehicle/VehiclesView.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../Admin/AddAgriculture.dart';
import '../Admin/AddVehicle.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';



PlatformFile? _getImageFile;
var picked;

class SelectCateogoryView extends StatefulWidget{
  @override
  State<SelectCateogoryView> createState() => _SelectCateogoryViewState();
}

class _SelectCateogoryViewState extends State<SelectCateogoryView> {
  @override

  final questionItems = [

    "Vehicle",
    'Real State',
    'Agriculture',
    'Furniture',
    'Other',
  ];
  String _selectedValue = "Vehicle";


  var pickedProfilePhoto;

  Future getImage()async{
    final _picker = ImagePicker();
    pickedProfilePhoto = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (pickedProfilePhoto != null) {
      setState(() {
        _getImageFile= pickedProfilePhoto.files.first;

      });
    }}


  TextEditingController cityName=TextEditingController();
  TextEditingController completeAddress=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController startPrice=TextEditingController();
  TextEditingController endTime=TextEditingController();
  TextEditingController price=TextEditingController();



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
    bottomNavigationBar: CustomBottomNavigationBar(),
    drawer: CustomDrawer(),
    body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Padding(
        padding: const EdgeInsets.only(top:20),
        child: Center(
          child: DottedBorder(
            color: Colors.black,
            dashPattern: [8, 4],
            strokeWidth: 0.5,
            child:Container(
              width:300.w,height: 150.h,
              child: picked!=null?Image.memory(picked.files.first.bytes,width: 200.w,height: 200.h,): IconButton(icon:Icon(Icons.add_photo_alternate_outlined,size: 50,),onPressed: () async {getImage();},),),

          ),
        ),
      ),

    Padding(
    padding: EdgeInsets.only(top:10.h,bottom: 0.h,left: 30.w),
      child: Text(
        "Select Categories",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors
                .black,
            fontSize:
            16.sp),
      ),
    ),
      Container(
          width: 300.w,
          height: 38.h,
          margin:  EdgeInsets.only(top: 10.h,left:30.w),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(5.r),
              boxShadow: <BoxShadow>[]),
          child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: _selectedValue,
                items: questionItems.map((e) {
                  return DropdownMenuItem(child: Text(e), value: e);
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedValue = newValue as String;

                  });
                },
                isExpanded: true,
              ))),

        if( _selectedValue=="Furniture")
              AddFurnitureView(),

       if( _selectedValue=="Vehicle")
              AddVehicleView(),


      if( _selectedValue=="Agriculture")
        AddAgricultureView(),

      if( _selectedValue=="Real State")
        AddRealStateView(),

      if( _selectedValue=="Other")
        AddOtherView(),






      //---------------------End Items---------------------//
      Padding(
          padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 5.h),
          child:  Text(
            "Set Bidding Price.",
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
          controller: startPrice,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(

            label: Text("Set Price") ,prefixIcon:Icon(Icons.price_change),
            border: OutlineInputBorder(),

          ),),
      ),
      Padding(
          padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 5.h),
          child:  Text(
            "Set Bidding End Time.",
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
          controller: endTime,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(

            label: Text("End Time") ,prefixIcon:Icon(Icons.description),
            border: OutlineInputBorder(),

          ),),
      ),


      Padding(
          padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 5.h),
          child:  Text(
            "City Name",
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
          controller: cityName,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(

            label: Text("City Name") ,prefixIcon:Icon(Icons.location_city_sharp),
            border: OutlineInputBorder(),

          ),),
      ),
//--------------------------Complete adress--------------//

      Padding(
          padding: EdgeInsets.only(top: 5.h, left: 30.w, bottom: 5.h),
          child:  Text(
            "Complete Address.",
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
          controller: completeAddress,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(

            label: Text("Complete Address") ,prefixIcon:Icon(Icons.location_history_outlined),
            border: OutlineInputBorder(),

          ),),
      ),

//-------------------------------Description-------------------------//
      Padding(
          padding: EdgeInsets.only(top: 10.h, left: 30.w, bottom: 5.h),
          child:  Text(
            "Enter Description.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          )),
      Container(
        width: 300.w,
        height: 45.h,

        margin: EdgeInsets.only(top:0.h,left:30.w),
        child: TextFormField(
          controller: description,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(

            label: Text("Description") ,prefixIcon:Icon(Icons.description),
            border: OutlineInputBorder(),

          ),),
      ),

//-------------------------------------------------------//
    Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.h,left:20.w),
            height: 40.h,
            width: 100.w,
            child: ElevatedButton(onPressed:
                () async {


            }, child: Text("Reset", style: TextStyle(color: Colors
                .white),),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r))
              ),),
          ),
          Container(
                margin: EdgeInsets.only(top: 20.h,left:20.w),
                height: 40.h,
                width: 100.w,
                child: ElevatedButton(onPressed:
                    () async {


                }, child: Text("Cancel", style: TextStyle(color: Colors
                    .white),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r))
                  ),),
              ),


          Container(
            margin: EdgeInsets.only(top: 20.h,left:10.w),
            height: 40.h,
            width: 100.w,
            child: ElevatedButton(onPressed:
                () async {


            }, child: Text("Add", style: TextStyle(color: Colors
                .white),),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r))
              ),),
          ),
        ],
      ),
    ),




    ])));}}