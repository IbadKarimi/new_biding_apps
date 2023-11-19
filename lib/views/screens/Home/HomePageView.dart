

import 'dart:async';

import 'package:biding_app/model/HomePageModel.dart';
import 'package:biding_app/views/Filter/SearchFilter.dart';
import 'package:biding_app/views/screens/Admin/AddAgriculture.dart';
import 'package:biding_app/views/screens/Aggriculture/AggricultureView.dart';
import 'package:biding_app/views/screens/Furniture/FurnitureView.dart';
import 'package:biding_app/views/screens/Home/BidsMainView.dart';
import 'package:biding_app/views/screens/RealState/RealStateView.dart';
import 'package:biding_app/views/screens/SelectingCategories/SelectingCategories.dart';
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
import '../User/EditProfile.dart';
import '../User/ResetPassword.dart';

void _handleClick(int item) {
  switch (item) {
    case 0:  Get.to(()=>EditProfileView());

    break;
    case 1: case 0:  Get.to(()=>ResetPasswordView());
  break;
  }
}


class HomePageView extends StatefulWidget{
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {


  @override
  String onTapAuctionType="Biding";
  String _query="";
  FurnitureController  furnitureController=FurnitureController();
  AgricultureController  agricultureController=AgricultureController();
  RealStateController realStateController=RealStateController();
  VehicleController vehicleController=VehicleController();

  HomePageController homePageController=HomePageController();


  List<HomePageModel> data=[];

  List<HomePageModel> filteredItems=[];

  List<HomePageModel> bidingData=[];

  List<HomePageModel> fixedAuctionData=[];

  List<FurnitureModel> furniture=[];


  List<RealStateModel> realState=[];



  List<VehicleModel> vehicle=[];


  List<AgricultureModel> agriculture=[];



  void _filterItemsBiding(String query) {
    setState(() {
      filteredItems = bidingData.where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void _filterItemsFixedAuction(String query) {
    setState(() {
      filteredItems = fixedAuctionData.where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  int getAuctionDataLength() {
    if (onTapAuctionType == "Biding" && bidingData != null) {
      return bidingData.length;
    } else if (onTapAuctionType == "Fixed Auction" && fixedAuctionData != null) {
      return fixedAuctionData.length;
    }
    return 0; // Return 0 or handle appropriately if data is not available
  }


  void initState() {



      homePageController.getBiddingData().then((value) {
        setState(() {
          bidingData.addAll(value);
          filteredItems.addAll(bidingData);


        });
      });

      homePageController.geFixedAuctionData().then((value) {
        setState(() {
          fixedAuctionData.addAll(value);
          filteredItems.addAll(fixedAuctionData);


        });
      });

    super.initState();

  }






  TextEditingController offer=TextEditingController();
  TextEditingController search=TextEditingController();

  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  AppBar _buildRegularAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text('Bidding Sale System'),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
          icon: Icon(Icons.search, color: Colors.amber),
        ),
        IconButton(
          onPressed: () {
            Get.to(()=>SearchFilterView());
          },
          icon: Icon(Icons.filter_alt_sharp, color: Colors.amber),
        ),

        PopupMenuButton<int>(
          onSelected: (item) => _handleClick(item),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 0,
              child: Text('Edit Profile', style: TextStyle(color: Colors.black)),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Text('Reset password', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }

  AppBar _buildSearchAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.amber),
        onPressed: () {
          setState(() {
            _isSearching = false;
            _query="";
          });
        },
      ),
      title: TextField(
        style: TextStyle(color: Colors.black),
        onChanged: (query) {

          if(onTapAuctionType=="Biding"){
            _filterItemsBiding(query);
            _query=query;

          }else{
            _filterItemsFixedAuction(query);
            _query=query;

          }



        },
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.amber.withOpacity(0.7)),

          fillColor: Colors.white, // Set the background color to white
          filled: true,
          labelText: 'Search Category Name',

          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Implement your search logic here using _searchController.text
            print('Searching for: ${_searchController.text}');
          },
          icon: Icon(Icons.search, color: Colors.amber),
        ),
      ],
    );
  }


