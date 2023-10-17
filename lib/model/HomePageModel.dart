

import 'AgricultureModel.dart';
import 'FurnitureModel.dart';
import 'RealStateModel.dart';
import 'VehicleModel.dart';

class HomePageModel{
  String docId;
 String name;
 String city;
 String price;
 String description;
 String imagePath;

 HomePageModel({this.docId,this.name,this.city,this.price,this.description,this.imagePath});

  factory   HomePageModel.fromFirestore(Map<String, dynamic> data) {
    return   HomePageModel(

      docId: data['docId'] ??"",
      name: data['name'] ??"",
      city:data['city']??"",
      price:data['price']??"",
      description:data['description']??"",
      imagePath: data['imagePath']??"",




    );
  }

  }

