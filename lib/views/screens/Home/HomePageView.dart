

import 'dart:async';

import 'package:biding_app/model/HomePageModel.dart';
import 'package:biding_app/views/screens/Admin/AddAgriculture.dart';
import 'package:biding_app/views/screens/Aggriculture/AggricultureView.dart';
import 'package:biding_app/views/screens/Furniture/FurnitureView.dart';
import 'package:biding_app/views/screens/Home/BidsMainView.dart';
import 'package:biding_app/views/screens/RealState/RealStateView.dart';
import 'package:biding_app/views/screens/Vehicle/VehiclesView.dart';
import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovering/hovering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/AgricultureController.dart';
import '../../../controllers/FurnitureController.dart';
import '../../../controllers/HomeController.dart';
import '../../../controllers/RealStateController.dart';
import '../../../controllers/VehicleController.dart';
import '../../../model/AgricultureModel.dart';
import '../../../model/FurnitureModel.dart';
import '../../../model/RealStateModel.dart';
import '../../../model/VehicleModel.dart';

class HomePageView extends StatefulWidget{
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {


  @override





  String onTapAuctionType="Biding";

  @override
  FurnitureController  furnitureController=FurnitureController();
  AgricultureController  agricultureController=AgricultureController();
  RealStateController realStateController=RealStateController();
  VehicleController vehicleController=VehicleController();

  HomePageController homePageController=HomePageController();


  List<HomePageModel> data=[];

  List<HomePageModel> bidingData=[];

  List<HomePageModel> fixedAuctionData=[];

  List<FurnitureModel> furniture=[];


  List<RealStateModel> realState=[];



  List<VehicleModel> vehicle=[];


  List<AgricultureModel> agriculture=[];



void sortingData(){

  bidingData = data.where((item) =>
  item.auctionType.contains("Biding")).toList();
  fixedAuctionData = data.where((item) => item.auctionType.contains("Fixed Auction")).toList();




  for(int i=0;i<bidingData.length;i++){
    print("Auction Type is "+i.toString() +":"+bidingData[i].auctionType.toString());
  }

  for(int i=0;i< fixedAuctionData .length;i++){
    print("Auction Type is "+i.toString() +":"+ fixedAuctionData [i].auctionType.toString());
  }

}

  void initState() {
    super.initState();


    homePageController.getCategoriesData().then((value) {
      setState(() {
        data.addAll(value);
        sortingData();

      });
    });

    furnitureController.getFurniture().then((value) {
      setState(() {
        furniture.addAll(value);
      });
    });

    realStateController.getrealState().then((value) {
      setState(() {
        realState.addAll(value);
      });
    });

    vehicleController.getVehicle().then((value) {
      setState(() {
        vehicle.addAll(value);
      });
    });

    agricultureController.getAgriculture().then((value) {
      setState(() {
        agriculture.addAll(value);
      });
    });
  }





  TextEditingController offer=TextEditingController();
  TextEditingController search=TextEditingController();



  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomAppBar(),
     bottomNavigationBar: CustomBottomNavigationBar(),
     drawer: CustomDrawer(),
     body:   Padding(
         padding: const EdgeInsets.only(top: 10),
         child:   CustomScrollView(
             scrollDirection: Axis.vertical,
             slivers: [
               SliverList(
                 delegate: SliverChildListDelegate([
                   //------------Buttons Fixed Price ----------//
                   Row(
                     children: [
                       GestureDetector(
                         onTap: (){
                           setState(() {
                             onTapAuctionType="Biding";
                           });
                         },
                         child: Container(
                           margin: EdgeInsets.only(left:20.w,top:20.h),
                           width: 150.w,height: 40,
                           child: Center(child: Text("Bid")),
                           decoration: BoxDecoration(
                               color: Colors.grey.shade300,
                               borderRadius: BorderRadius.circular(10)),
                         ),
                       ),
               GestureDetector(
                 onTap: (){
                   setState(() {
                     onTapAuctionType="Fixed Auction";
                   });
                 },
                 child:Container(
                         margin: EdgeInsets.only(left:20.w,top:20.h),
                         width: 150.w,
                         height: 40,
                         child: Center(child: Text("Fixed Price",style: TextStyle(color: Colors.white),)),
                         decoration: BoxDecoration(
                             color: Colors.black,
                             borderRadius: BorderRadius.circular(10)),
                       ),
               )],
                   ),

                   Padding(
                     padding:EdgeInsets.only(left:10.w,top:10.h),
                     child: Text("Latest Bidding",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14.sp),),
                   ),
                   //---------------------------Lates Bidding Form
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Padding(
                       padding:  EdgeInsets.only(left:5.w),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           for(int i=0;i<bidingData.length;i++)
                             if(bidingData[i].status=="Pending")

                             GestureDetector(
                               onTap: ()async{
                                 final SharedPreferences prefs = await SharedPreferences.getInstance();
                                 prefs.setString("id", bidingData[i].docId.toString());  // seller Id
                                 prefs.setString("auctionType", bidingData[i].auctionType);
                                 prefs.setString("categoryName", bidingData[i].categoryType.toString());

                                 String id="";
                                 id=prefs.getString("id");
                                 String categoryName="";
                                 categoryName= prefs.getString("categoryName");
                                 print("Category Type is "+bidingData[i].auctionType.toString());

                                 if(id!=null){
                                  Get.to(()=>BidsMainView());
                                 }
                               },
                               child: Container(
                                 margin: EdgeInsets.only(left:5.w,top:20.h,bottom: 10.h),
                                 alignment: AlignmentDirectional.center,
                                 width:150.w,
                                 height:280.h,

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

                                       width:150.w,
                                       height: 100.h,
                                       decoration: BoxDecoration(
                                           image: DecorationImage(image: NetworkImage(bidingData[i].imagePath,),fit:BoxFit.cover),

                                           border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                                       ),

                                     ),
                                     Center(
                                       child: Container(
                                           margin: EdgeInsets.only(top:5.h),
                                           width: 100.w,
                                           height: 15.h,
                                           child:MyCountdownWidget(
                                             bidEndTime: bidingData[i].setBidEndTime.toString(),
                                             index: i,
                                             onTimerEnd: (int index) {
                                               setState(() {
                                                 bidingData.removeAt(index);
                                                 bidingData.sort(); // Sort the list based on bidding end times
                                               });
                                             },
                                           ),),
                                     ),

                                     Padding(
                                       padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                       child:  Text(
                                         bidingData[i].categoryName,
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 12.sp,
                                           fontWeight: FontWeight.w700,
                                         ),
                                       ),
                                     ),
                                     Row(
                                       children: [
                                         Padding(
                                           padding: EdgeInsets.only( left: 7.w),
                                           child: Icon(Icons.location_pin,color: Colors.red,),),
                                         Padding(
                                           padding: EdgeInsets.only(top: 5.h, left: 3.w),
                                           child:  Text(
                                             bidingData[i].city,
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontSize: 10.sp,
                                               fontWeight: FontWeight.w600,
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                     Padding(
                                       padding: EdgeInsets.only(top: 0.h, left: 10.w),
                                       child:  Text(
                                         bidingData[i].description,
                                         style: TextStyle(
                                           color: Colors.grey,
                                           fontSize: 10.sp,
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                     ),

                                     Row(
                                       children: [
                                         Padding(
                                             padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                             child:  Text(
                                               "RS :",
                                               style: TextStyle(
                                                 color: Colors.black,
                                                 fontSize: 12.sp,
                                                 fontWeight: FontWeight.w600,
                                               ),
                                             )),
                                         Padding(
                                           padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                           child:  Text(
                                             bidingData[i].price,
                                             style: TextStyle(
                                               color: Colors.green,
                                               fontSize: 12.sp,
                                               fontWeight: FontWeight.w600,
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),

                                   ],
                                 ),
                               ),
                             ),
                         ],),
                     ),
                   ),

                   //-------------------------Categories button===========//
                   Padding(
                     padding:EdgeInsets.only(left:10.w,top:0.h),
                     child: Text("Catergory",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14.sp),),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       GestureDetector(
                           onTap: (){
                             Get.to(()=>VehicleView());
                           },
                           child:Container(
                             margin: EdgeInsets.only(left:10.w,top:10.h,),
                             width: 70.w,height: 80.h,
                             decoration: BoxDecoration(
                               color: Colors.amber,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Icon(Icons.car_rental,size: 40,),)),

                       GestureDetector(
                         onTap: (){
                           Get.to(()=>FurnitureView());
                         },
                         child: Container(
                           margin: EdgeInsets.only(left:10.w,top:10.h),
                           width: 70.w,height: 80.h,
                           decoration: BoxDecoration(
                             color: Colors.amber,
                             borderRadius: BorderRadius.circular(10),
                           ),
                           child: Icon(Icons.table_restaurant_sharp,size: 40,),),
                       ),
                       GestureDetector(
                           onTap: (){
                             Get.to(()=>AgricultureView());
                           },
                           child:Container(
                             margin: EdgeInsets.only(left:10.w,top:10.h),
                             width: 70.w,height: 80.h,
                             decoration: BoxDecoration(
                               color: Colors.amber,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Icon(Icons.agriculture,size: 40,),)),
                       GestureDetector(
                           onTap: (){
                             Get.to(()=>RealStateView());
                           },
                           child:Container(
                             margin: EdgeInsets.only(left:10.w,top:10.h),
                             width: 70.w,height: 80.h,
                             decoration: BoxDecoration(
                               color: Colors.amber,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Icon(Icons.real_estate_agent,size: 40,),)),
                     ],),


                   //--------------------------Latest Text---------------------//
                   Padding(
                     padding:EdgeInsets.only(left:10.w,top:10.h,bottom: 10.h),
                     child: Text("Most Popular",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14.sp),),
                   ),

                 ]),
               ),

               SliverGrid(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       childAspectRatio:(3.3/5.3),
                       crossAxisSpacing: 10.w,
                       mainAxisSpacing: 10.h

                   ),

                   delegate: SliverChildBuilderDelegate(
                           (context, index) {



                         return
                           Container(
                           child:onTapAuctionType=="Biding"?
                             GestureDetector(
                               onTap:()async{
                                 final SharedPreferences prefs = await SharedPreferences.getInstance();
                                 prefs.setString("id", bidingData[index].docId.toString());
                                 prefs.setString("categoryName", bidingData[index].categoryType.toString());
                                 prefs.setString("auctionType", bidingData[index].auctionType);

                                 String id="";
                                 id=prefs.getString("id");
                                 String categoryName="";
                                 categoryName= prefs.getString("categoryName");
                                 print("Category Type is "+categoryName.toString());

                                 if(id!=null){
                                   Get.to(()=>BidsMainView());
                                 }
                               },
                               child: Container(
                                 margin: EdgeInsets.only(top:0.h,left:10.w,right: 10.w),
                                 width:160.w,
                                 decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(0.r),
                                     border: Border.all(color: Colors.black,width: 1)
                                 ),

                                 child:Column(
                                   mainAxisAlignment:MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [


                                      Container(
                                        margin: EdgeInsets.only(left:0.w,top:0.h),

                                        width:200.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(

                                            image: DecorationImage(image: NetworkImage(bidingData[index].imagePath,),fit:BoxFit.cover),

                                            border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                                        ),

                                      ),
                                     Center(
                                       child: Container(
                                         margin: EdgeInsets.only(top:5.h),
                                         width: 100.w,
                                         height: 15.h,
                                         child:MyCountdownWidget(
                                           bidEndTime: bidingData[index].setBidEndTime.toString(),
                                           index: index,
                                           onTimerEnd: (int index) {
                                             setState(() {
                                               bidingData.removeAt(index);
                                               bidingData.sort(); // Sort the list based on bidding end times
                                             });
                                           },
                                         ),),
                                     ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                        child:  Text(
                                          bidingData[index].name,
                                          style: TextStyle(
                                            color: Colors.black,
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
                                              bidingData[index].city,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.h, left: 10.w),
                                        child:  Text(
                                          bidingData[index].description,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                        child:  Text(
                                          "Price",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                              child:  Text(
                                                "RS :",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                            child:  Text(
                                              bidingData[index].price,
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                     //----------------------Pic Box----------------------//



                                   ],
                                 ),
                               ),
                             ):

                               GestureDetector(
                                 onTap:()async{
                                   final SharedPreferences prefs = await SharedPreferences.getInstance();
                                   prefs.setString("id", fixedAuctionData[index].docId.toString());
                                   prefs.setString("categoryName", fixedAuctionData[index].categoryName.toString());
                                   prefs.setString("auctionType", fixedAuctionData[index].auctionType);

                                   String id="";
                                   id=prefs.getString("id");
                                   String categoryName="";
                                   categoryName= prefs.getString("categoryName");
                                   print("Category Type is "+categoryName.toString());

                                   if(id!=null){
                                     Get.to(()=>BidsMainView());
                                   }

                                 },
                                 child: Container(
                                   margin: EdgeInsets.only(top:0.h,left:10.w,right: 10.w),
                                   width:160.w,
                                   decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(0.r),
                                       border: Border.all(color: Colors.black,width: 1)
                                   ),

                                   child:Column(
                                     mainAxisAlignment:MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [


                                       Container(
                                         margin: EdgeInsets.only(left:0.w,top:0.h),

                                         width:200.w,
                                         height: 80.h,
                                         decoration: BoxDecoration(

                                             image: DecorationImage(image: NetworkImage(fixedAuctionData[index].imagePath,),fit:BoxFit.cover),

                                             border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                                         ),

                                       ),
                                       Center(
                                         child: Container(
                                           margin: EdgeInsets.only(top:5.h),
                                           width: 100.w,
                                           height: 15.h,
                                           child:MyCountdownWidget(
                                             bidEndTime: fixedAuctionData[index].setBidEndTime.toString(),
                                             index: index,
                                             onTimerEnd: (int index) {
                                               setState(() {
                                                 fixedAuctionData.removeAt(index);
                                                 fixedAuctionData.sort(); // Sort the list based on bidding end times
                                               });
                                             },
                                           ),),
                                       ),
                                       Padding(
                                         padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                         child:  Text(
                                           fixedAuctionData[index].name,
                                           style: TextStyle(
                                             color: Colors.black,
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
                                               fixedAuctionData[index].city,
                                               style: TextStyle(
                                                 color: Colors.black,
                                                 fontSize: 10.sp,
                                                 fontWeight: FontWeight.w500,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       Padding(
                                         padding: EdgeInsets.only(top: 5.h, left: 10.w),
                                         child:  Text(
                                           fixedAuctionData[index].description,
                                           style: TextStyle(
                                             color: Colors.grey,
                                             fontSize: 10.sp,
                                             fontWeight: FontWeight.w500,
                                           ),
                                         ),
                                       ),
                                       Padding(
                                         padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                         child:  Text(
                                           "Price",
                                           style: TextStyle(
                                             color: Colors.black,
                                             fontSize: 12.sp,
                                             fontWeight: FontWeight.w600,
                                           ),
                                         ),
                                       ),
                                       Row(
                                         children: [
                                           Padding(
                                               padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                               child:  Text(
                                                 "RS :",
                                                 style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize: 12.sp,
                                                   fontWeight: FontWeight.w600,
                                                 ),
                                               )),
                                           Padding(
                                             padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                             child:  Text(
                                               fixedAuctionData[index].price,
                                               style: TextStyle(
                                                 color: Colors.green,
                                                 fontSize: 12.sp,
                                                 fontWeight: FontWeight.w600,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),

                                       //----------------------Pic Box----------------------//



                                     ],
                                   ),
                                 ),
                               ),

                         );
                       },
                       childCount:onTapAuctionType=="Biding"?bidingData.length:fixedAuctionData.length
                   )
               ),
             ])),
   );
  }

}



class CustomAlertDialog extends StatefulWidget{
  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
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



class MyCountdownWidget extends StatefulWidget {
  final String bidEndTime;
  final int index;

  final Function(int) onTimerEnd; // Define the callback function

  MyCountdownWidget({Key key, @required this.bidEndTime, @required this.index, @required this.onTimerEnd})
      : super(key: key);

  @override
  _MyCountdownWidgetState createState() => _MyCountdownWidgetState();
}

class _MyCountdownWidgetState extends State<MyCountdownWidget> {
  Duration duration;
  Timer timer;

  @override
  void initState() {
    super.initState();
    duration = parseDuration(widget.bidEndTime);
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (duration.inSeconds > 0) {
          duration = duration - Duration(seconds: 1);
        }
        else {
        timer.cancel(); // Cancel the timer when the duration reaches 0
        widget.onTimerEnd(widget.index); // Call the callback function with the index
        } // Cancel the timer when the duration reaches 0

      });
    });
  }

  static Duration parseDuration(String formattedString) {
    var parts = formattedString.split(', ');
    var days = int.parse(parts[0].split(' ')[0]);
    var hours = int.parse(parts[1].split(' ')[0]);
    var minutes = int.parse(parts[2].split(' ')[0]);
    var seconds = int.parse(parts[3].split(' ')[0]);

    return Duration(days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Text(
        '${duration.inDays}d: ${duration.inHours.remainder(24)}h:${duration.inMinutes.remainder(60)}m: ${duration.inSeconds.remainder(60)}s ',
        style: TextStyle(fontSize: 12,color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}