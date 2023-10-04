




import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text('Bidding Sale System'), // App bar title (optional)
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
