
import 'package:biding_app/views/screens/authentication_repository/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../authentication_repository/login.dart';

class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(body:
    SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFFFFDB58),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,

          children: [
            Animate(
              effects: [FadeEffect(delay: 500.ms,duration: 2000.ms),SlideEffect()],
              child: Container(
                margin: EdgeInsets.only(top:130.h),
                width: 200.w,height: 200.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r)
                ),
                child:  Image.asset("lib/utils/images/BidPic.png"),),),

            Padding(
                padding: EdgeInsets.only(top: 70.h, left: 0, bottom: 0),
                child: Animate(
                  effects: [FadeEffect(delay: 500.ms,duration: 2000.ms),SlideEffect()],
                  child: Text(
                    "Build Awesome Apps",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 20.h, left: 0 ,bottom: 0),
                child:Animate(
                    effects: [FadeEffect(delay: 500.ms,duration: 2000.ms),SlideEffect()],
                    child:  Text(
'''Let's put your creativity on the 
        development highway''',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding:  EdgeInsets.only(
                        top: 70.h, left: 0.w),
                    child: SizedBox(
                        width: 150.w,
                        height: 45.h,
                        child: Animate(
                            effects: [FadeEffect(delay: 500.ms,duration: 2000.ms),SlideEffect()],
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              LoginFormWidget()));
                                },
                                // ignore: sort_child_properties_last
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color:
                                      Colors.black),
                                ),
                                style: ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                  const Color(0xFFFFFDB58),
                                  shape:
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black, width: 1.w),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        5.0.r),
                                  ),
                                ))))),

                Padding(
                    padding:  EdgeInsets.only(
                        top: 70.h, left: 5.w),
                    child: Container(
                        width: 150.w,
                        height: 45.h,
                        child:Animate(
                            effects: [FadeEffect(delay: 500.ms,duration: 2000.ms),SlideEffect()],
                            child:  ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              SignUpFormWidget()));
                                },
                                // ignore: sort_child_properties_last
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  <
                                        Widget>[
                                      Center(
                                          child:
                                          Text(
                                            "SIGNUP",
                                            style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontSize:
                                                12.sp),
                                          )),
                                    ]),
                                style: ElevatedButton
                                    .styleFrom(
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          5.0.r),
                                    ),
                                    backgroundColor:
                                    const Color(
                                        0xFF363B42)))))),
              ],
            ),

          ],),
      ),
    ));


  }

}