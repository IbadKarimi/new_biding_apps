

import 'package:biding_app/views/screens/%20Chat/ChatView.dart';
import 'package:biding_app/views/screens/Aggriculture/AggricultureView.dart';
import 'package:biding_app/views/screens/Furniture/FurnitureView.dart';
import 'package:biding_app/views/screens/MyBids/MyBids.dart';
import 'package:biding_app/views/screens/RealState/RealStateView.dart';
import 'package:biding_app/views/screens/Vehicle/VehiclesView.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

import '../FeedBack/Feedback.dart';
import '../Home/HomePageView.dart';
import '../Notification/Notification.dart';
import '../SelectingCategories/SelectingCategories.dart';
import '../categories/categories.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  int index=0;
  Widget build(BuildContext context) {
    return  BottomNavigationBar(

        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: Colors.amber, // <-- This works for fixed
        selectedItemColor:  Colors.black,
        unselectedItemColor: Colors.black,


        currentIndex: index,
        onTap: (int index) { setState((){
          this.index = index;
          if(index==0){
            Get.to(()=>MyBidsView());
          }
          if(index==1){
            Get.to(()=>NotificationView());
          }
          if(index==2){
            Get.to(()=>SelectCateogoryView());
          }
          if(index==3){
            Get.to(()=>HomePageView());
          }
          if(index==4){
            Get.to(()=>ChatScreen(recieverId: '',));
          }


        }); },

        items: const <BottomNavigationBarItem>[



          BottomNavigationBarItem(
            icon: Icon(Icons.back_hand_outlined,color: Colors.black,),
            label: 'My Bids',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.feedback,color: Colors.black,),
            label: 'Notification',
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline,color: Colors.black,size: 30,),
            label: 'Add Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black,),
            label: 'Home',
          ),


         /* BottomNavigationBarItem(
            icon: Icon(Icons.notification_add,color: Colors.black,),
            label: 'Notification',
          ),*/


          BottomNavigationBarItem(
            icon: Icon(Icons.category,color: Colors.black,),
            label: 'Chat',
          ),






        ]);
  }
}
