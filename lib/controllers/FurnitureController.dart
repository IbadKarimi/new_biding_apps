



import 'dart:io';

import 'package:biding_app/model/FurnitureModel.dart';
import 'package:biding_app/model/VehicleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/AgricultureModel.dart';

class FurnitureController {

  Future<User> InsertFurniture(FurnitureModel furnitureModel,Rx<File> image) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId=prefs.getString("docId");

    // Upload Image in FireBase
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();  // with same name only one image is uploaded and time changes new images uploaded
    Reference refrence=FirebaseStorage.instance.ref().child("furnitureImages/$fileName");
    await refrence.putFile(image.value);
    String imageUrl=await refrence.getDownloadURL();

    try {


      CollectionReference furnitureCollection = FirebaseFirestore.instance.collection('furniture');

      // Add data to Firestore and get the DocumentReference
      DocumentReference documentRef = await furnitureCollection .add({
        'id':docId,
        'buyerDocId':furnitureModel.buyerDocId ,
        'makingMaterial':furnitureModel.makingMaterial,
        'condition':furnitureModel.condition,
        'selectType':furnitureModel.selectType,

        'auctionType':furnitureModel.auctionType,
        'setBidPrice':furnitureModel.setBidPrice,
        'setBidEndTime':furnitureModel.setBidEndTime,
        'cityName':furnitureModel.cityName,
        'completeAddress':furnitureModel.completeAddress,
        'description':furnitureModel.description,
        'status':furnitureModel.status,
        'imagePath':imageUrl,
        'remainingTime':furnitureModel.remainingTime
        // Other user data fields
      });

      String _docId = documentRef.id;
      try{
        FirebaseFirestore.instance.collection('HomePage').doc().set({
          'userId':docId.toString(),
          'id':_docId.toString(),
          'name':furnitureModel.makingMaterial,
          'city':furnitureModel.cityName,
          'description':furnitureModel.description,
          'price':furnitureModel.setBidPrice,
          'imagePath':imageUrl,
          "auctionType":furnitureModel.auctionType

          // Other user data fields

        });
      }catch(e){
        print("Foreeeeeeeeeeeeeeeeee Base"+e.toString());
      }

      // return userCredential.user;

    }  on FirebaseAuthException catch (e) {

      return Future.error(e.message);
    } catch (e) {

      return Future.error("An error occurred while Insert Agriculture Data.");
    }



  }

  Future<List<FurnitureModel>> getFurniture()async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('furniture').get();

    List<FurnitureModel> users = [];
    querySnapshot.docs.forEach((doc) {
      users.add(FurnitureModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<FurnitureModel> data=[];
    data.addAll(users);


    return data;

  }


  Future<List<  FurnitureModel >> getFurnitureById(String docId) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId=prefs.getString("id");
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('furniture').doc(docId).get();
    if (documentSnapshot.exists) {
      // Document exists, you can access the data using documentSnapshot.data()
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      FurnitureModel furniture =   FurnitureModel .fromFirestore(data);
      return [furniture];
      //List<UserModel> users=[user];

      //print("User on 0 index"+users[0].fullName);

    } else {
      // Document does not exist
      return [];
    }



  }



}