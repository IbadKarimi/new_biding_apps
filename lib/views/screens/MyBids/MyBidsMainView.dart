


import 'package:biding_app/controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../controllers/AgricultureController.dart';
import '../../../controllers/FurnitureController.dart';
import '../../../controllers/RealStateController.dart';
import '../../../controllers/VehicleController.dart';
import '../../../model/AgricultureModel.dart';
import '../../../model/FurnitureModel.dart';
import '../../../model/RealStateModel.dart';
import '../../../model/VehicleModel.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';
import 'MyBids.dart';




//---------Vehicle-------//
String _docId="";
String vehicleName="";
String cityName="";
String ?imagePath;
String description="";
String price="";
String completeAddress="";
String condtion="";
String enginePower="";
String ?model;
String registerYear="";
String registerArea="";
String vehicleType="";

//----------Furniture------//
String _buyerDocIdf="";
String _makingMaterialf="";
String _conditionf="";
String _selectTypef="";
String _auctionTypef="";
String _setBidPricef="";
String _setBidEndTimef="";

String _statusf="";

String _remainingTimef="";
String _cityNamef="";
String? _imagePathf;
String _descriptionf="";
String _pricef="";
String _completeAddressf="";



//------------Agriculture-------//

String? id;
String _typesCropsA="";
String _workTypeA="";
String _areaTypeA="";
String _rangeA="";
String _cityNameA="";
String _imagePathA="";
String _descriptionA="";
String _priceA="";
String _completeAddressA="";

String categoryName="";


//-----------RealEstate---------//

String noFloors="";
String noBedrooms="";
String noBathrooms="";
String _selectTypeR="";
String _areaTypeR="";
String _imagePathR="";
String _rangeR="";

String _priceR="";
String _completeAddressR="";
String _cityNameR="";
String _descriptionR="";



//-----------------------------------------//

class MyBidsMainView extends StatefulWidget{

  @override
  State<MyBidsMainView> createState() => _MyBidsMainViewState ();
}

class _MyBidsMainViewState extends State<MyBidsMainView> {
  //---------Vehicle-------//
  String _docId="";
  String vehicleName="";
  String cityName="";
  String? imagePath;
  String description="";
  String price="";
  String completeAddress="";
  String condtion="";
  String enginePower="";
  String? model;
  String registerYear="";
  String registerArea="";
  String vehicleType="";

//----------Furniture------//
  String _buyerDocIdf="";
  String _makingMaterialf="";
  String _conditionf="";
  String _selectTypef="";
  String _auctionTypef="";
  String _setBidPricef="";
  String _setBidEndTimef="";

  String _statusf="";

  String _remainingTimef="";
  String _cityNamef="";
  String? _imagePathf;
  String _descriptionf="";
  String _pricef="";
  String _completeAddressf="";



//------------Agriculture-------//

  String ?id;
  String _typesCropsA="";
  String _workTypeA="";
  String _areaTypeA="";
  String _rangeA="";
  String _cityNameA="";
  String ?_imagePathA;
  String _descriptionA="";
  String _priceA="";
  String _completeAddressA="";

  String categoryName="";


//-----------RealEstate---------//

  String noFloors="";
  String noBedrooms="";
  String noBathrooms="";
  String _selectTypeR="";
  String _areaTypeR="";
  String? _imagePathR;
  String _rangeR="";

  String _priceR="";
  String _completeAddressR="";
  String _cityNameR="";
  String _descriptionR="";

  HomePageController homePageController=HomePageController();
  SharedPreferences? _prefs;
  String _storedValue = "";
  String _categoryName="";
  String _auctionType="";
  bool _isLoading = false;





  Future<void> _loadStoredValue() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = _prefs!.getString('id')!;
      _isLoading = true;
      _auctionType=_prefs!.getString("auctionType")!;

      _categoryName= _prefs!.getString("categoryName")!;
      print("Categoriiiiiiiiiiiies name +"+ _categoryName.toString()+_storedValue);
      if(_categoryName=="RealState"){
        realStateController.getRealEstateById(_storedValue ).then((value) {
          setState(() {
            dataRealState.addAll(value);

            _selectTypeR=dataRealState[0].selectType.toString();
            _areaTypeR=dataRealState[0].areaType.toString();
            _rangeR=dataRealState[0].range.toString();


            noBedrooms=dataRealState[0].noBedrooms.toString();
            noBathrooms=dataRealState[0].noBathrooms.toString();
            noFloors=dataRealState[0].noFloors.toString();



            _imagePathR=dataRealState[0].imagePath.toString();

            _priceR=dataRealState[0].setBidPrice.toString();
            _cityNameR=dataRealState[0].cityName.toString();
            _completeAddressR=dataRealState[0].completeAddress.toString();
            _descriptionR=dataRealState[0].description.toString();
            _isLoading = true;

          });
        });
      }


