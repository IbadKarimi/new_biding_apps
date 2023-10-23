



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
import '../model/RealStateModel.dart';

class RealStateController {

  Future<User> InsertRealState(RealStateModel realStateModel,Rx<File> image) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId=prefs.getString("docId");

    // Upload Image in FireBase
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();  // with same name only one image is uploaded and time changes new images uploaded
    Reference refrence=FirebaseStorage.instance.ref().child("realStateImages/$fileName");
    await refrence.putFile(image.value);
    String imageUrl=await refrence.getDownloadURL();

    try {



      CollectionReference realStateCollection = FirebaseFirestore.instance.collection('realState');

      // Add data to Firestore and get the DocumentReference
      DocumentReference documentRef = await realStateCollection.add({
         "id":docId,
        'buyerDocId':realStateModel.buyerDocId ,
        'selectType':realStateModel.selectType,
        'areaType':realStateModel.areaType,
        'range':realStateModel.range,
        'noFloors':realStateModel.noFloors,
        'noBedrooms':realStateModel.noBedrooms,
        'noBathrooms':realStateModel.noBathrooms,
        'auctionType':realStateModel.auctionType,
        'setBidPrice':realStateModel.setBidPrice,
        'setBidEndTime':realStateModel.setBidEndTime,
        'cityName':realStateModel.cityName,
        'completeAddress':realStateModel.completeAddress,
        'description':realStateModel.description,
        'status':"",
        'imagePath':imageUrl,
        // Other user data fields
      });


      String _docId = documentRef.id;
      try{
        FirebaseFirestore.instance.collection('HomePage').doc(_docId ).set({
          'userId':docId.toString(),
          'id':_docId.toString(),
          'name':realStateModel.selectType,
          'city':realStateModel.cityName,
          'description':realStateModel.description,
          'price':realStateModel.setBidPrice,
          'imagePath':imageUrl,
          "auctionType":realStateModel.auctionType,
          "categoryType":"RealState",
          'auctionType':realStateModel.auctionType,
          'status':"",
          "setBidEndTime":realStateModel.setBidEndTime,

          // Other user data fields

        });}catch(e){print("Fire Base Error in Home Psage Insertion"+e.toString());}

      // return userCredential.user;

    }  on FirebaseAuthException catch (e) {

      return Future.error(e.message);
    } catch (e) {

      return Future.error("An error occurred while Insert Real State Data.");
    }
  }


  Future<User> InsertRealStateCommercial(RealStateModel realStateModel,Rx<File> image) async {
    String _collectionId="";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId=prefs.getString("docId");

    // Upload Image in FireBase
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();  // with same name only one image is uploaded and time changes new images uploaded
    Reference refrence=FirebaseStorage.instance.ref().child("realStateImages/$fileName");
    await refrence.putFile(image.value);
    String imageUrl=await refrence.getDownloadURL();

    try {
      CollectionReference realStateCollection = FirebaseFirestore.instance.collection('realState');

      // Add data to Firestore and get the DocumentReference
      DocumentReference documentRef = await realStateCollection.add({
        'buyerDocId': realStateModel.buyerDocId,
        'selectType': realStateModel.selectType,
        'areaType': realStateModel.areaType,
        'range': realStateModel.range,
        'noFloors': realStateModel.noFloors,
        'noBedrooms': realStateModel.noBedrooms,
        'noBathrooms': realStateModel.noBathrooms,
        'auctionType': realStateModel.auctionType,
        'setBidPrice': realStateModel.setBidPrice,
        'setBidEndTime': realStateModel.setBidEndTime,
        'cityName': realStateModel.cityName,
        'completeAddress': realStateModel.completeAddress,
        'description': realStateModel.description,
        'status': realStateModel.status,
        'imagePath': imageUrl,
        // Other user data fields
      });

      // Get the document ID from the DocumentReference
      _collectionId =  documentRef.id.toString();

  try{
    FirebaseFirestore.instance.collection('HomePage').doc().set({
      'userId':docId.toString(),
      'id':_collectionId.toString(),
      'name':realStateModel.selectType ,
      'city':realStateModel.cityName,
      'description':realStateModel.description,
      'price':realStateModel.setBidPrice,
      'imagePath':imageUrl

      // Other user data fields

    });
  }catch(e){print(e);}


      print('Real State document added with ID: $docId');
      // You can now use the docId or return it from the function if needed.
    } catch (e) {
      print('Error occurred while adding Real State data: $e');
      // Handle the error as needed, for example, throw an exception or return an error message.
    }

    //----------Home

    try {




      // return userCredential.user;

    }  on FirebaseAuthException catch (e) {

      return Future.error(e.message);
    } catch (e) {

      return Future.error("An error occurred while Insert Agriculture Data.");
    }

  }


  Future<List<RealStateModel>> getrealState()async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('realState').get();

    List<RealStateModel> users = [];
    querySnapshot.docs.forEach((doc) {
      users.add(RealStateModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<RealStateModel> data=[];
    data.addAll(users);


    return data;

  }

  Future<List<RealStateModel>> getRealEstateById(String docId) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _docId=prefs.getString("id");

    print("ID in Function"+_docId.toString());
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('realState').doc(_docId).get();
    if (documentSnapshot.exists) {
      // Document exists, you can access the data using documentSnapshot.data()
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      RealStateModel realStateModel = RealStateModel.fromFirestore(data);
      return [realStateModel];
      //List<UserModel> users=[user];

      //print("User on 0 index"+users[0].fullName);

    } else {
      // Document does not exist
      return [];
    }



  }

}