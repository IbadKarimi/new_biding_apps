

class ChatModel{
  String senderId;
  String recieverId;
  String message;
  String senderName;

  ChatModel({required this.senderId,required this.recieverId,required this.message,required this.senderName});

  factory  ChatModel.fromFirestore(Map<String, dynamic> data) {
    return ChatModel(
      senderId: data['senderId'] ??"",
      recieverId:data['recieverId'] ??"",
      message:data['message']??"",
      senderName:data['senderName']??"",
    );
  }

}