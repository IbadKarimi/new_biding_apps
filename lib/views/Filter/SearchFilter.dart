



import 'dart:io';

import 'package:biding_app/controllers/AgricultureController.dart';
import 'package:biding_app/controllers/HomeController.dart';
import 'package:biding_app/controllers/RealStateController.dart';

import 'package:biding_app/controllers/VehicleController.dart';
import 'package:biding_app/model/AgricultureModel.dart';
import 'package:biding_app/model/FurnitureModel.dart';
import 'package:biding_app/model/RealStateModel.dart';
import 'package:biding_app/model/VehicleModel.dart';


import 'package:biding_app/views/screens/Home/HomePageView.dart';


import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/FurnitureController.dart';

import '../../model/HomePageModel.dart';
import '../screens/ Chat/ChatView.dart';
import '../screens/Home/BidsMainView.dart';
import '../screens/Widgets/AppBar.dart';
import '../screens/Widgets/BottomNavigationBar.dart';
import '../screens/Widgets/Drawer.dart';




PlatformFile? _getImageFile;
var picked;

class SearchFilterView extends StatefulWidget{
  @override
  State<SearchFilterView> createState() => _SearchFilterView();
}

class _SearchFilterView extends State<SearchFilterView> {
  DateTime? selectedDate;
  String formattedSelectedDate = '';

  DateTime? selectedDateTime;
  String formattedSelectedDateTime = '';
  String remainingTime = '';
  List<HomePageModel> data=[];

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
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
    final imageTemp=File(pickImage!.path);
    image.value=imageTemp;
    print(imageTemp.path.toString());
    if(image.value!=""){

      //   controller.InsertImage(image);
    }}

