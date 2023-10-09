import 'package:biding_app/views/screens/Accountant/AccountantView.dart';
import 'package:biding_app/views/screens/Admin/AddVehicle.dart';
import 'package:biding_app/views/screens/Admin/ViewBids.dart';
import 'package:biding_app/views/screens/FeedBack/Feedback.dart';
import 'package:biding_app/views/screens/Furniture/FurnitureView.dart';
import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:biding_app/views/screens/RealState/RealStateView.dart';
import 'package:biding_app/views/screens/SelectingCategories/SelectingCategories.dart';
import 'package:biding_app/views/screens/Vehicle/VehiclesView.dart';
import 'package:biding_app/views/screens/categories/categories.dart';
import 'package:biding_app/views/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
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
      child: WelcomeScreen(),
    );
  }
}
