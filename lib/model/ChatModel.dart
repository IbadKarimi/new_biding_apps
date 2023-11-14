

class ChatModel{
  String senderId;
  String recieverId;
  String message;
  String senderName;

  ChatModel({this.senderId,this.recieverId,this.message,this.senderName});

  factory  ChatModel.fromFirestore(Map<String, dynamic> data) {
    return ChatModel(
      senderId: data['senderId'] ??"",
      recieverId:data['recieverId'] ??"",
      message:data['message']??"",
      senderName:data['senderName']??"",
    );
  }

}