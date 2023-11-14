import 'package:biding_app/views/screens/Widgets/AppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  String recieverId;
  ChatScreen({this.recieverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User _user;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((user) {
      setState(() {
        _user = user;

      });
    });
  }

  void _sendMessage() async {

    if (_message.isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': _message,
        'senderId': _user.uid,
        'reciverId':widget.recieverId,
        'timestamp': FieldValue.serverTimestamp(),
        'senderName':_user.email,
      });
      setState(() {
        _message = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),


      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('messages')

                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                var messages = snapshot.data.docs;
                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  var messageText = message['text'];
                  var messageSender = message['senderName'];

                  var messageWidget =
                  MessageWidget(messageSender, messageText,true);
                  messageWidgets.add(messageWidget);
                  if (!snapshot.hasData) {

                    return Center(
                      child: CircularProgressIndicator()
                    );
                  }

                }
                return ListView(
                  reverse: true,
                  children: messageWidgets,
                );
              },
            ),
          ),
          _user != null
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        _message = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}


class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;
  final bool isSender;

  MessageWidget(this.sender, this.text, this.isSender);

  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment messageAlignment =
    isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    Color messageColor = isSender ? Colors.white : Colors.black;

    return Align(
      alignment: isSender ? Alignment.topLeft : Alignment.topRight,
      child: Container(

        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.amber : Colors.grey[300],
          borderRadius: isSender
              ? BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          )
              : BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: messageAlignment,
          children: <Widget>[

            Text(
              sender,
              style: TextStyle(
                fontSize: 12.0,
                color: messageColor,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



