
import 'package:biding_app/views/screens/%20Chat/ChatList.dart';
import 'package:biding_app/views/screens/%20Chat/ChatView.dart';
import 'package:biding_app/views/screens/Accountant/AcceptRejectBid.dart';
import 'package:biding_app/views/screens/Accountant/AccountantView.dart';
import 'package:biding_app/views/screens/Admin/AdminViewFeedBack.dart';

import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:biding_app/views/screens/SelectingCategories/SelectingCategories.dart';
import 'package:biding_app/views/screens/authentication_repository/login.dart';
import 'package:biding_app/views/screens/authentication_repository/sign_up.dart';
import 'package:biding_app/views/screens/splash_screen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';



Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());

}



class MyApp extends StatelessWidget {



  @override
  // Define a function that inserts dogs into the database

  Widget build(BuildContext context) {


    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: LoginFormWidget()
    );
  }
}






