import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/UserModel.dart';


class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Obtain shared preferences.


  Future<User?> InsertSignUp(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      FirebaseFirestore.instance.collection('userSignUp').doc(userCredential.user!.uid).set({
        'phoneNo':user.phoneNo ,
        'fullName':user.fullName,
        'id':userCredential.user!.uid,
        'imagePath':""
        // Other user data fields
      });

      await prefs.setString('docId', userCredential.user!.uid.toString());
      return userCredential.user;

    }  on FirebaseAuthException catch (e) {

      return Future.error(e.message.toString());
    } catch (e) {

      return Future.error("An error occurred while signing in.");
    }
  }


  Future InsertImage(Rx<File> image)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String ?docId = prefs.getString('docId');



    String fileName = DateTime.now().millisecondsSinceEpoch.toString();  // with same name only one image is uploaded and time changes new images uploaded
    Reference refrence=FirebaseStorage.instance.ref().child("images/$fileName");
    await refrence.putFile(image.value);
    String downloadUrl=await refrence.getDownloadURL();
    print("--------------------------------------------------"+downloadUrl.toString());


   updatePicture(docId!, downloadUrl);

  }

  // Collection data updated
  Future updatePicture(String docId, String imagePath)async{


    var collection = FirebaseFirestore.instance.collection('userSignUp');
    collection
        .doc(docId) // <-- Doc ID where data should be updated.
        .update({'imagePath' : imagePath.toString()}) // <-- Updated data
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));


  }


  Future<User?> signIn(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await prefs.setString('docId', userCredential.user!.uid.toString());
      return userCredential.user;

    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      return Future.error(e.message.toString());
    } catch (e) {
      // Handle other errors
      return Future.error("An error occurred while signing in.");
    }
  }




  Future<List<UserModel>> getUserSignUp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? docId=prefs.getString("docId");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('userSignUp').get();
    List<UserModel> data = [];
    querySnapshot.docs.forEach((doc) {
      data.add(doc['fullName']);
      data.add(doc['imagePath']);
      data.add(doc['phoneNo']);// Replace 'fieldName' with the actual field name in your Firestore document
    });

    print("data================================="+data.toString());
    return data;
  }



  Future<List<UserModel>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? docId = prefs.getString('docId');

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('userSignUp').doc(docId).get();
    if (documentSnapshot.exists) {
      // Document exists, you can access the data using documentSnapshot.data()
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromFirestore(data);
      return [user];
      //List<UserModel> users=[user];

      //print("User on 0 index"+users[0].fullName);

    } else {
      // Document does not exist
      return [];
    }



  }



  Future<void> InsertFeedBack(String email,String feedback) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {


      FirebaseFirestore.instance.collection('FeedBack').doc().set({
        'email':email ,
        'feedBack':feedback,

        // Other user data fields
      });



    }  on FirebaseAuthException catch (e) {

      return Future.error(e.message.toString());
    } catch (e) {

      return Future.error("An error occurred while signing in.");
    }
  }

  Future<List<UserModel>> getFeedBack()async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('FeedBack').get();

    List<UserModel> users = [];
    querySnapshot.docs.forEach((doc) {
      users.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<UserModel> data=[];
    data.addAll(users);


    return data;

  }

  Future<void> updateName(String name) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? docId = prefs.getString('docId');//userID
    FirebaseFirestore.instance
        .collection('your_collection_name') // Replace 'your_collection_name' with your actual collection name
        .doc(docId) // Specify the document ID you want to update
        .update({
      'name': name, // Update the 'name' field with the new value
      // Add more fields if you want to update multiple fields at once
    })
        .then((_) {
      print('Document successfully updated!');
    })
        .catchError((error) {
      print('Error updating document: $error');
    });
  }

  Future<void> updateEmail(String newEmail) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateEmail(newEmail);

        await user.sendEmailVerification();
        print('Email updated successfully to $newEmail');
      } catch (e) {
        print('Failed to update email: $e');
        throw e;
      }
    } else {
      print('User not authenticated.');
      // Handle this scenario (e.g., redirect to sign-in page)
    }
  }


  Future<List<UserModel>> getUserNameById() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _docId=prefs.getString("id");

    print("ID in Function"+_docId.toString());
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('userSignUp').doc(_docId).get();
    if (documentSnapshot.exists) {
      // Document exists, you can access the data using documentSnapshot.data()
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      UserModel realStateModel = UserModel.fromFirestore(data);
      return [realStateModel];
      //List<UserModel> users=[user];

      //print("User on 0 index"+users[0].fullName);

    } else {
      // Document does not exist
      return [];
    }



  }
  createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();
    if (snapShot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
        ..collection("chatrooms").doc(chatRoomId).set(chatRoomInfoMap);
    }
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastSendedMessage(
      String chatRoomId, Map<String, dynamic> lastMsgInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMsgInfoMap);
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getUserName(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

  Future<Stream<QuerySnapshot>> getChatRooms(String userName) async {

    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("time", descending: true)
        .where("users", arrayContains: userName)
        .snapshots();
  }

  Future<String> getFullNameById(String userId) async {
    String userName = '';
    try {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('userSignUp').doc(userId).get();
      if (userDoc.exists) {
        userName = userDoc.get('fullName');
        print("User name is "+userName );
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return userName;
  }

}










