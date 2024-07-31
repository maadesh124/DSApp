import 'package:fp3/Models/Enquiry.dart';



class CourseMessage {
  List<Message> messages;

  CourseMessage({this.messages = const []});

  factory CourseMessage.fromMap(Map<String, dynamic> map) {
    return CourseMessage(
      messages: (map['messages'] as List<dynamic>?)
          ?.map((messageMap) => Message.fromMap(messageMap as Map<String, dynamic>))
          .toList() ?? [],
    );
  }


 Map<String,dynamic> toMap()
 {
   return {'messages': messages.map((message) => message.toMap()).toList()};
 }
}
