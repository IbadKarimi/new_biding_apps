

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ChatModel.dart';

class ChatController {

  Future<List<ChatModel>> getChatById() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('messages').get();

    List<ChatModel> getOffers = [];
    querySnapshot.docs.forEach((doc) {
      getOffers.add(ChatModel.fromFirestore(doc.data() as Map<String, dynamic>));
    });


    List<ChatModel> data=[];
    data.addAll(getOffers);


    return data;
  }
}