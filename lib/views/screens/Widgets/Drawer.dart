import 'dart:io';

import 'package:biding_app/controllers/signUp_controller.dart';
import 'package:biding_app/views/screens/Accountant/AccountantView.dart';
import 'package:biding_app/views/screens/Admin/ViewBids.dart';
import 'package:biding_app/views/screens/FeedBack/Feedback.dart';
import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../authentication_repository/login.dart';
import '../categories/categories.dart';


PlatformFile _getImageFile;
var picked;

class CustomDrawer extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _CustomDrawerState extends State<CustomDrawer> {
  UserController controller=UserController();

  Rx<File> image=File('').obs;
  Future getImage()async{

    final pickImage=await ImagePicker().pickImage(source: ImageSource.gallery);
    final imageTemp=File(pickImage.path);
    image.value=imageTemp;
    print(imageTemp.path.toString());
 if(image.value!=""){

   controller.InsertImage(image);

 }


   }




  @override
  Widget build(BuildContext context) {
    return Drawer( child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
              color: Colors.amberAccent

          ),
          child:   Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            /*  CircleAvatar(
                radius: 40.0,
                backgroundColor: const Color(0xFF778899),
                child: new Image.asset(
                  'lib/utils/images/construction-min.png',
                ),*/ //For Image Asset

              Obx((){
                return Stack(
                  children: [
                    Container(
                      width:80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 1,color: Colors.grey),

                      ),
                      child:image.value.path==""? Container(
                        width:80.w,
                        height: 80.h,

                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1,color: Colors.grey),

                        ),
                      ):
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100), // Adjust the border radius as needed
                        child: Image.file(
                          File(image.value.path),
                          width: 80, // Adjust the width as needed
                          height: 80, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                      ),)

                    ,  Padding(
                      padding: EdgeInsets.only(left:55.w,top:30.h),
                      child: IconButton(onPressed: (){
                        getImage();
                      }, icon: Icon(Icons.add_circle)),
                    )




                  ]);
              }),


              Padding(
                padding: const EdgeInsets.only(left:0,top:10),
                child: Text("Ibad Karimi",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:0,top:5),
                child: Text("ibadkarimi.10@gmail.com",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),),
              )
            ],
          ),

        ),
        ListTile(
          leading: Icon(Icons.account_box_outlined),
          title: const Text('About Us',style: TextStyle(color: Colors.black),),
          onTap: () {
            Get.to(()=>HomePageView());
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: const Text('Help',style: TextStyle(color: Colors.black),),
          onTap: () {
            // Update the state of the app.
            // ...

          },
        ),




        ListTile(
          leading: GestureDetector(onTap:(){
            Get.to(()=>AccountantView());
          },
            child:Icon(Icons.table_restaurant_sharp),),
          title: const Text('Payments',style: TextStyle(color: Colors.black),),
          onTap: () {
           Get.to(()=>AccountantView());
          },
        ),
        ListTile(
          leading: Icon(Icons.login_rounded),
          title: GestureDetector(onTap:(){
            Get.to(()=>ViewBids());
          },
              child: const Text('View Bids',style: TextStyle(color: Colors.black),)),
          onTap: () {
          Get.to(()=>ViewBids());
          },
        ),
        ListTile(
          leading: Icon(Icons.login_rounded),
          title: GestureDetector(onTap:(){
            Get.offAll(()=>LoginFormWidget());
          },
              child: const Text('LogOut',style: TextStyle(color: Colors.black),)),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          leading: GestureDetector(onTap:(){
            Get.to(()=>AccountantView());
          },
            child:Icon(Icons.category),),
          title: const Text('Categories',style: TextStyle(color: Colors.black),),
          onTap: () {
            Get.to(()=>Category());
          },
        ),

        ListTile(
          leading: GestureDetector(onTap:(){
            Get.to(()=>AccountantView());
          },
            child:Icon(Icons.feedback),),
          title: const Text('Feed Back',style: TextStyle(color: Colors.black),),
          onTap: () {
            Get.to(()=>FeedBackView());
          },
        ),
      ],
    ),);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
