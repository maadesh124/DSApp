// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Model.dart';

class Enquiry extends Model {
   String learnerName;
   double learnerAge;
   bool isMale;
   String learnerAddress;
   String enquiryNo;
   String learnerId;
   List<Message> messages;

  Enquiry({super.collectionType=Model.ENQUIRY,
     this.enquiryNo='Not Mentioned',
     this.learnerId='Not Mentioned',
    this.messages = const [], 
    this.isMale=true,
    this.learnerAddress='Not Mentioned',
    this.learnerAge=20,
    this.learnerName='Not Mentioned',
    // Default to an empty list
  });

  // Learner getLearner() => Examples.LEARNER;

  bool getStatus() {

for (Message message in messages)
if(message.sender==Model.DRIVINGSCHOOL)
return true;
    return false;


  }

  static Future<Enquiry> create(String dsObjectId,Learner learner,String learnerObjectId)async
  {

DrivingSchool ds=DrivingSchool();
ds.setDocId(dsObjectId);
await ds.getFromDB();
    
    Enquiry enquiry=Enquiry(enquiryNo: dsObjectId+ds.enquiryIds.length.toString(), learnerId:learnerObjectId ,
    learnerAge: learner.age+0.0,isMale: (learner.gender=='Male'),
    learnerName:learner.name,learnerAddress: learner.address, );

await enquiry.setToDB();
    ds.enquiryIds.add(enquiry.getDocId());
await ds.setToDB();
    return enquiry;
  }

  @override
  void fromSnapShot(DocumentSnapshot snapshot) {
Map<String, dynamic> map=snapshot.data()! as Map<String, dynamic>;
setDocId(snapshot.id);
      learnerName= map['learnerName'];
      learnerAge= map['learnerAge'];
      learnerAddress=map['learnerAddress'] ;
      isMale= map['isMale'];
      enquiryNo= map['enquiryNo'] as String? ?? '';
      learnerId= map['learnerId'] as String? ?? '';
      messages= (map['messages'] as List<dynamic>?)
          ?.map((messageMap) => Message.fromMap(messageMap as Map<String, dynamic>))
          .toList() ?? [];
  }

  @override
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
  await setToDB();

  return this;
}   

Future<void> getLearner()async
{
  Learner learner=Learner();
  learner.setDocId(learnerId);
  await learner.getFromDB();
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
