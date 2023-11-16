

import 'package:biding_app/views/screens/Accountant/AcceptRejectBid.dart';
import 'package:biding_app/views/screens/Admin/AcceptedBidsMainView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/HomeController.dart';
import '../../../model/HomePageModel.dart';
import '../Home/BidsMainView.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/Drawer.dart';


class NotificationView extends StatefulWidget{
  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  HomePageController homePageController=HomePageController();
  List<HomePageModel> data=[];

  void initState() {
    homePageController.getCategoriesData().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  int index = 0;

  TextEditingController offer=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),

      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:  EdgeInsets.only(left:5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 20.w, bottom: 0.h),
                child:  Text(
                  "Notifications",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              for(int i=0;i<data.length;i++)
                if(FirebaseAuth.instance.currentUser!.uid.toString()==data[i].userId.toString())
                if(data[i].status=="Completed" || data[i].status=="Pending" || data[i].status=="Rejected")


                  GestureDetector(
                    onTap: ()async{
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("id", data[i].docId.toString());
                      prefs.setString("auctionType", data[i].auctionType);
                      prefs.setString("categoryName", data[i].categoryType.toString());

                      String id="";
                      id=prefs.getString("id")!;
                      String categoryName="";
                      categoryName= prefs.getString("categoryName")!;
                      print("Category Type is "+data[i].auctionType.toString());

                    if(id!=null){
                        Get.to(()=>AcceptedBidsMainView());
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left:15.w,top:5.h,bottom: 10.h,),
                      alignment: AlignmentDirectional.center,
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

                          //----------------------Pic Box----------------------//

                          Container(
                            margin: EdgeInsets.only(left:0.w,top:0.h),

                            width:320.w,
                            height: 180.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(data[i].imagePath,),fit:BoxFit.cover),

                                border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                            ),

                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                            child:  Text(
                              data[i].categoryName,
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
                                padding: EdgeInsets.only(top: 5.h, left: 7.w),
                                child: Icon(Icons.location_pin,color: Colors.red,),),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 3.w),
                                child:  Text(
                                  data[i].city,
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
                            padding: EdgeInsets.only(top: 5.h, left: 10.w),
                            child:  Text(
                              data[i].description,
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
                                  padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 5.h),
                                  child:  Text(
                                    "RS :",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 5.h),
                                child:  Text(
                                  data[i].price,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 5.h),
                            child:  Text(
                              "Your Order is "+data[i].status.toString(),
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],),
        ),
      ),

    );}}