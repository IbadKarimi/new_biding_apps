

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
String setBidEndTime;
 String startPrice;
 String productId;
String categoryType;
 HomePageModel({required this.setBidEndTime,required this.categoryType,required this.productId,required this.docId,required this.name,required this.city,required this.price,required this.description,required this.imagePath,required this.categoryName,required this.status,required this.auctionType,required this.offer,required this.startPrice});

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
      setBidEndTime:data['setBidEndTime']??"",


    );
  }


  }

