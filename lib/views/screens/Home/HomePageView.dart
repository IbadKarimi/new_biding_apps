

import 'package:biding_app/views/screens/Admin/AddAgriculture.dart';
import 'package:biding_app/views/screens/Furniture/FurnitureView.dart';
import 'package:biding_app/views/screens/RealState/RealStateView.dart';
import 'package:biding_app/views/screens/Vehicle/VehiclesView.dart';
import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovering/hovering.dart';

class HomePageView extends StatefulWidget{
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override

  String _searchQuery = '';
  List<String> _filteredData = [];
  List<String> dataList = [
    'Pakistan',
    'Australia',
    'Rusia',
    // ... add more items
  ];

  TextEditingController offer=TextEditingController();
  TextEditingController search=TextEditingController();

  void _filterData() {
    setState(() {
      _filteredData = dataList
          .where((item) => item.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    });
  }

  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomAppBar(),
     bottomNavigationBar: CustomBottomNavigationBar(),
     drawer: CustomDrawer(),
     body: SingleChildScrollView(
       scrollDirection: Axis.vertical,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [


           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [

               Center(
                 child: Container(
                    margin: EdgeInsets.only(top:20.w),
                     width: 300.w,
                     height: 45.h,
                     child: TextFormField(
                       style: TextStyle(color: Colors.black),

                       controller: search,
                       decoration: InputDecoration(
                         label: Text("Search") ,prefixIcon:Icon(Icons.search,color: Colors.blue,),
                         border: OutlineInputBorder(),

                       ),)),
               ),



             ],
           ),

         Padding(
           padding:EdgeInsets.only(left:20.w,top:10.h),
           child: Text("Latest Bidding",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14.sp),),
         ),
           //---------------------------Lates Bidding Form
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 for(int i=0;i<10;i++)
                 Container(
                   margin: EdgeInsets.only(left:20.w,top:20.h),
                   alignment: AlignmentDirectional.center,
                   width:150.w,

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

                         width:150.w,
                         height: 100.h,
                         decoration: BoxDecoration(
                             image: DecorationImage(image: AssetImage("lib/utils/images/car.jpg",),fit:BoxFit.cover),

                             border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                         ),

                       ),
                       Padding(
                         padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                         child:  Text(
                           "Toyota Corolla",
                           style: TextStyle(
                             color: Colors.black,
                             fontSize: 10.sp,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(top: 5.h, left: 10.w),
                         child:  Text(
                           "This is my favourite Car I am giving it low cost",
                           style: TextStyle(
                             color: Colors.grey,
                             fontSize: 10.sp,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                         child:  Text(
                           "Price",
                           style: TextStyle(
                             color: Colors.black,
                             fontSize: 10.sp,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                         child:  Text(
                           "1000000 RS",
                           style: TextStyle(
                             color: Colors.grey,
                             fontSize: 10.sp,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                       ),
                       Center(
                         child: Container(
                           margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                           width: 80.w,
                           height: 25.h,
                           child: ElevatedButton(
                               onPressed: () {
                                 showDialog(
                                     context: context,
                                     builder: (BuildContext context) {
                                       return Padding(
                                           padding: const EdgeInsets.only(
                                               left: 0, top: 0),
                                           child: AlertDialog(
                                               shape:
                                               const RoundedRectangleBorder(
                                                   borderRadius:
                                                   BorderRadius.all(
                                                       Radius.circular(
                                                           10.0))),


                                               content:Container(
                                                 width: 250.w,
                                                 height: 250.h,
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [

                                                     Text(
                                                       "Offer",
                                                       style: TextStyle(
                                                           fontWeight: FontWeight.w600,
                                                           color: Colors
                                                               .black,
                                                           fontSize:
                                                           16.sp),
                                                     ),


                                                     Padding(
                                                       padding: const EdgeInsets.only(top:20,bottom: 10),
                                                       child: Text(
                                                         "Enter your offer",
                                                         style: TextStyle(
                                                             color: Colors
                                                                 .black,
                                                             fontSize:
                                                             16.sp),
                                                       ),
                                                     ),

                                                     SizedBox(
                                                       width: 250.w,
                                                       height: 45.h,
                                                       child: TextFormField(
                                                         controller: offer,
                                                      style: TextStyle(color: Colors.black),
                                                         decoration: InputDecoration(

                                                           label: Text("10,0000") ,
                                                           border: OutlineInputBorder(),
                                                         ),),
                                                     ),

                                                     Padding(
                                                       padding:EdgeInsets.only(top:70.h),
                                                       child: Row(
                                                         children: [

                                                           Container(
                                                             margin: EdgeInsets.only(left:10.w),
                                                             width: 100.w,
                                                             height: 40.h,
                                                             child: ElevatedButton(
                                                               onPressed: () {
                                                                 Navigator.of(context).pop();

                                                               },
                                                               // ignore: sort_child_properties_last
                                                               child: Row(
                                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                                   children:  <
                                                                       Widget>[
                                                                     Center(
                                                                         child:
                                                                         Text(
                                                                           "Cancel",
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
                                                                         20.0.r),
                                                                   ),
                                                                   backgroundColor:
                                                                   const Color(
                                                                       0xFF363B42)),),
                                                           ),
                                                           //-------------Ok Button Starts here

                                                           Container(
                                                             width: 100.w,
                                                             height: 40.h,
                                                             margin: EdgeInsets.only(left:30.w),
                                                             child: ElevatedButton(
                                                               onPressed: () {

                                                                 showDialog(context: context, builder: (BuildContext context){
                                                                   return ShowConAlertDialog();
                                                                 });





                                                               },
                                                               // ignore: sort_child_properties_last

                                                               //------------------------ok approval-------------//
                                                               child: Row(
                                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                                   children:  <
                                                                       Widget>[
                                                                     Center(
                                                                         child:
                                                                         Text(
                                                                           "Submit",
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
                                                                         20.0.r),
                                                                   ),
                                                                   backgroundColor:
                                                                   const Color(
                                                                       0xFF363B42)),),
                                                           ),
                                                         ],
                                                       ),
                                                     )

                                                   ],),
                                               )



                                           ));});



                               },
                               // ignore: sort_child_properties_last
                               child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children:  <
                                       Widget>[
                                     Center(
                                         child:
                                         Text(
                                           "Bid Now",
                                           style: TextStyle(
                                               color: Colors
                                                   .white,
                                               fontSize:
                                               10.sp),
                                         )),
                                   ]),
                               style: ElevatedButton
                                   .styleFrom(
                                   shape:
                                   RoundedRectangleBorder(
                                     borderRadius:
                                     BorderRadius
                                         .circular(
                                         20.0.r),
                                   ),
                                   backgroundColor:
                                   Colors.lightGreen)),),
                       ),
                     ],
                   ),
                 ),
             ],),
           ),
           Padding(
             padding:EdgeInsets.only(left:20.w,top:10.h),
             child: Text("Catergory",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14.sp),),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               GestureDetector(
                   onTap: (){
                     Get.to(()=>VehicleView());
                   },
                   child:Container(
                 margin: EdgeInsets.only(left:25.w,top:10.h),
                 width: 70.w,height: 80.h,
               decoration: BoxDecoration(
                 color: Colors.amber,
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Icon(Icons.car_rental,size: 40,),)),

               GestureDetector(
                 onTap: (){
                   Get.to(()=>FurnitureView());
                 },
                 child: Container(
                   margin: EdgeInsets.only(left:10.w,top:10.h),
                   width: 70.w,height: 80.h,
                   decoration: BoxDecoration(
                     color: Colors.amber,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Icon(Icons.table_restaurant_sharp,size: 40,),),
               ),
               GestureDetector(
                   onTap: (){
                     Get.to(()=>VehicleView());
                   },
                   child:Container(
                 margin: EdgeInsets.only(left:10.w,top:10.h),
                 width: 70.w,height: 80.h,
                 decoration: BoxDecoration(
                   color: Colors.amber,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Icon(Icons.agriculture,size: 40,),)),
               GestureDetector(
                   onTap: (){
                     Get.to(()=>RealStateView());
                   },
                   child:Container(
                 margin: EdgeInsets.only(left:10.w,top:10.h),
                 width: 70.w,height: 80.h,
                 decoration: BoxDecoration(
                   color: Colors.amber,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Icon(Icons.real_estate_agent,size: 40,),)),
             ],),


           Padding(
             padding: const EdgeInsets.only(top: 10),
             child:   Container(

                 margin: EdgeInsets.only(top: 0.h,left: 20.w,right: 30),



                 height: 1000,



                 child:
                 CustomScrollView(
                   slivers: [


                 SliverGrid(
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                     childAspectRatio:(3/4.02),
                   crossAxisSpacing: 10.w,
                   mainAxisSpacing: 10.h

                 ),
                 delegate: SliverChildBuilderDelegate(
                       (context, index) {
                     return   Container(
                       margin: EdgeInsets.only(top:0.h,left:0.w),
                       alignment: AlignmentDirectional.center,
                       width:120.w,
                       height: 150.h,

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

                             width:200.w,
                             height: 80.h,
                             decoration: BoxDecoration(

                                 image: DecorationImage(image: AssetImage("lib/utils/images/car.jpg",),fit:BoxFit.cover),

                                 border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
                             ),

                           ),
                           Padding(
                             padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                             child:  Text(
                               "Toyota Corolla",
                               style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 10.sp,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.only(top: 5.h, left: 10.w),
                             child:  Text(
                               "This is my favourite Car I am giving it low cost",
                               style: TextStyle(
                                 color: Colors.grey,
                                 fontSize: 10.sp,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                             child:  Text(
                               "Price",
                               style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 10.sp,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 0.h),
                             child:  Text(
                               "1000000 RS",
                               style: TextStyle(
                                 color: Colors.grey,
                                 fontSize: 10.sp,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),
                           ),
                           Center(
                             child: Container(
                               margin: EdgeInsets.only(top:10.h,left:0.w,bottom: 5.h),
                               width: 80.w,
                               height: 25.h,
                               child: ElevatedButton(
                                   onPressed: () {
                                     showDialog(
                                         context: context,
                                         builder: (BuildContext context) {
                                           return Padding(
                                               padding: const EdgeInsets.only(
                                                   left: 0, top: 0),
                                               child: AlertDialog(
                                                   shape:
                                                   const RoundedRectangleBorder(
                                                       borderRadius:
                                                       BorderRadius.all(
                                                           Radius.circular(
                                                               10.0))),


                                                   content:Container(
                                                     width: 250.w,
                                                     height: 250.h,
                                                     child: Column(
                                                       mainAxisAlignment: MainAxisAlignment.start,
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [

                                                         Text(
                                                           "Offer",
                                                           style: TextStyle(
                                                               fontWeight: FontWeight.w600,
                                                               color: Colors
                                                                   .black,
                                                               fontSize:
                                                               16.sp),
                                                         ),


                                                         Padding(
                                                           padding: const EdgeInsets.only(top:20,bottom: 10),
                                                           child: Text(
                                                             "Enter your offer",
                                                             style: TextStyle(
                                                                 color: Colors
                                                                     .black,
                                                                 fontSize:
                                                                 16.sp),
                                                           ),
                                                         ),

                                                         SizedBox(
                                                           width: 250.w,
                                                           height: 45.h,
                                                           child: TextFormField(
                                                             controller: offer,
                                                             style: TextStyle(color: Colors.black),
                                                             decoration: InputDecoration(

                                                               label: Text("10,0000") ,
                                                               border: OutlineInputBorder(),
                                                             ),),
                                                         ),

                                                         Padding(
                                                           padding:EdgeInsets.only(top:70.h),
                                                           child: Row(
                                                             children: [

                                                               Container(
                                                                 margin: EdgeInsets.only(left:10.w),
                                                                 width: 100.w,
                                                                 height: 40.h,
                                                                 child: ElevatedButton(
                                                                   onPressed: () {
                                                                     Navigator.of(context).pop();

                                                                   },
                                                                   // ignore: sort_child_properties_last
                                                                   child: Row(
                                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                                       children:  <
                                                                           Widget>[
                                                                         Center(
                                                                             child:
                                                                             Text(
                                                                               "Cancel",
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
                                                                             20.0.r),
                                                                       ),
                                                                       backgroundColor:
                                                                       const Color(
                                                                           0xFF363B42)),),
                                                               ),
                                                               //-------------Ok Button Starts here

                                                               Container(
                                                                 width: 100.w,
                                                                 height: 40.h,
                                                                 margin: EdgeInsets.only(left:30.w),
                                                                 child: ElevatedButton(
                                                                   onPressed: () {

                                                                     showDialog(context: context, builder: (BuildContext context){
                                                                       return ShowConAlertDialog();
                                                                     });





                                                                   },
                                                                   // ignore: sort_child_properties_last

                                                                   //------------------------ok approval-------------//
                                                                   child: Row(
                                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                                       children:  <
                                                                           Widget>[
                                                                         Center(
                                                                             child:
                                                                             Text(
                                                                               "Submit",
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
                                                                             20.0.r),
                                                                       ),
                                                                       backgroundColor:
                                                                       const Color(
                                                                           0xFF363B42)),),
                                                               ),
                                                             ],
                                                           ),
                                                         )

                                                       ],),
                                                   )



                                               ));});



                                   },
                                   // ignore: sort_child_properties_last
                                   child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children:  <
                                           Widget>[
                                         Center(
                                             child:
                                             Text(
                                               "Bid Now",
                                               style: TextStyle(
                                                   color: Colors
                                                       .white,
                                                   fontSize:
                                                   10.sp),
                                             )),
                                       ]),
                                   style: ElevatedButton
                                       .styleFrom(
                                       shape:
                                       RoundedRectangleBorder(
                                         borderRadius:
                                         BorderRadius
                                             .circular(
                                             20.0.r),
                                       ),
                                       backgroundColor:
                                       Colors.lightGreen)),),
                           ),
                         ],
                       ),
                     );
                   },
                 )
             ),
           ]),


             ))],),
     ),
   );
  }
}



class CustomAlertDialog extends StatefulWidget{
  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius:
      BorderRadius.all(
          Radius.circular(
              10.0))),
      content: Container(
        width: 250.w,
        height: 250.h,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children:
            [
              Container(width: 100.w,height:100.h,
                  margin: EdgeInsets.only(top:30.h),

                  decoration:BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/utils/images/accept.png")
                    ),
                  ) ),
              Center(
                  child:
                  Padding(
                    padding: EdgeInsets.only(top:10.h,bottom: 20.h),
                    child: Text(
                      "Congragulations ! Your offer sent to Bidding Sale System ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors
                              .green,
                          fontSize:
                          12.sp),
                    ),
                  )),

              Container(
                margin: EdgeInsets.only(left:10.w),
                width: 100.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder:
                                (context) =>
                                HomePageView()));

                  },
                  // ignore: sort_child_properties_last
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <
                          Widget>[
                        Center(
                            child:
                            Text(
                              "Ok",
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
                            20.0.r),
                      ),
                      backgroundColor:
                      const Color(
                          0xFF363B42)),),
              ),
            ]),
      ),

    );



  }
}






