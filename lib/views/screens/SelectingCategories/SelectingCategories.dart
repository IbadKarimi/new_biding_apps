



import 'dart:io';

import 'package:biding_app/controllers/AgricultureController.dart';
import 'package:biding_app/controllers/OtherCategoryController.dart';
import 'package:biding_app/controllers/RealStateController.dart';
import 'package:biding_app/controllers/VehicleController.dart';
import 'package:biding_app/model/AgricultureModel.dart';
import 'package:biding_app/model/FurnitureModel.dart';
import 'package:biding_app/model/OtherCategoryModel.dart';

import 'package:biding_app/views/screens/Home/HomePageView.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../controllers/FurnitureController.dart';
import '../../../model/RealStateModel.dart';
import '../../../model/VehicleModel.dart';

import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';



PlatformFile _getImageFile;
var picked;

class SelectCateogoryView extends StatefulWidget{
  @override
  State<SelectCateogoryView> createState() => _SelectCateogoryViewState();
}

class _SelectCateogoryViewState extends State<SelectCateogoryView> {
  DateTime selectedDate;
  String formattedSelectedDate = '';

  DateTime selectedDateTime;
  String formattedSelectedDateTime = '';
  String remainingTime = '';

  Future<void> _pickDate() async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
        setState(() {
          selectedDateTime = combinedDateTime;
          formattedSelectedDateTime = DateFormat('dd/MM/yyyy hh:mm a').format(combinedDateTime);

       remainingTime = calculateRemainingTime(combinedDateTime);
        });
      }
    }
  }

  String calculateRemainingTime(DateTime pickedDateTime) {
    DateTime now = DateTime.now();
    Duration difference = pickedDateTime.isAfter(now) ? pickedDateTime.difference(now) : Duration.zero;

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return '$days days, $hours hours, $minutes minutes, $seconds seconds';
  }



  @override


  //--------------------AddFurnitureView----------------------//
  //-------------------------------------------
  final FurnitureController furnitureController = FurnitureController();
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


  //--------------------------AddVehicleView---------------------------------//
  final VehicleController vehicleController = VehicleController();

  final TextEditingController vehicleName=TextEditingController();
  final TextEditingController modelNo=TextEditingController();
  final TextEditingController registrationYear=TextEditingController();
  final TextEditingController registrationArea=TextEditingController();
  final TextEditingController enginePower=TextEditingController();
  final TextEditingController fuelType=TextEditingController();

  //-------------------------------------------
  final vehicleType = [

    "Car",
    'Motor Cycle',
    'Buses',
    'Heavy Truck',
    'Other',

  ];
  String _selectedValueVehicleType = "Car";

  //--------------------------AddAgricultureView----------------------------//
  final AgricultureController agricultureController = AgricultureController();
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








  //--------------------------AddRealState---------------------------------//
  //-------------------------------------------
  final type = [

    "Residential House",
    'Commercial Plot',


  ];
  String _selectedValueType = "Residential House";



  //--------------------------------------------


  TextEditingController noOfFloors=TextEditingController();
  TextEditingController range=TextEditingController();
  TextEditingController noOfBedrooms=TextEditingController();
  TextEditingController noOfBathrooms=TextEditingController();

  var pickedProfilePhoto;




  //------------------------



  List<String> categories = [

    "Vehicle",
    'Real State',
    'Agriculture',
    'Furniture',
    'Other',
  ];
  String _selectedValue = "Vehicle";

  //----------------------------------------OtherView-------------------------//





  TextEditingController categoryName=TextEditingController();

  //-----------------------------End Items-----------------------------------------------//

  TextEditingController cityName=TextEditingController();
  TextEditingController completeAddress=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController startPrice=TextEditingController();
  TextEditingController endTime=TextEditingController();
  TextEditingController price=TextEditingController();

  //-----------------------------------------------------------------------------------//
  Rx<File> image=File('').obs;
  Future getImage()async{

    final pickImage=await ImagePicker().pickImage(source: ImageSource.gallery);
    final imageTemp=File(pickImage.path);
    image.value=imageTemp;
    print(imageTemp.path.toString());
    if(image.value!=""){

      //   controller.InsertImage(image);
    }}

