

import 'package:biding_app/controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/HomePageModel.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';
import 'MyBidsMainView.dart';


class MyBidsView extends StatefulWidget{
  @override
  State<MyBidsView> createState() => _MyBidsViewState();
}

class _MyBidsViewState extends State<MyBidsView> {
  HomePageController homePageController=HomePageController();

  List<HomePageModel> offers=[];

  void initState() {


    homePageController.getOffers().then((value) {
      setState(() {
        offers.addAll(value);
      });
    });

  }

  @override


  TextEditingController offer=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 30.w, bottom: 0.h),
                  child:  Text(
                    "My Bids ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),


                ////////////looof starts here//
                for(int i=0;i<offers.length;i++)
                  GestureDetector(
                    onTap: ()async{
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("id", offers[i].productId.toString());
                      prefs.setString("auctionType", "Biding");
                      prefs.setString("categoryName", offers[i].categoryName.toString());

                      String id="";
                      id=prefs.getString("id");
                      String categoryName="";
                      categoryName= prefs.getString("categoryName");


                      if(id!=null){
                        Get.to(()=>MyBidsMainView());
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left:30.w,top:20.h),
                      alignment: AlignmentDirectional.center,
                      width:300.w,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(0.r),
                          border: Border.all(color: Colors.black,width: 1)
                      ),

                      child:Row(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [



                          Container(
                            margin: EdgeInsets.only(left:0.w,top:0.h),

                            width:100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("lib/utils/images/BidPic.png",)),


                            ),

                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.h, left: 5.h, bottom: 0.h),
                                child:  Text(
                                  offers[i].categoryName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: 180,

                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.h, left: 10.w),
                                  child:  Text(
                                    "Price",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  offers[i].startPrice,
                                  style: TextStyle(

                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                                child:  Text(
                                  "My Offer",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w,bottom: 0.h),
                                child:  Center(
                                  child: Text(
                                    offers[i].offer,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w,bottom: 10.h),
                                child:  Center(
                                  child: Text(
                                    "This Bid is Accepted By You!",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),






                    ),
                  )]),
        ));}}