  Widget build(BuildContext context) {

   return Scaffold(
     appBar:  _isSearching ? _buildSearchAppBar() : _buildRegularAppBar(),


     bottomNavigationBar: CustomBottomNavigationBar(),
     drawer: CustomDrawer(),
     body: Padding(
         padding: const EdgeInsets.only(top: 10),
         child:   CustomScrollView(
             scrollDirection: Axis.vertical,
             slivers: [
               SliverList(
                 delegate: SliverChildListDelegate([

                   //------------Buttons Fixed Price ----------//
                   if(_query!="")
                   Column(
                     children: [
                       for(int index=0;index<filteredItems.length;index++)

                         GestureDetector(
                           onTap:()async{
                             final SharedPreferences prefs = await SharedPreferences.getInstance();
                             prefs.setString("id", filteredItems[index].docId.toString());
                             prefs.setString("categoryName", filteredItems[index].categoryType.toString());
                             prefs.setString("auctionType", filteredItems[index].auctionType);

                             String? id="";
                             id=prefs.getString("id");
                             String categoryName="";
                             categoryName= prefs.getString("categoryName")!;
                             print("Category Type is "+categoryName.toString());

                             if(id!=null){
                               Get.to(()=>BidsMainView());
                             }
                           },
                           child: Container(
                             margin: EdgeInsets.only(top:10.h,left:10.w,right: 10.w,bottom: 10.h),
                             width:320.w,

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

                                   width:320.w,
                                   height: 180.h,

                                   decoration: BoxDecoration(

                                       image: DecorationImage(image: NetworkImage(filteredItems[index].imagePath,),fit:BoxFit.cover),

                                       border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                                   ),

                                 ),
                                 Center(
                                   child: Container(
                                     margin: EdgeInsets.only(top:5.h),
                                     width: 100.w,
                                     height: 15.h,
                                     child:MyCountdownWidget(
                                       bidEndTime: filteredItems[index].setBidEndTime.toString(),
                                       index: index,
                                       onTimerEnd: (int index) {
                                         setState(() {
                                           filteredItems.removeAt(index);
                                           filteredItems.sort(); // Sort the list based on bidding end times
                                         });
                                       },
                                     ),),
                                 ),
                                 Padding(
                                   padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                   child:  Text(
                                     filteredItems[index].name,
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
                                         filteredItems[index].city,
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
                                     filteredItems[index].description,
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
                                         filteredItems[index].price,
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
                     ],
                   ),

                   if(_query=="")
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
                   if(_query=="")
                   Padding(
                     padding:EdgeInsets.only(left:10.w,top:10.h),
                     child: Text("Latest Bidding",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14.sp),),
                   ),
                   //---------------------------Lates Bidding Form
                   if(_query=="")
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
                                 id=prefs.getString("id")!;
                                 String categoryName="";
                                 categoryName= prefs.getString("categoryName")!;
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
                                         bidingData[i].name,
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
                   if(_query=="")
                   Padding(
                     padding:EdgeInsets.only(left:10.w,top:0.h),
                     child: Text("Catergory",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14.sp),),
                   ),
                   if(_query=="")
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
                   if(_query=="")
                   Padding(
                     padding:EdgeInsets.only(left:10.w,top:10.h,bottom: 10.h),
                     child: Text("Most Popular",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14.sp),),
                   ),

                 ]),
               ),
               //------------------------------//
               if(_query=="" && onTapAuctionType=="Biding")
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
                           child:

                             GestureDetector(
                               onTap:()async{
                                 final SharedPreferences prefs = await SharedPreferences.getInstance();
                                 prefs.setString("id", bidingData[index].docId.toString());
                                 prefs.setString("categoryName", bidingData[index].categoryType.toString());
                                 prefs.setString("auctionType", bidingData[index].auctionType);

                                 String? id="";
                                 id=prefs.getString("id");
                                 String categoryName="";
                                 categoryName= prefs.getString("categoryName")!;
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
                             )





                         );
                       },
                       childCount:bidingData.length
                   )
               ),
               if(_query=="" && onTapAuctionType=="Fixed Auction")
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
                             child:

                             GestureDetector(
                               onTap:()async{
                                 final SharedPreferences prefs = await SharedPreferences.getInstance();
                                 prefs.setString("id", fixedAuctionData[index].docId.toString());
                                 prefs.setString("categoryName", fixedAuctionData[index].categoryName.toString());
                                 prefs.setString("auctionType", fixedAuctionData[index].auctionType);

                                 String? id="";
                                 id=prefs.getString("id");
                                 String? categoryName="";
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
                       childCount:fixedAuctionData.length
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

  MyCountdownWidget({ required this.bidEndTime, required this.index, required this.onTimerEnd})
 ;

  @override
  _MyCountdownWidgetState createState() => _MyCountdownWidgetState();
}

class _MyCountdownWidgetState extends State<MyCountdownWidget> {
  Duration? duration;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    duration = parseDuration(widget.bidEndTime);
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (duration!.inSeconds > 0) {
          duration = duration! - Duration(seconds: 1);
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
        '${duration!.inDays}d: ${duration!.inHours.remainder(24)}h:${duration!.inMinutes.remainder(60)}m: ${duration!.inSeconds.remainder(60)}s ',
        style: TextStyle(fontSize: 12,color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    timer!.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}