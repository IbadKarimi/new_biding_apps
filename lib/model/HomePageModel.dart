

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
 String categoryName;
 String status;
 String auctionType;
 String offer;

 String startPrice;
 String productId;
String categoryType;
 HomePageModel({this.categoryType,this.productId,this.docId,this.name,this.city,this.price,this.description,this.imagePath,this.categoryName,this.status,this.auctionType,this.offer,this.startPrice});

  factory   HomePageModel.fromFirestore(Map<String, dynamic> data) {
    return   HomePageModel(

      docId: data['id'] ??"",
      name: data['name'] ??"",
      city:data['city']??"",
      price:data['price']??"",
      description:data['description']??"",
      imagePath: data['imagePath']??"",
      categoryName:data['categoryName']??"",
      status: data['status']??"",
      auctionType: data['auctionType']??"",
      offer: data['offer']??"",
      startPrice: data['startPrice']??"",
      productId: data['productId']??"",
      categoryType:data['categoryType']??"",




    );
  }


  }

