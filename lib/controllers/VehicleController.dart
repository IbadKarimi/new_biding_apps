

import 'dart:io';

import 'package:biding_app/model/VehicleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleController {

  Future<User> InsertVehicle(VehicleModel vehicleModel,Rx<File> image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId=prefs.getString("docId");

    // Upload Image in FireBase
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();  // with same name only one image is uploaded and time changes new images uploaded
    Reference refrence=FirebaseStorage.instance.ref().child("vehicleImages/$fileName");
    await refrence.putFile(image.value);
    String imageUrl=await refrence.getDownloadURL();

    try {
      CollectionReference realStateCollection = FirebaseFirestore.instance.collection('vehicle');

      // Add data to Firestore and get the DocumentReference
      DocumentReference documentRef = await realStateCollection.add({
        'id':docId,
        'buyerDocId':vehicleModel.buyerDocId ,
        'vehicleType':vehicleModel.vehicleType,
        'condition':vehicleModel.condition,
        'auctionType':vehicleModel.auctionType,
        'vehicleName':vehicleModel.vehicleName,
        'model':vehicleModel.model,
        'registerArea':vehicleModel.registerArea,
        'registerYear':vehicleModel.registerYear,
        'enginePower':vehicleModel.enginePower,
        'setBidPrice':vehicleModel.setBidPrice,
        'setBidEndTime':vehicleModel.setBidEndTime,
        'cityName':vehicleModel.cityName,
        'completeAddress':vehicleModel.completeAddress,
        'description':vehicleModel.description,
        'status':vehicleModel.status,
        'imagePath':imageUrl,
        // Other user data fields
      });
      String _docId = documentRef.id;
 try{
   FirebaseFirestore.instance.collection('HomePage').doc(_docId ).set({
     'userId':docId.toString(),
     'id':_docId.toString(),
     'name':vehicleModel.vehicleName ,
     'city':vehicleModel.cityName,
     'description':vehicleModel.description,
     'price':vehicleModel.setBidPrice,
     'imagePath':imageUrl,
     "auctionType":vehicleModel.auctionType,
     "categoryType":"Vehicle",
    'auctionType':vehicleModel.auctionType,

     // Other user data fields

   });
 }catch(e){
   print("Foreeeeeeeeeeeeeeeeee Base"+e.toString());
 }



     // return userCredential.user;

    }  on FirebaseAuthException catch (e) {

      return Future.error(e.message);
    } catch (e) {

      return Future.error("An error occurred while signing in.");
    }
  }


  Future<List<VehicleModel>> getVehicle()async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('vehicle').get();

    List<VehicleModel> users = [];
    querySnapshot.docs.forEach((doc) {
      users.add(VehicleModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<VehicleModel> data=[];
    data.addAll(users);


     return data;

  }


  Future<List<VehicleModel>> getVehicleById(String docId) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId=prefs.getString("id");
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('vehicle').doc(docId).get();
    if (documentSnapshot.exists) {
      // Document exists, you can access the data using documentSnapshot.data()
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      VehicleModel vehicle = VehicleModel.fromFirestore(data);
      return [vehicle];
      //List<UserModel> users=[user];

      //print("User on 0 index"+users[0].fullName);

    } else {
      // Document does not exist
      return [];
    }



  }




}