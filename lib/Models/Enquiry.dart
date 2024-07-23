

import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Learner.dart';

class Enquiry {
  final String enquiryNo;
  String learnerId;
  List<Message>? messages;
 
  Enquiry({
    required this.enquiryNo,
    this.messages,
    required this.learnerId
  });

  Learner getLearner()=>Examples.LEARNER;

  bool getStatus()
  {
    if(messages!.last.sender=='DrivingSchool')
    return true;
    return false;
  }

}


class Message {
  String? message;
  DateTime? dateTime;
  String? sender;

  Message({
    this.message,
    this.dateTime,
    this.sender
  });
}

