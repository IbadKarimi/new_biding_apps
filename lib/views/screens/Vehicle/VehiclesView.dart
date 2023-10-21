import 'dart:ui';

import 'package:biding_app/views/screens/Admin/AddFurniture.dart';
import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/FurnitureController.dart';
import '../../../model/FurnitureModel.dart';
import '../Home/BidsMainView.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../authentication_repository/login.dart';



class VehicleView extends StatefulWidget{
  @override
  State<VehicleView > createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView > {


  @override


  TextEditingController offer=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vehicle').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top:20.h),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          var items = snapshot.data.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              var data = item.data() as Map<String, dynamic>;

              String vehicleDocId = item.id;


              // Rest of your code
              // ...

              return GestureDetector(
                onTap: ()async{
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("id", vehicleDocId);
                  prefs.setString("categoryName", "RealState");
                  prefs.setString("auctionType", data['auctionType']);

                  String id="";
                  id=prefs.getString("id");
                  String categoryName="";
                  categoryName= prefs.getString("categoryName");
                  print("Category Type is "+categoryName.toString());

                  if(id!=null){
                    Get.to(()=>BidsMainView());
                  }


                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 20.w, bottom: 0.h),
                      child:  Text(
                        "Vehicle",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left:20.w,top:20.h),
                      alignment: AlignmentDirectional.center,
                      width:320.w,

                      decoration: BoxDecoration(

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
                                image: DecorationImage(image: NetworkImage(data['imagePath']),fit: BoxFit.cover),

                                border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                            ),

                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, left: 10, bottom: 0.h),
                            child:  Text(
                              data['vehicleName'] ,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
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
                                  data['cityName'],
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
                            padding: EdgeInsets.only(top: 10.h, left: 10.w),
                            child:  Text(
                              data['description'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10, bottom: 5.h),
                                child:  Text(
                                  "Rs",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 5.w, bottom: 5.h),
                                child:  Text(
                                  data['setBidPrice'],
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),


                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

    ) ;

  }}




