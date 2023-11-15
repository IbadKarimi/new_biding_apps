



import 'package:biding_app/controllers/ChatController.dart';
import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:biding_app/views/screens/Widgets/BottomNavigationBar.dart';
import 'package:biding_app/views/screens/Widgets/Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/ChatModel.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String ? currentUserId;
  ChatController chatController=ChatController();
  List<ChatModel>  _chatList=[];

  void getUserCurrentId()async{
    currentUserId=FirebaseAuth.instance.currentUser!.uid;
    print("id isssssssssssssssssssssssssss"+currentUserId.toString());


  }
  void initState() {

    getUserCurrentId();
    chatController.getChatById().then((value){
      setState(() {
        _chatList.addAll(value);

      });
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomAppBar(),
     drawer: CustomDrawer(),
     bottomNavigationBar: CustomBottomNavigationBar(),
     body:
     Column(
       mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children:
         [
           for(int i=0;i<_chatList.length;i++)
             if(_chatList[i].senderId==currentUserId || _chatList[i].recieverId==currentUserId)
           Container(
             width: MediaQuery.of(context).size.width,
             height: 70.h,
             decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey)),
             child:Row(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Center(
                   child: Container(
                     width: 60.w,height: 60.h,

                     decoration: BoxDecoration(borderRadius:BorderRadius.circular(100.r),color: Colors.green,),),
                 ),

                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: EdgeInsets.only(left:8.0.w,top:20.h),
                       child: Text(_chatList[i].senderName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18.sp),),
                     ),
                     Padding(
                       padding: EdgeInsets.only(left:8.0.w,top:2.h),
                       child: Text(_chatList[i].message,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12.sp),),
                     ),
                   ],
                 ),

               ],
             )

           )

         ]),
   );
  }

}
