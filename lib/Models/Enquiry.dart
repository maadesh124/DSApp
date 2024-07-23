import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Learner.dart';

class Enquiry {
  final String enquiryNo;
  final String learnerId;
  final List<Message> messages;

  Enquiry({
    required this.enquiryNo,
    required this.learnerId,
    this.messages = const [], // Default to an empty list
  });

  Learner getLearner() => Examples.LEARNER;

  bool getStatus() {
    if (messages.isNotEmpty && messages.last.sender == 'DrivingSchool') {
      return true;
    }
    return false;
  }

  factory Enquiry.fromMap(Map<String, dynamic> map) {
    return Enquiry(
      enquiryNo: map['enquiryNo'] as String? ?? '',
      learnerId: map['learnerId'] as String? ?? '',
      messages: (map['messages'] as List<dynamic>?)
          ?.map((messageMap) => Message.fromMap(messageMap as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enquiryNo': enquiryNo,
      'learnerId': learnerId,
      'messages': messages.map((message) => message.toMap()).toList(),
    };
  }
}

class Message {
  final String message;
  final DateTime dateTime;
  final String sender;

  Message({
    this.message = '', // Default value
    required this.dateTime,
    this.sender = '', // Default value
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
