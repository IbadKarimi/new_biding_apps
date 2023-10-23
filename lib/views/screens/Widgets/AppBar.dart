




import 'package:biding_app/views/screens/User/EditProfile.dart';
import 'package:biding_app/views/screens/User/ResetPassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text('Bidding Sale System'),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.amber,)),

        IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_sharp,color: Colors.amber,)),

        IconButton(onPressed: (){}, icon: Icon(Icons.person,color: Colors.amber,)),


        PopupMenuButton<int>(
          onSelected: (item) => handleClick(item),
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0, child: Text('Edit Profile',style: TextStyle(color: Colors.black),)),
            PopupMenuItem<int>(value: 1, child: Text('Reset password',style: TextStyle(color: Colors.black),)),

          ],
        ),



      ],// App bar title (optional)
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void handleClick(int item) {
    switch (item) {
      case 0:  Get.to(()=>EditProfileView());

        break;
      case 1: case 0:  Get.to(()=>ResetPasswordView());
        break;
    }
  }
}
