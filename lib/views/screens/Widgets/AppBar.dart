




import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text('Bidding Sale System'),
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_sharp,color: Colors.amber,)),],// App bar title (optional)
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
