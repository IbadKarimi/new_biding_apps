

import 'package:biding_app/model/HomePageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageController{


  Future<List<HomePageModel>> getCategoriesData()async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('HomePage').get();

    List<HomePageModel> users = [];
    querySnapshot.docs.forEach((doc) {
      users.add(HomePageModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<HomePageModel> data=[];
    data.addAll(users);


    return data;

  }
}