class ShowConAlertDialog extends StatefulWidget{
  @override
  State<ShowConAlertDialog > createState() => _ShowConAlertDialogState();
}

class _ShowConAlertDialogState extends State<ShowConAlertDialog > {
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius:
      BorderRadius.all(
          Radius.circular(
              10.0))),
      content: Container(
        width: 250.w,
        height: 250.h,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children:
            [
              Container(width: 100.w,height:100.h,
                  margin: EdgeInsets.only(top:30.h),

                  decoration:BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/utils/images/accept.png")
                    ),
                  ) ),
              Center(
                  child:
                  Padding(
                    padding: EdgeInsets.only(top:10.h,bottom: 20.h),
                    child: Text(
                      "Congragulations ! Your offer sent to Bidding Sale System ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors
                              .green,
                          fontSize:
                          12.sp),
                    ),
                  )),

              Container(
                margin: EdgeInsets.only(left:10.w),
                width: 100.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder:
                                (context) =>
                                HomePageView()));

                  },
                  // ignore: sort_child_properties_last
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <
                          Widget>[
                        Center(
                            child:
                            Text(
                              "Ok",
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
                            20.0.r),
                      ),
                      backgroundColor:
                      const Color(
                          0xFF363B42)),),
              ),
            ]),
      ),

    );



  }
}