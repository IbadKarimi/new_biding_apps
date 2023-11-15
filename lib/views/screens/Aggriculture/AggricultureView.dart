import 'dart:async';
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



class AgricultureView extends StatefulWidget{
  @override
  State<AgricultureView > createState() => _AgricultureViewState();
}

class _AgricultureViewState extends State<AgricultureView > {
  FurnitureController  furnitureController=FurnitureController();
  List<FurnitureModel> _furniture=[];
  void initState() {


    furnitureController.getFurniture().then((value){
      setState(() {
        _furniture.addAll(value);

      });
    });


    super.initState();
  }

  @override
  int index = 0;

  TextEditingController offer=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('agriculture').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top:20.h),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          var items = snapshot.data!.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              var data = item.data() as Map<String, dynamic>;

              String agricultureDocId = item.id;


              // Rest of your code
              // ...

              return GestureDetector(
                onTap: ()async{
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("id", agricultureDocId);
                  prefs.setString("categoryName", "Agriculture");
                  prefs.setString("auctionType", data['auctionType']);

                  String id="";
                  id=prefs.getString("id")!;
                  String categoryName="";
                  categoryName= prefs.getString("categoryName")!;
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
                        "Agriculture",
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
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top:5.h),
                              width: 100.w,
                              height: 15.h,
                              child:MyCountdownWidget(
                                bidEndTime: data['setBidEndTime'],
                                index: index,
                                onTimerEnd: (int index) {
                                  setState(() {
                                    // Sort the list based on bidding end times
                                  });
                                },
                              ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, left: 10, bottom: 0.h),
                            child:  Text(
                              data['typesCrop'] ,
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



class MyCountdownWidget extends StatefulWidget {
  final String bidEndTime;
  final int index;

  final Function(int) onTimerEnd; // Define the callback function

  MyCountdownWidget({ required this.bidEndTime, required this.index, required this.onTimerEnd});

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




