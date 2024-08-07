import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:fp4/Models/Model.dart';



class CourseMessage extends Model {
  List<Message> messages;

  CourseMessage({this.messages = const [],super.collectionType=Model.COURSE_MESSAGE});

  @override
  void fromSnapShot(DocumentSnapshot snapshot) {
    try {
  setDocId(snapshot.id);
  Map<String, dynamic> map=snapshot.data()! as Map<String,dynamic>;
  
    messages= (map['messages'] as List<dynamic>?)
        ?.map((messageMap) => Message.fromMap(messageMap as Map<String, dynamic>))
        .toList() ?? [];
} on Exception catch (e,s) {
  print('error $e');
  print('st $s');
}
    
  }


 Map<String,dynamic> toMap()
 {
   return {'messages': messages.map((message) => message.toMap()).toList()};
 }
}




class Message {
  final String message;
  final DateTime dateTime;
  final String sender;

  Message({
    this.message = '', // Default value
    required this.dateTime,
    this.sender = '', // Default valuep
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] as String? ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch((map['dateTime'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      sender: map['sender'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'dateTime': dateTime,
      'sender': sender,
    };
  }

  static Message fromChatMessage(ChatMessage chatMessage)
  {
    String sender='${chatMessage.user.firstName}|${chatMessage.user.id}';
   return Message(dateTime: chatMessage.createdAt,sender: sender,message: chatMessage.text);
  }

  ChatMessage toChatMessage()
  {
    ChatUser user=ChatUser(id: sender.split('|')[1],firstName: sender.split('|')[0]);
    return ChatMessage(user: user, createdAt: dateTime,text: message);
  }



}
