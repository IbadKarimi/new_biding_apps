

import 'package:biding_app/model/HomePageModel.dart';
import 'package:biding_app/model/VehicleModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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



  void updateStatus(String documentId, String status) async {
    try {
      // Get the reference to the document you want to update
      DocumentReference documentReference = FirebaseFirestore.instance.collection('HomePage').doc(documentId);

      // Use the update method to update the specific variable
      await documentReference.update({
        'status': status,
      });

      print('Status updated successfully');
    } catch (e) {
      print('Error updating Status: $e');
    }
  }


  Future<String> InsertOffer(String productId,String categoryName,String price ,String offer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId=prefs.getString("docId"); //user id



    try {

        CollectionReference realStateCollection = FirebaseFirestore.instance.collection('offers');

        // Add data to Firestore and get the DocumentReference
        DocumentReference documentRef = await realStateCollection.add({
          'userId':userId,
          'productId':productId ,
          'startPrice':price,
          'offer':offer,
          'categoryName':categoryName,
          // Other user data fields
        });
        String _docId = documentRef.id;








    }  on FirebaseAuthException catch (e) {

      return Future.error(e.message);
    } catch (e) {

      return Future.error("An error occurred while signing in.");
    }

  }

  void updateOffer(String documentId, String offer) async {
    try {
      // Get the reference to the document you want to update
      DocumentReference documentReference = FirebaseFirestore.instance.collection('offers').doc(documentId);

      // Use the update method to update the specific variable
      await documentReference.update({
        'offer': offer,
      });
      String productId=documentReference.id.toString();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("productId", productId);
      print('Status updated successfully');
    } catch (e) {
      print('Error updating Status: $e');
    }
  }

  void updateStatusWithCollection(String documentId, String status,String collectionName) async {
    try {
      // Get the reference to the document you want to update
      DocumentReference documentReference = FirebaseFirestore.instance.collection(collectionName).doc(documentId);

      // Use the update method to update the specific variable
      await documentReference.update({
        'status': status,

      });

      print('Status updated successfully');
    } catch (e) {
      print('Error updating Status: $e');
    }
  }


  Future<List<HomePageModel>> getOffers()async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('offers').get();

    List<HomePageModel> getOffers = [];
    querySnapshot.docs.forEach((doc) {
      getOffers.add(HomePageModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<HomePageModel> data=[];
    data.addAll(getOffers);


    return data;

  }


}