//-------------------------------Handlers-----------------------//
  bool _isLoading = false;
  void _handlevehicle(BuildContext context) async {

    setState(() {
      _isLoading = true; // Set loading state to true when login starts
    });


   // String password = _passwordController.text.trim();

    try {
      VehicleModel vehicleModel = VehicleModel(
        buyerDocId: "",
        vehicleType: _selectedValueVehicleType,
        condition: _selectedValueCondition,
        auctionType: _selectedValueAuctionType,
        vehicleName: vehicleName.text,
        model: modelNo.text,
        registerArea: registrationArea.text,
        registerYear: registrationYear.text,
        enginePower: enginePower.text,
        setBidPrice: price.text,
        setBidEndTime: remainingTime.toString(),
        cityName: cityName.text,
        completeAddress: completeAddress.text,
        description: description.text,
        status: "Pending",
      );

      User firebaseUser = await vehicleController.InsertVehicle(vehicleModel, image);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Inserted Sucessfully'),
      ));
      Get.offAll(()=>HomePageView());
    }
    catch (e) {
      // Handle login error, e.g., show error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Vehicle Add Failed. $e'),
      ));
    }
    finally {
      setState(() {
        _isLoading = false; // Set loading state to false after login attempt (success or failure)
      });
    }
  }
  void _handleAgriculture(BuildContext context) async {

    setState(() {
      _isLoading = true; // Set loading state to true when login starts
    });


    // String password = _passwordController.text.trim();

    try {
      AgricultureModel agricultureModel = AgricultureModel (
        buyerDocId: "",
        typesCrops: _selectedValueAgricultureType,
        workType: _selectedValueWorkType,
        areaType: _selectedValueAreaType,
        range: range.text,
        auctionType: _selectedValueAuctionType,
        setBidPrice: price.text,
        setBidEndTime: remainingTime.toString(),
        cityName: cityName.text,
        completeAddress: completeAddress.text,
        description: description.text,
        status: "Pending",
      );

      User firebaseUser = await agricultureController.InsertAgriculture(agricultureModel , image);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Inserted Sucessfully'),
      ));
      Get.offAll(()=>SelectCateogoryView());
    }
    catch (e) {
      // Handle login error, e.g., show error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Agriculture Add Failed. $e'),
      ));
    }
    finally {
      setState(() {
        _isLoading = false; // Set loading state to false after login attempt (success or failure)
      });
    }
  }
  void _handleFurniture(BuildContext context) async {

    String remainingTime=calculateRemainingTime(selectedDateTime);

    setState(() {
      _isLoading = true; // Set loading state to true when login starts
    });


    // String password = _passwordController.text.trim();

    try {
      FurnitureModel furnitureModel = FurnitureModel (
        buyerDocId: "",
        makingMaterial: _selectedValuemMakingMaterial,
        selectType:  _selectedValueSelectTypes,
        condition:_selectedValueCondition,
        auctionType: _selectedValueAuctionType,
        setBidPrice: price.text,
        setBidEndTime:remainingTime.toString(),
        cityName: cityName.text,
        completeAddress: completeAddress.text,
        description: description.text,
        status: "Pending",
        remainingTime:  remainingTime,
      );

      User firebaseUser = await furnitureController.InsertFurniture(furnitureModel , image);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Inserted Sucessfully'),
      ));
      Get.offAll(()=>SelectCateogoryView());
    }
    catch (e) {
      // Handle login error, e.g., show error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Agriculture Add Failed. $e'),
      ));
    }
    finally {
      setState(() {
        _isLoading = false; // Set loading state to false after login attempt (success or failure)
      });
    }
  }
  void _handleRealStateResidential(BuildContext context) async {
    String remainingTime=calculateRemainingTime(selectedDateTime);
    setState(() {
      _isLoading = true; // Set loading state to true when login starts
    });


    // String password = _passwordController.text.trim();

    try {
      RealStateModel realStateModel = RealStateModel  (
        buyerDocId: "",
        selectType: _selectedValueType, //residential and commercial
        areaType: _selectedValueAreaType,
        range: range.text,
        noFloors: noOfFloors.text,
        noBedrooms: noOfBedrooms.text,
        noBathrooms: noOfBathrooms.text,
        auctionType: _selectedValueAuctionType,
        setBidPrice: price.text,
        setBidEndTime: remainingTime.toString(),
        cityName: cityName.text,
        completeAddress: completeAddress.text,
        description: description.text,
        status: "Pending",
      );
      RealStateController realStateController=RealStateController();
      User firebaseUser = await realStateController.InsertRealState(realStateModel , image);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Inserted Sucessfully'),
      ));
      Get.offAll(()=>SelectCateogoryView());
    }
    catch (e) {
      // Handle login error, e.g., show error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('RealState Add Failed. $e'),
      ));
    }
    finally {
      setState(() {
        _isLoading = false; // Set loading state to false after login attempt (success or failure)
      });
    }
  }
  void _handleRealStateCommercial(BuildContext context) async {
    String remainingTime=calculateRemainingTime(selectedDateTime);

    setState(() {
      _isLoading = true; // Set loading state to true when login starts
    });


    // String password = _passwordController.text.trim();

    try {
      RealStateModel realStateModel = RealStateModel  (
        buyerDocId: "",
        selectType: _selectedValueType, //residential and commercial
        areaType: _selectedValueAreaType,
        range: range.text,
        noFloors: "",
        noBedrooms: "",
        noBathrooms: "",
        auctionType: _selectedValueAuctionType,
        setBidPrice: price.text,
        setBidEndTime: remainingTime.toString(),
        cityName: cityName.text,
        completeAddress: completeAddress.text,
        description: description.text,
        status: "Pending",
      );
      RealStateController realStateController=RealStateController();
      User firebaseUser = await realStateController.InsertRealState(realStateModel , image);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Inserted Sucessfully'),
      ));
      Get.offAll(()=>SelectCateogoryView());
    }
    catch (e) {
      // Handle login error, e.g., show error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('RealState Add Failed. $e'),
      ));
    }
    finally {
      setState(() {
        _isLoading = false; // Set loading state to false after login attempt (success or failure)
      });
    }
  }
  void _handleOtherCategory(BuildContext context) async {
    String remainingTime=calculateRemainingTime(selectedDateTime);

    setState(() {
      _isLoading = true; // Set loading state to true when login starts
    });


    // String password = _passwordController.text.trim();

    try {
      OtherCategoryModel otherCategoryModel = OtherCategoryModel (
        buyerDocId: "",
        categoryName: categoryName.text,
        condition:_selectedValueCondition,
        auctionType: _selectedValueAuctionType,
        setBidPrice: price.text,
        setBidEndTime:  remainingTime.toString(),
        cityName: cityName.text,
        completeAddress: completeAddress.text,
        description: description.text,
        status: "Pending",
      );
      OtherCategoryController otherCategoryController=OtherCategoryController();
      User firebaseUser = await otherCategoryController.InsertOtherCategory(otherCategoryModel , image);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data Inserted Sucessfully'),
      ));
      Get.offAll(()=>SelectCateogoryView());
    }
    catch (e) {
      // Handle login error, e.g., show error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Other Categories Add Failed. $e'),
      ));
    }
    finally {
      setState(() {
        _isLoading = false; // Set loading state to false after login attempt (success or failure)
      });
    }
  }
  //----------------------------------------------------//

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
      //progressIndicator


      Obx(() {
      return Padding(
         padding: const EdgeInsets.only(top:20),
         child: Center(
           child: DottedBorder(
             color: Colors.black,
             dashPattern: [8, 4],
             strokeWidth: 0.5,
             child:Container(
               width:300.w,height: 150.h,
               child: image.value.path!=""?
               Image(image:FileImage(File(image.value.path))):
               IconButton(icon:Icon(Icons.add_photo_alternate_outlined,size: 50,),onPressed: () async {getImage();},),),

           ),
         ),
       );
     } ),


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

          margin:  EdgeInsets.only(top: 10.h,left:30.w),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(5.r),
              boxShadow: <BoxShadow>[]),
          child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: _selectedValue,
                items: categories.map((e) {
                  return DropdownMenuItem<String>(
                      child:
                      Text(e,style: TextStyle(color: Colors.black),), value: e);
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedValue = newValue as String;

                  });
                },
                isExpanded: true,
              ))),

        if( _selectedValue=="Furniture")
          Column(
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












            ],),

       if( _selectedValue=="Vehicle")
          Column(
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

                  margin:  EdgeInsets.only(top: 5.h,left:30.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 1),
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: <BoxShadow>[]),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        value: _selectedValueVehicleType,
                        items: vehicleType.map((e) {
                          return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
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

                  margin:  EdgeInsets.only(top: 5.h,left:30.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 1),
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: <BoxShadow>[]),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        value: _selectedValueCondition,
                        items: condition.map((e) {
                          return DropdownMenuItem(
                              child: Text(e,style: TextStyle(color: Colors.black),),

                              value: e);
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
                  controller: registrationYear,
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
                  controller: enginePower,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(

                    label: Text("Engine Power") ,prefixIcon:Icon(Icons.power),
                    border: OutlineInputBorder(),

                  ),),
              ),






            ],),


       if( _selectedValue=="Agriculture")
          Column(
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






          ],),

       if( _selectedValue=="Real State")
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,


          children: [
            Container(
                width: 300.w,

                margin:  EdgeInsets.only(top: 5.h,left:30.w),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 1),
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: <BoxShadow>[]),
                child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      value: _selectedValueType,
                      items: type.map((e) {
                        return DropdownMenuItem(child: Text(e,style: TextStyle(color: Colors.black),), value: e);
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





          ],),

       if( _selectedValue=="Other")
          Column(
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

    ),






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
          controller: price,
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
      GestureDetector(
        onTap: (){
          _pickDate();
        },
        child: Container(
          width: 300.w,
          height: 35.h,

          margin: EdgeInsets.only(top:0.h,left:30.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: Colors.grey, width: 1),


          ),
          child: Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left:5.w),
                child: Icon(Icons.calendar_month),
              ),
            Padding(
            padding:  EdgeInsets.only(left:5.w), child:Text( formattedSelectedDateTime.toString(),style: TextStyle(color: Colors.black,),),)
            ],
          )

        ),
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
      Center(
        child: _isLoading
            ? Padding(
          padding: const EdgeInsets.only(top:10),
          child: CircularProgressIndicator(),
        ) // Show CircularProgressIndicator when loading
            :Container(),),
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

                  Get.offAll(()=>HomePageView());

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
            child: ElevatedButton(onPressed:()async{

              if(_selectedValue=="Vehicle") {
                _handlevehicle(context);
              }
              if(_selectedValue=="Agriculture") {
                _handleAgriculture(context);
              }

              if(_selectedValue=="Furniture") {
                _handleFurniture(context);
              }
              if(_selectedValue=="Other"){
                _handleOtherCategory(context);
              }

              if(_selectedValue=="Real State") {
                if(_selectedValueType=="Residential House"){
                  _handleRealStateResidential(context);
                }else{
                  _handleRealStateCommercial(context);
                }

              }
            }
              , child: Text("Add", style: TextStyle(color: Colors
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




    ])

    ));

  }}