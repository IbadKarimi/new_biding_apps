

import 'dart:io';

import 'package:biding_app/model/VehicleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/AgricultureModel.dart';

class AgricultureController {

  Future<User> InsertAgriculture(AgricultureModel agricultureModel,Rx<File> image) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId=prefs.getString("docId");

    // Upload Image in FireBase
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();  // with same name only one image is uploaded and time changes new images uploaded
    Reference refrence=FirebaseStorage.instance.ref().child("agricultureImages/$fileName");


    await refrence.putFile(image.value);

    String imageUrl=await refrence.getDownloadURL();

    try {


      CollectionReference realStateCollection = FirebaseFirestore.instance.collection('agriculture');

      // Add data to Firestore and get the DocumentReference
      DocumentReference documentRef = await realStateCollection.add({
        'id':docId,
        'buyerDocId':agricultureModel.buyerDocId ,
        'typesCrop':agricultureModel.typesCrops,
        'workType':agricultureModel.workType,
        'areaType':agricultureModel.areaType,
        'range':agricultureModel.range,
        'auctionType':agricultureModel.auctionType,
        'setBidPrice':agricultureModel.setBidPrice,
        'setBidEndTime':agricultureModel.setBidEndTime,
        'cityName':agricultureModel.cityName,
        'completeAddress':agricultureModel.completeAddress,
        'description':agricultureModel.description,
        'status':agricultureModel.status,
        'imagePath':imageUrl,
        // Other user data fields
      });

      String _docId = documentRef.id;
      try{
        FirebaseFirestore.instance.collection('HomePage').doc().set({
          'userId':docId.toString(),
          'id':_docId.toString(),
          'name':agricultureModel.typesCrops ,
          'city':agricultureModel.cityName,
          'description':agricultureModel.description,
          'price':agricultureModel.setBidPrice,
          'imagePath':imageUrl,
          "auctionType":agricultureModel.auctionType

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




    try {


      FirebaseFirestore.instance.collection('home').doc().set({
        'id':docId,
        'name':agricultureModel.typesCrops ,
        'city':agricultureModel.cityName,
        'description':agricultureModel.description,
        'price':agricultureModel.setBidPrice,
        'imagePath':imageUrl

        // Other user data fields
      });

      // return userCredential.user;

    }  on FirebaseAuthException catch (e) {

      return Future.error(e.message);
    } catch (e) {

      return Future.error("An error occurred while Insert Agriculture Data.");
    }

  }


  Future<List<AgricultureModel>> getAgriculture()async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('agriculture').get();

    List<AgricultureModel> users = [];
    querySnapshot.docs.forEach((doc) {
      users.add(AgricultureModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<AgricultureModel> data=[];
    data.addAll(users);


    return data;

  }



  Future<List<  AgricultureModel >> getAgricultureById(String docId) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String docId=prefs.getString("id");
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('agriculture').doc(docId).get();
    if (documentSnapshot.exists) {
      // Document exists, you can access the data using documentSnapshot.data()
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      AgricultureModel agriculture =   AgricultureModel .fromFirestore(data);
      return [agriculture];
      //List<UserModel> users=[user];

      //print("User on 0 index"+users[0].fullName);

    } else {
      // Document does not exist
      return [];
    }



  }
}