

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
    String? userId=prefs.getString("docId"); //user id



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

      return Future.error(e.message.toString());
    } catch (e) {

      return Future.error("An error occurred while signing in.");
    }
return "";
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

  Future<String> getOffersById(String _docId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance.collection('offers').doc(_docId).get();

      if (documentSnapshot.exists) {
        // Document exists, you can access the data using documentSnapshot.data()
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          HomePageModel homePageModel = HomePageModel.fromFirestore(data);

          if (homePageModel.offer != null) {
            print("Offer Amount is ${homePageModel.offer}");
            return homePageModel.offer.toString();
          } else {
            // Handle the case where offer is null
            return "Offer not available";
          }
        } else {
          // Handle the case where data is null
          return "Data not available";
        }
      } else {
        // Document does not exist
        return "";
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print("Error: $e");
      return "Error fetching offer";
    }
  }



// Function to get vehicle data of a specific type
  Future<List<HomePageModel>> getBiddingData() async {
    // Reference to the Firestore collection
    CollectionReference vehicles = FirebaseFirestore.instance.collection('HomePage');


      // Query the collection and get documents where 'auctionType' is 'bidding'
      QuerySnapshot querySnapshot = await vehicles.where('auctionType', isEqualTo: 'Biding').get();
      List<HomePageModel> getOffers = [];
      querySnapshot.docs.forEach((doc) {
        getOffers.add(HomePageModel.fromFirestore(doc.data() as Map<String, dynamic>));
      });


      List<HomePageModel> data=[];
      data.addAll(getOffers);


      return data;



  }

  Future<List<HomePageModel>> geFixedAuctionData() async {
    // Reference to the Firestore collection
    CollectionReference vehicles = FirebaseFirestore.instance.collection('HomePage');


    // Query the collection and get documents where 'auctionType' is 'bidding'
    QuerySnapshot querySnapshot = await vehicles.where('auctionType', isEqualTo: 'Fixed Auction').get();
    List<HomePageModel> getOffers = [];
    querySnapshot.docs.forEach((doc) {
      getOffers.add(HomePageModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<HomePageModel> data=[];
    data.addAll(getOffers);


    return data;



  }


// Call the function to get bidding vehicles




}