

import 'dart:io';

import 'package:biding_app/model/OtherCategoryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherCategoryController{

  Future<User> InsertOtherCategory(OtherCategoryModel otherCategoryModel,Rx<File> image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId = prefs.getString("docId");

    // Upload Image in FireBase
    String fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString(); // with same name only one image is uploaded and time changes new images uploaded
    Reference refrence = FirebaseStorage.instance.ref().child(
        "furnitureImages/$fileName");
    await refrence.putFile(image.value);
    String imageUrl = await refrence.getDownloadURL();

    try {
      FirebaseFirestore.instance.collection('otherCategory').doc().set({
        'id': docId,
        'buyerDocId': otherCategoryModel.buyerDocId,
        'categoryName': otherCategoryModel.categoryName,
        'condition': otherCategoryModel.condition,
        'selectType': otherCategoryModel.selectType,
        'auctionType': otherCategoryModel.auctionType,
        'setBidPrice': otherCategoryModel.setBidPrice,
        'setBidEndTime': otherCategoryModel.setBidEndTime,
        'cityName': otherCategoryModel.cityName,
        'completeAddress': otherCategoryModel.completeAddress,
        'description': otherCategoryModel.description,
        'status': otherCategoryModel.status,
        'imagePath': imageUrl,
        // Other user data fields
      });

      // return userCredential.user;

    } on FirebaseAuthException catch (e) {
      return Future.error(e.message);
    } catch (e) {
      return Future.error("An error occurred while Insert Agriculture Data.");
    }
  }


  Future<List<OtherCategoryModel>> getOtherCategory()async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('otherCategory').get();

    List<OtherCategoryModel> users = [];
    querySnapshot.docs.forEach((doc) {
      users.add(OtherCategoryModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<OtherCategoryModel> data=[];
    data.addAll(users);


    return data;

  }
}