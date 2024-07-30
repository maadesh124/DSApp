import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Learner.dart';

class Enquiry {
  final String learnerName;
  final double learnerAge;
  final bool isMale;
  final String learnerAddress;
  final String enquiryNo;
  final String learnerId;
  final List<Message> messages;

  Enquiry({
    required this.enquiryNo,
    required this.learnerId,
    this.messages = const [], 
   required this.isMale,
   required this.learnerAddress,
   required this.learnerAge,
   required this.learnerName,
    // Default to an empty list
  });

  Learner getLearner() => Examples.LEARNER;

  bool getStatus() {
    if (messages.isNotEmpty && messages.last.sender == 'DrivingSchool') {
      return true;
    }
    return false;


  }

  static Future<Enquiry> create(String dsObjectId,Learner learner,String learnerObjectId)async
  {
    final dsref=await FirebaseFirestore.instance.collection(DataBase.DRIVINGSCHOOL_COLLECTION).
    doc(dsObjectId).get();
    DrivingSchool ds=DrivingSchool.fromMap(dsref.data()!);
    
    Enquiry enquiry=Enquiry(enquiryNo: dsObjectId+ds.enquiryIds.length.toString(), learnerId:learnerObjectId ,
    learnerAge: learner.age+0.0,isMale: (learner.gender=='Male'),
    learnerName:learner.name,learnerAddress: learner.address, );

    final enqref=await FirebaseFirestore.instance.collection(DataBase.ENQUIRY_COLLECTION).
    add(enquiry.toMap());
    ds.enquiryIds.add(enqref.id);
    await FirebaseFirestore.instance.collection(DataBase.DRIVINGSCHOOL_COLLECTION).
    doc(dsObjectId).set(ds.toMap());
    return enquiry;
  }

  factory Enquiry.fromMap(Map<String, dynamic> map) {
    return Enquiry(
      learnerName: map['learnerName'],
      learnerAge: map['learnerAge'],
      learnerAddress:map['learnerAddress'] ,
      isMale: map['isMale'],
      enquiryNo: map['enquiryNo'] as String? ?? '',
      learnerId: map['learnerId'] as String? ?? '',
      messages: (map['messages'] as List<dynamic>?)
          ?.map((messageMap) => Message.fromMap(messageMap as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'learnerName':learnerName,
      'learnerAge':learnerAge,
      'learnerAddress':learnerAddress,
      'isMale':isMale,
      'enquiryNo': enquiryNo,
      'learnerId': learnerId,
      'messages': messages.map((message) => message.toMap()).toList(),
    };
  }

Future<Enquiry> addMessage(Message message,String objectId) async
{
  messages.add(message);
  await FirebaseFirestore.instance.collection(DataBase.ENQUIRY_COLLECTION).
  doc(objectId).set(this.toMap());

  return this;
}   

Future<String> getEnquiryObjectId()async
{
  final ref=await FirebaseFirestore.instance.collection(DataBase.ENQUIRY_COLLECTION).
  where('enquiryNo',isEqualTo: enquiryNo).get();

  return ref.docs.first.id;
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
