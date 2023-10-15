import 'dart:io';

import 'package:biding_app/controllers/user_controller.dart';
import 'package:biding_app/views/screens/Accountant/AccountantView.dart';
import 'package:biding_app/views/screens/Admin/ViewBids.dart';
import 'package:biding_app/views/screens/FeedBack/Feedback.dart';
import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/UserModel.dart';
import '../authentication_repository/login.dart';
import '../categories/categories.dart';


PlatformFile _getImageFile;
var picked;
String imagePath="";
String fullName="";
String phoneNo="";

class CustomDrawer extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _CustomDrawerState extends State<CustomDrawer> {


  UserController controller=UserController();

  List<UserModel> _getUserData=[];


  Rx<File> image=File('').obs;
  Future getImage()async{

    final pickImage=await ImagePicker().pickImage(source: ImageSource.gallery);
    final imageTemp=File(pickImage.path);
    image.value=imageTemp;
    print(imageTemp.path.toString());
 if(image.value!=""){

   controller.InsertImage(image);
   }}

  void initState() {
    // var ownerAbout=getOwnerAbout(currentUserEmail.toString());



    controller.getUserData().then((value){
      setState((){
        _getUserData.addAll(value);

        fullName=_getUserData[0].fullName.toString();
        imagePath=_getUserData[0].imagePath.toString();
        phoneNo=_getUserData[0].phoneNo.toString();


        print("image path ================="+_getUserData[0].imagePath.toString());
      });
    });


    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    String email=FirebaseAuth.instance.currentUser.email.toString();
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

               Row(
                 children: [
                   Stack(
                      children: [
                        Container(
                          width:60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1,color: Colors.grey),

                          ),
                          child:imagePath=="null"? Container(
                            width:60.w,
                            height: 60.h,

                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 1,color: Colors.grey),

                            ),
                          ):
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100), // Adjust the border radius as needed
                            child: Image.network(

                                imagePath.toString(),
                              fit: BoxFit.cover,
                              height: 60.h,
                              width:60.w,


                            )
                          ),)

                        ,  Padding(
                          padding: EdgeInsets.only(left:40.w,top:30.h),
                          child: IconButton(onPressed: (){
                            getImage();
                          }, icon: Icon(Icons.add_circle)),
                        )




                      ]),

                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left:0,top:10),
                         child: Container(child: Text(fullName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),)),
                       ),

                       Padding(
                         padding: const EdgeInsets.only(left:0,top:2),
                         child: Text( email,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                       )
                     ],
                   ),

                 ],
               ),




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
            FirebaseAuth.instance.signOut();
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
