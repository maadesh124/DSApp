import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/NModels/NModel.dart';



class NCourseMessage extends Model {
  List<Message> messages;

  NCourseMessage({this.messages = const [],super.collectionType=Model.COURSE_MESSAGE});

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
}