      if(_categoryName=="Vehicle") {
        vehicleController.getVehicleById(_storedValue).then((value) {
          setState(() {
            data.addAll(value);
            vehicleName = data[0].vehicleName.toString();
            vehicleType = data[0].vehicleType.toString();
            condtion = data[0].condition.toString();
            model = data[0].model.toString();
            registerYear = data[0].registerYear.toString();
            registerArea = data[0].registerArea.toString();
            cityName = data[0].cityName.toString();
            description = data[0].description.toString();
            price = data[0].setBidPrice.toString();
            imagePath = data[0].imagePath.toString();
            enginePower = data[0].enginePower.toString();
            completeAddress = data[0].completeAddress.toString();
            if(imagePath==null)
              _isLoading = true;
          });
        });
      }
      if(_categoryName=="Furniture"){
        furnitureController.getFurnitureById(_storedValue).then((value) {
          setState(() {
            dataFurniture.addAll(value);
            _imagePathf=dataFurniture[0].imagePath.toString();
            _makingMaterialf=dataFurniture[0].makingMaterial.toString();
            _conditionf=dataFurniture[0].condition.toString();
            _selectTypef=dataFurniture[0].selectType.toString();

            _imagePathf=dataFurniture[0].imagePath.toString();

            _pricef=dataFurniture[0].setBidPrice.toString();
            _cityNamef=dataFurniture[0].cityName.toString();
            _completeAddressf=dataFurniture[0].completeAddress.toString();
            _descriptionf=dataFurniture[0].description.toString();

            if(_imagePathf==null)
              _isLoading = true;

          });
        });
      }
      if(_categoryName=="Agriculture"){
        agricultureController.getAgricultureById(_storedValue).then((value) {
          setState(() {
            dataAgriculture.addAll(value);

            _typesCropsA=dataAgriculture[0].typesCrops.toString();
            _workTypeA=dataAgriculture[0].workType.toString();
            _areaTypeA=dataAgriculture[0].workType.toString();
            _rangeA=dataAgriculture[0].range.toString();
            _imagePathA=dataAgriculture[0].imagePath.toString();
            _priceA=dataAgriculture[0].setBidPrice.toString();
            _cityNameA=dataAgriculture[0].cityName.toString();
            _completeAddressA=dataAgriculture[0].completeAddress.toString();
            _descriptionA=dataAgriculture[0].description.toString();



          });
        });
      }






    });
  }

  VehicleController vehicleController=VehicleController();
  FurnitureController furnitureController=FurnitureController();
  AgricultureController agricultureController=AgricultureController();
  RealStateController realStateController=RealStateController();

  List<VehicleModel> data=[];
  List<FurnitureModel> dataFurniture=[];
  List<AgricultureModel> dataAgriculture=[];
  List<RealStateModel> dataRealState=[];

  int index=0;


  void initState()  {
    super.initState();
    _loadStoredValue() ;


  }

  TextEditingController offer=TextEditingController();



  @override
  Widget build(BuildContext context) {

    print("Category Name is "+ _categoryName.toString());
    print("image path is "+_auctionType.toString());
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      drawer: CustomDrawer(),
      body:      _imagePathR==null&&imagePath==null&&_imagePathA==null&&_imagePathf==null ?

    Center(child: Padding(
        padding: const EdgeInsets.only(top:30),
        child: CircularProgressIndicator(),
      ))
          :SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:

        Column(
          children:[
            if(_categoryName=="Vehicle")
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

                          image: DecorationImage(image: NetworkImage(imagePath.toString()),fit:BoxFit.cover),

                          border: Border(bottom: BorderSide(width: 1))
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        vehicleName,
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
                        vehicleType,
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
                        condtion,
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
                        model!,
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
                        registerYear,
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
                        registerArea,
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
                            cityName,
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
                        completeAddress,
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
                        description,
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
                            price,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //first button
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        "This Bid is Accepted by You !",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if(_categoryName=="Furniture")
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

                          image: DecorationImage(image: NetworkImage(_imagePathf.toString()),fit:BoxFit.cover),

                          border: Border(bottom: BorderSide(width: 1))
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        _makingMaterialf,
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
                        _conditionf,
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
                        _selectTypef,
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
                            _cityNamef,
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
                        _completeAddressf,
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
                        _descriptionf,
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
                            _pricef,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        "This Bid is Accepted",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if(_categoryName=="Agriculture")
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

                          image: DecorationImage(image: NetworkImage(_imagePathA.toString()),fit:BoxFit.cover),

                          border: Border(bottom: BorderSide(width: 1))
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        _typesCropsA,
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
                        _workTypeA,
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
                        _areaTypeA,
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
                        _rangeA,
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
                            _cityNameA,
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
                        _completeAddressA,
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
                        _descriptionA,
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
                            _priceA,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                      child:  Text(
                        "This Bid is Accepted",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if(_categoryName=="RealState")
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

                            image: DecorationImage(image: NetworkImage(_imagePathR.toString()),fit:BoxFit.cover),

                            border: Border(bottom: BorderSide(width: 1))
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          _selectTypeR,
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
                          vehicleType,
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
                          _areaTypeR,
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
                          _rangeR,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if(_selectTypeR=="Residential Plot")
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
                                noFloors,
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
                                noBedrooms,
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
                                noBathrooms,
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
                              _cityNameR,
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
                          _completeAddressR,
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
                          _descriptionR,
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
                              _priceR,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                        child:  Text(
                          "This Bid is Accepted",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ),

          ],
        ),


      ),
    );

  }
}




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
                      "This Bid is Accepted by You ",
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
                                MyBidsView()));

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