//-------------------------------Handlers-----------------------//
  bool _isLoading = false;

  //----------------------------------------------------//
  List<HomePageModel> filteredItems=[];

  List<VehicleModel> allVehicleData=[];
  List<FurnitureModel> allFurnitureData=[];
  List<AgricultureModel> allAgricultureData=[];
  List<RealStateModel> allRealSateData=[];

  List<VehicleModel> filteredVehicle=[];
  List<FurnitureModel> filteredFurniture=[];
  List<AgricultureModel> filteredAgriculture=[];
  List<RealStateModel> filteredRealState=[];

  HomePageController homePageController=HomePageController();
  RealStateController realStateController=RealStateController();
  String vehicleQuery="";
  String furnitureQuery="";
  String agricultureQuery="";
  String realEstateQuery="";
  TextEditingController offer=TextEditingController();

  void _filterVehicle(String vehicleType,String VehicleName,String modelNo,String price) {
    setState(() {
      allVehicleData = allVehicleData.where((item) =>
          item.vehicleType.toLowerCase().contains(vehicleType.toLowerCase())||
          item.vehicleName.toLowerCase().contains(VehicleName.toLowerCase())||
          item.model.toLowerCase().contains(modelNo.toLowerCase())   ||
              item.setBidPrice.toLowerCase().contains(price.toLowerCase())


      )
          .toList();
    });
  }

  void _filterAgriculture(String typesCrops,String workType,String price) {
    setState(() {
      allAgricultureData = allAgricultureData.where((item) =>
      item.typesCrops.toLowerCase().contains(typesCrops.toLowerCase())&&
          item.workType.toLowerCase().contains(workType.toLowerCase())&&

          item.setBidPrice.toLowerCase().contains(price.toLowerCase())


      )
          .toList();
    });
  }
  void _filterFurniture(String makingMaterial,String selectType,String price) {
    setState(() {
      allFurnitureData = allFurnitureData.where((item) =>
      item.makingMaterial.toLowerCase().contains(makingMaterial.toLowerCase()) ||
          item.selectType.toLowerCase().contains(selectType.toLowerCase()) ||
          item.setBidPrice.toLowerCase().contains(price.toLowerCase())


      )
          .toList();
    });
  }

  void _filterRealEstate(String selectType,String areaType,String range,String price) {
    setState(() {
      allRealSateData =  allRealSateData.where((item) =>
      item.selectType.toLowerCase().contains(selectType.toLowerCase())||
          item.areaType.toLowerCase().contains(areaType.toLowerCase()) ||
          item.range.toLowerCase().contains(range.toLowerCase()) ||
          item.setBidPrice.toLowerCase().contains(price.toLowerCase())


      )
          .toList();
    });
  }


  void initState() {


    vehicleController.getVehicle().then((value){
      allVehicleData.addAll(value);
      filteredVehicle.addAll(allVehicleData);

    });

    furnitureController.getFurniture().then((value) {
      allFurnitureData.addAll(value);
      filteredFurniture.addAll(allFurnitureData);
    });

    realStateController.getRealState().then((value){
      allRealSateData.addAll(value);
      filteredRealState.addAll(allRealSateData);
    });

    agricultureController.getAgriculture().then((value){
      allAgricultureData.addAll(value);

    });






    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        drawer: CustomDrawer(),
        body: vehicleQuery!="" || furnitureQuery!="" || agricultureQuery!="" || realEstateQuery!=""?
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){
              setState(() {
                vehicleQuery="";
                furnitureQuery="";
                agricultureQuery="";
                realEstateQuery="";
              });


            }, icon: Icon(Icons.arrow_back)),

            if(_selectedValue=="Vehicle")

            for(int index=0;index<allVehicleData.length;index++)

              Container(
                margin: EdgeInsets.only(top:10.h,left:10.w,right: 10.w),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0.r),
                    border: Border.all(color: Colors.black,width: 1)
                ),

                child:Column(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //----------------------Pic Box----------------------//

                    Container(
                      margin: EdgeInsets.only(left:0.w,top:0.h),


                      height: 180.h,
                      decoration: BoxDecoration(

                          image: DecorationImage(image: NetworkImage(allVehicleData[index].imagePath),fit:BoxFit.cover),

                          border: Border(bottom: BorderSide(width: 1))
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        allVehicleData[index].vehicleName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        allVehicleData[index].vehicleType,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        "Condition",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        allVehicleData[index].condition,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        "Model No",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        allVehicleData[index].model,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        "Register Year",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        allVehicleData[index].registerYear,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        "Register Area",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        allVehicleData[index].registerArea,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 7.w),
                          child: Icon(Icons.location_pin,color: Colors.red,),),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 3.w),
                          child:  Text(
                            allVehicleData[index].cityName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w),
                      child:  Text(
                        allVehicleData[index].completeAddress,
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
                        allVehicleData[index].description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                            child:  Text(
                              "Rs :",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                          child:  Text(
                            allVehicleData[index].setBidPrice,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                        child:   allVehicleData[index].auctionType=="Biding"?
                        Container(
                            margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                            width: 220.w,
                            height: 35.h,
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
                                                          style: TextStyle(color: Colors.black),
                                                          decoration: InputDecoration(

                                                            label: Text("Offer") ,
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
                                                            //-------------Ok Button Starts here

                                                            Container(
                                                              width: 100.w,
                                                              height: 40.h,
                                                              margin: EdgeInsets.only(left:30.w),
                                                              child: ElevatedButton(
                                                                onPressed: () async{

                                                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                  String? userId=prefs.getString("docId"); //user id

                                                                  try{
                                                                   /* homePageController.InsertOffer(_storedValue, "Vehicle", price, offer.text);
                                                                    homePageController.updateStatus(_storedValue, "Pending");
                                                                    homePageController.updateStatusWithCollection(_storedValue, "Pending","vehicle");*/
                                                                  }catch(e){
                                                                    print(e);
                                                                  }





                                                                  showDialog(context: context, builder: (BuildContext context){
                                                                    return ShowConAlertDialog();
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
                                                                            "Submit",
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
                                                14.sp),
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
                                    Colors.lightGreen)))
                            :
                        //Fixed Auction Vehicle
                        Container(
                            margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                            width: 220.w,
                            height: 35.h,
                            child: ElevatedButton(

                                onPressed: () {

                                /*  homePageController.updateStatus(_storedValue, "Accepted");
                                  homePageController.updateStatusWithCollection(_storedValue, "Accepted","vehicle");*/


                                  Get.to(()=>HomePageView());
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
                                                14.sp),
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
                                    Colors.lightGreen)))
                    ),

                    IconButton(onPressed: (){
                      Get.to(()=>ChatScreen(recieverId: ""));
                    }, icon:Icon(Icons.chat))
                  ],
                ),
              ),

            if(_selectedValue=="Furniture")

              for(int index=0;index<allFurnitureData.length;index++)

            Container(
              margin: EdgeInsets.only(top:10.h,left:10.w,right: 10.w),

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0.r),
                  border: Border.all(color: Colors.black,width: 1)
              ),

              child:Column(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //----------------------Pic Box----------------------//

                  Container(
                    margin: EdgeInsets.only(left:0.w,top:0.h),


                    height: 180.h,
                    decoration: BoxDecoration(

                        image: DecorationImage(image: NetworkImage(allFurnitureData[index].imagePath),fit:BoxFit.cover),

                        border: Border(bottom: BorderSide(width: 1))
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                    child:  Text(
                      allFurnitureData[index].makingMaterial,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                    child:  Text(
                      "Condition",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                    child:  Text(
                      allFurnitureData[index].condition,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                    child:  Text(
                      "Type",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                    child:  Text(
                      allFurnitureData[index].selectType,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),



                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 7.w),
                        child: Icon(Icons.location_pin,color: Colors.red,),),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 3.w),
                        child:  Text(
                          allFurnitureData[index].cityName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 10.w),
                    child:  Text(
                      allFurnitureData[index].completeAddress,
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
                      allFurnitureData[index].description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                          child:  Text(
                            "Rs :",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          allFurnitureData[index].setBidPrice,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        //Bid now button
                        if(allFurnitureData[index].auctionType=="Biding")
                          Center(
                            child: Container(
                                margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                                width: 220.w,
                                height: 35.h,
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
                                                              style: TextStyle(color: Colors.black),
                                                              decoration: InputDecoration(

                                                                label: Text("Offer") ,
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
                                                                //-------------Ok Button Starts here

                                                                Container(
                                                                  width: 100.w,
                                                                  height: 40.h,
                                                                  margin: EdgeInsets.only(left:30.w),
                                                                  child: ElevatedButton(
                                                                    onPressed: () async{

                                                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                      String? userId=prefs.getString("docId"); //user id

                                                                      try{
                                                                      /*  homePageController.InsertOffer(_storedValue, "Furniture", _pricef, offer.text);
                                                                        homePageController.updateStatus(_storedValue, "Pending");
                                                                        homePageController.updateStatusWithCollection(_storedValue, "Pending","furniture");*/
                                                                      }catch(e){
                                                                        print(e);
                                                                      }





                                                                      showDialog(context: context, builder: (BuildContext context){
                                                                        return ShowConAlertDialog();
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
                                                                                "Submit",
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
                                                    14.sp),
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
                                        Colors.lightGreen))),
                          ),
                        if(allFurnitureData[index].auctionType=="Fixed Auction")
                          Center(
                            child: Container(
                                margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                                width: 220.w,
                                height: 35.h,
                                child: ElevatedButton(

                                    onPressed: () {

                                     /* homePageController.updateStatus(_storedValue, "Accepted");
                                      homePageController.updateStatusWithCollection(_storedValue, "Accepted","furniture");*/

                                      Get.to(()=>HomePageView());
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
                                                    14.sp),
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
                                        Colors.lightGreen))),
                          ),
                      ] ),
                  IconButton(onPressed: (){
                    Get.to(()=>ChatScreen(recieverId: ""));
                  }, icon:Icon(Icons.chat))
                ],
              ),
            ),

            if(_selectedValue=="Agriculture")

              for(int index=0;index<allAgricultureData.length;index++)

                Container(
                  margin: EdgeInsets.only(top:0.h,left:10.w,right: 10.w),

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.r),
                      border: Border.all(color: Colors.black,width: 1)
                  ),

                  child:Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //----------------------Pic Box----------------------//

                      Container(
                        margin: EdgeInsets.only(left:0.w,top:0.h),


                        height: 180.h,
                        decoration: BoxDecoration(

                            image: DecorationImage(image: NetworkImage(allAgricultureData[index].imagePath),fit:BoxFit.cover),

                            border: Border(bottom: BorderSide(width: 1))
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          allAgricultureData[index].typesCrops,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          allAgricultureData[index].workType,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          "Area Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          allAgricultureData[index].areaType,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          "Range",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          allAgricultureData[index].range,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),





                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 7.w),
                            child: Icon(Icons.location_pin,color: Colors.red,),),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 3.w),
                            child:  Text(
                              allAgricultureData[index].cityName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w),
                        child:  Text(
                          allAgricultureData[index].completeAddress,
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
                          allAgricultureData[index].description,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                              child:  Text(
                                "Rs :",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                            child:  Text(
                              allAgricultureData[index].setBidPrice,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                          child:  allAgricultureData[index].auctionType=="Biding"?
                          Container(
                              margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                              width: 220.w,
                              height: 35.h,
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
                                                            style: TextStyle(color: Colors.black),
                                                            decoration: InputDecoration(

                                                              label: Text("Offer") ,
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
                                                              //-------------Ok Button Starts here

                                                              Container(
                                                                width: 100.w,
                                                                height: 40.h,
                                                                margin: EdgeInsets.only(left:30.w),
                                                                child: ElevatedButton(
                                                                  onPressed: () async{

                                                                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                    String? userId=prefs.getString("docId"); //user id

                                                                    try{
                                                                     /* homePageController.InsertOffer(_storedValue, "Agriculture", _priceA, offer.text);
                                                                      homePageController.updateStatus(_storedValue, "Pending");
                                                                      homePageController.updateStatusWithCollection(_storedValue, "Pending","agriculture");*/
                                                                    }catch(e){
                                                                      print(e);
                                                                    }





                                                                    showDialog(context: context, builder: (BuildContext context){
                                                                      return ShowConAlertDialog();
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
                                                                              "Submit",
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
                                                  14.sp),
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
                                      Colors.lightGreen))):
                          //Fixed Auction Agriculture
                          Container(
                              margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                              width: 220.w,
                              height: 35.h,
                              child: ElevatedButton(

                                  onPressed: () {

                                   /* homePageController.updateStatus(_storedValue, "Accepted");
                                    homePageController.updateStatusWithCollection(_storedValue, "Accepted","agriculture");*/

                                    Get.to(()=>HomePageView());
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
                                                  14.sp),
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
                                      Colors.lightGreen)))
                      ),
                      IconButton(onPressed: (){
                        Get.to(()=>ChatScreen(recieverId: ""));
                      }, icon:Icon(Icons.chat))
                    ],
                  ),
                ),
            if(_selectedValue=="Real State")

              for(int index=0;index<allRealSateData.length;index++)
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child:   Container(
                    margin: EdgeInsets.only(top:0.h,left:10.w,right: 10.w),

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0.r),
                        border: Border.all(color: Colors.black,width: 1)
                    ),

                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //----------------------Pic Box----------------------//

                        Container(
                          margin: EdgeInsets.only(left:0.w,top:0.h),


                          height: 180.h,
                          decoration: BoxDecoration(

                              image: DecorationImage(image: NetworkImage(allRealSateData[index].imagePath),fit:BoxFit.cover),

                              border: Border(bottom: BorderSide(width: 1))
                          ),

                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                          child:  Text(
                            allRealSateData[index].selectType,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),





                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                          child:  Text(
                            "Area Type",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                          child:  Text(
                            allRealSateData[index].areaType,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                          child:  Text(
                            "Range",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                          child:  Text(
                            allRealSateData[index].range,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if(allRealSateData[index].selectType=="Residential Plot")
                          Column(
                            children: [

                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  "No floors",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  allRealSateData[index].noFloors,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  "No Bedrooms",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  allRealSateData[index].noBedrooms,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  "No Bathrooms",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  allRealSateData[index].noBathrooms,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 7.w),
                              child: Icon(Icons.location_pin,color: Colors.red,),),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 3.w),
                              child:  Text(
                                allRealSateData[index].cityName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, left: 10.w),
                          child:  Text(
                            allRealSateData[index].completeAddress,
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
                            allRealSateData[index].description,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  "Rs :",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                              child:  Text(
                                allRealSateData[index].setBidPrice,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Center(
                            child:  allRealSateData[index].auctionType=="Biding"?
                            Container(
                                margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                                width: 220.w,
                                height: 35.h,
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
                                                              style: TextStyle(color: Colors.black),
                                                              decoration: InputDecoration(

                                                                label: Text("Offer") ,
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
                                                                //-------------Ok Button Starts here

                                                                Container(
                                                                  width: 100.w,
                                                                  height: 40.h,
                                                                  margin: EdgeInsets.only(left:30.w),
                                                                  child: ElevatedButton(
                                                                    onPressed: () async{

                                                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                      String? userId=prefs.getString("docId"); //user id

                                                                      try{
                                                                       /* homePageController.InsertOffer(_storedValue, "RealState", _priceR, offer.text);
                                                                        homePageController.updateStatus(_storedValue, "Pending");
                                                                        homePageController.updateStatusWithCollection(_storedValue, "Pending","realState");*/
                                                                      }catch(e){
                                                                        print(e);
                                                                      }





                                                                      showDialog(context: context, builder: (BuildContext context){
                                                                        return ShowConAlertDialog();
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
                                                                                "Submit",
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
                                                    14.sp),
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
                                        Colors.lightGreen))):
                            //Fixed Auction real State

                            Container(
                                margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                                width: 220.w,
                                height: 35.h,
                                child: ElevatedButton(

                                    onPressed: () {

                                    /*  homePageController.updateStatus(_storedValue, "Accepted");
                                      homePageController.updateStatusWithCollection(_storedValue, "Accepted","realState");*/
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
                                                    14.sp),
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
                                        Colors.lightGreen)))
                        ),

                      ],
                    ),
                  ),

                ),


          ],
        ))

            :

        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  //progressIndicator


                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.h, bottom: 0.h, left: 30.w),
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

                      margin: EdgeInsets.only(top: 10.h, left: 30.w),
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
                                  Text(e,
                                    style: TextStyle(color: Colors.black),),
                                  value: e);
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedValue = newValue as String;
                              });
                            },
                            isExpanded: true,
                          ))),

                  if( _selectedValue == "Furniture")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [


//----------------------------------------------Ist drop down
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5.h, left: 30.w, bottom: 0.h),
                            child: Text(
                              "Making Material",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Container(
                            width: 300.w,

                            margin: EdgeInsets.only(top: 5.h, left: 30.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: <BoxShadow>[]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedValuemMakingMaterial,
                                  items: makingMaterial.map((e) {
                                    return DropdownMenuItem(child: Text(e,
                                      style: TextStyle(color: Colors.black),),
                                        value: e);
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValuemMakingMaterial =
                                      newValue as String;
                                    });
                                  },
                                  isExpanded: true,
                                ))),


                        //--------------------------Condition Drop Down---------------//


                        //------------------------------Select Types
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5.h, left: 30.w, bottom: 0.h),
                            child: Text(
                              "Select Type",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Container(
                            width: 300.w,

                            margin: EdgeInsets.only(top: 5.h, left: 30.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: <BoxShadow>[]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedValueSelectTypes,
                                  items: selectTypes.map((e) {
                                    return DropdownMenuItem(child: Text(e,
                                      style: TextStyle(color: Colors.black),),
                                        value: e);
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValueSelectTypes =
                                      newValue as String;
                                    });
                                  },
                                  isExpanded: true,
                                ))),

                        //--------------------Auction type=------------------/


                      ],),

                  if( _selectedValue == "Vehicle")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [

                        //------------------------------Vehicle Type---------------//
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5.h, left: 30.w, bottom: 0.h),
                            child: Text(
                              "Vehicle Type",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Container(
                            width: 300.w,

                            margin: EdgeInsets.only(top: 5.h, left: 30.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: <BoxShadow>[]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedValueVehicleType,
                                  items: vehicleType.map((e) {
                                    return DropdownMenuItem(child: Text(e,
                                      style: TextStyle(color: Colors.black),),
                                        value: e);
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValueVehicleType =
                                      newValue as String;
                                    });
                                  },
                                  isExpanded: true,
                                ))),


                        Padding(
                            padding: EdgeInsets.only(
                                top: 5.h, left: 30.w, bottom: 5.h),
                            child: Text(
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

                          margin: EdgeInsets.only(top: 0.h, left: 30.w),
                          child: TextFormField(
                            controller: vehicleName,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(

                              label: Text("Vehicle Name"),
                              prefixIcon: Icon(Icons.title_outlined),
                              border: OutlineInputBorder(),

                            ),),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 30.w,),
                            child: Text(
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

                          margin: EdgeInsets.only(top: 5.h, left: 30.w),
                          child: TextFormField(
                            controller: modelNo,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(

                              label: Text("Model No"),
                              prefixIcon: Icon(Icons.description),
                              border: OutlineInputBorder(),

                            ),),
                        ),


                      ],),


                  if( _selectedValue == "Agriculture")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [


                        //---------------------------------Type---------------//
                        Padding(
                            padding: EdgeInsets.only(
                                top: 5.h, left: 30.w, bottom: 0.h),
                            child: Text(
                              "Types of Crops",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Container(
                            width: 300.w,

                            margin: EdgeInsets.only(top: 5.h, left: 30.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: <BoxShadow>[]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedValueAgricultureType,
                                  items: agricultureType.map((e) {
                                    return DropdownMenuItem(child: Text(e,
                                      style: TextStyle(color: Colors.black),),
                                        value: e);
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValueAgricultureType =
                                      newValue as String;
                                    });
                                  },
                                  isExpanded: true,
                                ))),

                        //------------------------Work Type-------------------------------//

                        Padding(
                            padding: EdgeInsets.only(
                                top: 5.h, left: 30.w, bottom: 0.h),
                            child: Text(
                              "Work type",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Container(
                            width: 300.w,

                            margin: EdgeInsets.only(top: 5.h, left: 30.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: <BoxShadow>[]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedValueWorkType,
                                  items: workType.map((e) {
                                    return DropdownMenuItem(child: Text(e,
                                      style: TextStyle(color: Colors.black),),
                                        value: e);
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValueWorkType =
                                      newValue as String;
                                    });
                                  },
                                  isExpanded: true,
                                ))),

                        //--------------------------------Area Type-------------------//


                      ],),

                  if( _selectedValue == "Real State")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [
                        Container(
                            width: 300.w,

                            margin: EdgeInsets.only(top: 5.h, left: 30.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: <BoxShadow>[]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  value: _selectedValueType,
                                  items: type.map((e) {
                                    return DropdownMenuItem(child: Text(e,
                                      style: TextStyle(color: Colors.black),),
                                        value: e);
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
                            padding: EdgeInsets.only(
                                top: 5.h, left: 30.w, bottom: 0.h),
                            child: Text(
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

                                margin: EdgeInsets.only(top: 5.h, left: 30.w),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black38, width: 1),
                                    borderRadius: BorderRadius.circular(5.r),
                                    boxShadow: <BoxShadow>[]),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      value: _selectedValueAreaType,
                                      items: areaType.map((e) {
                                        return DropdownMenuItem(child: Text(e,
                                          style: TextStyle(
                                              color: Colors.black),), value: e);
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedValueAreaType =
                                          newValue as String;
                                        });
                                      },
                                      isExpanded: true,
                                    ))),
                            Container(
                              width: 145.w,
                              height: 35.h,

                              margin: EdgeInsets.only(top: 5.h, left: 5.w),
                              child: TextFormField(
                                controller: range,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(

                                  label: Text("Range"), prefixIcon: Icon(Icons
                                    .date_range),
                                  border: OutlineInputBorder(),

                                ),),
                            ),

                          ],
                        ),

                      ],),

                  if( _selectedValue == "Other")
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
                                    padding: EdgeInsets.only(
                                        top: 5.h, left: 30.w, bottom: 0.h),
                                    child: Text(
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

                                  margin: EdgeInsets.only(top: 0.h, left: 30.w),
                                  child: TextFormField(
                                    controller: categoryName,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(

                                      label: Text("Category Name"),
                                      prefixIcon: Icon(Icons.category),
                                      border: OutlineInputBorder(),

                                    ),),
                                ),


                                //--------------------------Condition Drop Down---------------//
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 5.h, left: 30.w, bottom: 0.h),
                                    child: Text(
                                      "Condition",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                Container(
                                    width: 300.w,

                                    margin: EdgeInsets.only(
                                        top: 5.h, left: 30.w),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors
                                            .black38, width: 1),
                                        borderRadius: BorderRadius.circular(5
                                            .r),
                                        boxShadow: <BoxShadow>[]),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: _selectedValueCondition,
                                          items: condition.map((e) {
                                            return DropdownMenuItem(child: Text(
                                              e, style: TextStyle(
                                                color: Colors.black),),
                                                value: e);
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedValueCondition =
                                              newValue as String;
                                            });
                                          },
                                          isExpanded: true,
                                        ))),

                                //--------------------Auction type=------------------/


                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 5.h, left: 30.w, bottom: 0.h),
                                    child: Text(
                                      "Auction Type",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                                Container(
                                    width: 300.w,

                                    margin: EdgeInsets.only(
                                        top: 5.h, left: 30.w),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors
                                            .black38, width: 1),
                                        borderRadius: BorderRadius.circular(5
                                            .r),
                                        boxShadow: <BoxShadow>[]),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: _selectedValueAuctionType,
                                          items: auctionType.map((e) {
                                            return DropdownMenuItem(child: Text(
                                              e, style: TextStyle(
                                                color: Colors.black),),
                                                value: e);
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedValueAuctionType =
                                              newValue as String;
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
                      padding: EdgeInsets.only(
                          top: 5.h, left: 30.w, bottom: 5.h),
                      child: Text(
                        "Price.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  Container(
                    width: 300.w,
                    height: 35.h,

                    margin: EdgeInsets.only(top: 0.h, left: 30.w),
                    child: TextFormField(
                      controller: price,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(

                        label: Text("Set Price"),
                        prefixIcon: Icon(Icons.price_change),
                        border: OutlineInputBorder(),

                      ),),
                  ),


                  Center(
                    child: _isLoading
                        ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CircularProgressIndicator(),
                    ) // Show CircularProgressIndicator when loading
                        : Container(),),
//-------------------------------------------------------//
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.h, left: 20.w),
                          height: 40.h,
                          width: 100.w,
                          child: ElevatedButton(onPressed:
                              () async {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) {
                              return SearchFilterView();
                            }));
                          }, child: Text("Reset", style: TextStyle(color: Colors
                              .white),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r))
                            ),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.h, left: 20.w),
                          height: 40.h,
                          width: 100.w,
                          child: ElevatedButton(onPressed:
                              () async {
                            Get.offAll(() => HomePageView());
                          },
                            child: Text("Cancel", style: TextStyle(color: Colors
                                .white),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r))
                            ),),
                        ),


                        Container(
                          margin: EdgeInsets.only(top: 20.h, left: 10.w),
                          height: 40.h,
                          width: 100.w,
                          child: ElevatedButton(onPressed: () async {

                            if(_selectedValue=="Vehicle"){
                              _filterVehicle(_selectedValueVehicleType,vehicleName.text,modelNo.text,price.text);
                              setState(() {
                                vehicleQuery=vehicleName.text;

                              });
                            }

                            if(_selectedValue=="Furniture"){
                              _filterFurniture(_selectedValuemMakingMaterial,_selectedValueSelectTypes,price.text);
                                setState(() {
                                     furnitureQuery=_selectedValueSelectTypes;

                                   });}

                            if(_selectedValue=="Agriculture"){
                              _filterAgriculture(_selectedValueAgricultureType, _selectedValueWorkType, price.text);
                              setState(() {
                                agricultureQuery=_selectedValueAgricultureType;

                              });}


                            if(_selectedValue=="Real State"){
                             _filterRealEstate(_selectedValueType,_selectedValueAreaType,range.text, price.text);
                              setState(() {
                                realEstateQuery=_selectedValueAgricultureType;

                              });}





                          }
                            ,
                            child: Text("Search", style: TextStyle(color: Colors
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

class ShowConAlertDialog extends StatefulWidget{
  @override
  State<ShowConAlertDialog > createState() => _ShowConAlertDialogState();
}

class _ShowConAlertDialogState extends State<ShowConAlertDialog > {
  @override
  Widget build(BuildContext context) {

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
                margin: EdgeInsets.only(left:10.w),
                width: 100.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder:
                                (context) =>
                                HomePageView()));

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



  }
}
