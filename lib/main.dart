
import 'package:biding_app/views/screens/Home/HomePageView.dart';
import 'package:biding_app/views/screens/SelectingCategories/SelectingCategories.dart';
import 'package:biding_app/views/screens/authentication_repository/login.dart';
import 'package:biding_app/views/screens/authentication_repository/sign_up.dart';
import 'package:biding_app/views/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


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
      child: SelectCateogoryView()
    );
  }
}




class DateSelectionScreen extends StatefulWidget {
  @override
  _DateSelectionScreenState createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  DateTime selectedDate;

  Future<void> _pickDate() async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1), // Can customize the range of available dates
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;

      });
    }
  }

  String getRemainingTime() {
    if (selectedDate == null) {
      return 'No date selected';
    }

    DateTime now = DateTime.now();
    Duration difference = selectedDate.isAfter(now) ? selectedDate.difference(now) : Duration.zero;

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return 'Remaining Time: $days days, $hours hours, $minutes minutes, $seconds seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Select Date'+selectedDate.toString()),
            ElevatedButton(
              onPressed: _pickDate,
              child: Text('Pick Date'),
            ),
            SizedBox(height: 20),
            Text(
              getRemainingTime(),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
