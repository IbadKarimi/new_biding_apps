

import 'package:biding_app/views/screens/%20Chat/ChatView.dart';
import 'package:biding_app/views/screens/Aggriculture/AggricultureView.dart';
import 'package:biding_app/views/screens/Furniture/FurnitureView.dart';
import 'package:biding_app/views/screens/MyBids/MyBids.dart';
import 'package:biding_app/views/screens/RealState/RealStateView.dart';
import 'package:biding_app/views/screens/Vehicle/VehiclesView.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String? userEmail;
  var user;
  Future<void> getCurrentUser() async {
    user=await FirebaseAuth.instance.currentUser!.email.toString();
    try {
      if (user!= null) {
        userEmail = user.toString();

        print("User Email: " + userEmail.toString());

        if (user != null) {
          if (user == "admin@gmail.com") {
            print("User Email is Admin: " + user.toString());
            // Your logic for admin user here
          } else if (user == "accountant@gmail.com") {
            print("User Email is Accountant: " + user.toString());
            // Your logic for accountant user here
          } else {
            print("User Email is not recognized: " + userEmail.toString());
          }
        }
      } else {
        print("User is not authenticated");
      }
    } catch (e) {
      print("Error getting current user: $e");
    }
  }

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

          if(index==2 ){
            Get.to(()=>SelectCateogoryView());
          }
          if(index==3){
            Get.to(()=>HomePageView());
          }
          if(index==4){
            Get.to(()=>ChatScreen(recieverId: '',));
          }


        }); },

        items:  <BottomNavigationBarItem>[



          BottomNavigationBarItem(
            icon: Icon(Icons.back_hand_outlined,color: Colors.black,),
            label: 'My Bids',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.feedback,color: Colors.black,),
            label: 'Notification',
          ),
          if(userEmail !="accountant@gmail.com")
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
