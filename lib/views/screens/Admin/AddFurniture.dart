



import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


PlatformFile? _getImageFile;
var picked;

class AddFurnitureView extends StatefulWidget{
  @override
  State<AddFurnitureView> createState() => _AddFurnitureViewState();
}

class _AddFurnitureViewState extends State<AddFurnitureView> {
  @override

  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController price=TextEditingController();
  var pickedProfilePhoto;

  Future getImage()async{
    final _picker = ImagePicker();
    pickedProfilePhoto = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (pickedProfilePhoto != null) {
      setState(() {
        _getImageFile= pickedProfilePhoto.files.first;

      });
    }}


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

            Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10.h, left: 0, bottom: 10.h),
                        child:  Center(
                          child: Text(
                            "Welcome Back ! Add Furniture Info",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top:20),
                      child: Center(
                        child: DottedBorder(
                          color: Colors.black,
                          dashPattern: [8, 4],
                          strokeWidth: 0.5,
                          child:Container(
                            width:300.w,height: 150.h,
                            child: picked!=null?Image.memory(picked.files.first.bytes,width: 200.w,height: 200.h,): IconButton(icon:Icon(Icons.add_photo_alternate_outlined,size: 50,),onPressed: () async {getImage();},),),

                        ),
                      ),
                    ),


                    Padding(
                        padding: EdgeInsets.only(top: 30.h, left: 30.w, bottom: 5.h),
                        child:  Text(
                          "Enter vehicle title.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                      width: 300.w,
                      height: 45.h,

                      margin: EdgeInsets.only(top:0.h,left:30.w),
                      child: TextFormField(
                        controller: title,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(

                          label: Text("Title") ,prefixIcon:Icon(Icons.title_outlined),
                          border: OutlineInputBorder(),

                        ),),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.h, left: 30.w, bottom: 5.h),
                        child:  Text(
                          "Enter vehicle description.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                      width: 300.w,
                      height: 45.h,

                      margin: EdgeInsets.only(top:0.h,left:30.w),
                      child: TextFormField(
                        controller: title,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(

                          label: Text("Description") ,prefixIcon:Icon(Icons.description),
                          border: OutlineInputBorder(),

                        ),),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.h, left: 30.w, bottom: 5.h),
                        child:  Text(
                          "Enter vehicle price.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                      width: 300.w,
                      height: 45.h,

                      margin: EdgeInsets.only(top:0.h,left:30.w),
                      child: TextFormField(
                        controller: title,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(

                          label: Text("Title") ,prefixIcon:Icon(Icons.price_change),
                          border: OutlineInputBorder(),

                        ),),
                    ),
                    SizedBox( height:10.h),

                    Container(
                      margin: EdgeInsets.only(top:10.h,bottom: 30.h,left: 50.w),
                      width: 250.w,
                      height: 45.h,
                      child:ElevatedButton(onPressed: (){



                      }, child:  Text("Add"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape:
                            RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: 1.w),
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  5.0.r),
                            ),
                          )),),



                  ],)),


          ],

        ),
      ),
    );
  }
}