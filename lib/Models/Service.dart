import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/Models/Reviews.dart';
import 'package:fp3/User.dart';



class Service extends Model{
String instructorName;
String name;
double fee;
String description;
String instructorId;
List<String> requiredDocuments;
List<String> studentObjectIds;
List<String> applicationObjectIds;
String schoolName;
String schoolObjectId;
String reviewObjectId;
String instructorObjectId;

  Service({super.collectionType=Model.SERVICE,
    this.schoolName='not mentioned',
    this.schoolObjectId='not mentioned',
    this.instructorName='',
    this.name='',
    this.fee=1500,
    this.description='',
    this.instructorId='',
    this.instructorObjectId='',
    this.requiredDocuments=const [],
    this.studentObjectIds = const [], // Default to an empty list
    this.applicationObjectIds = const [], // Default to an empty list
    this.reviewObjectId = 'reviewid1',
  });



  Future<Instructor> getInstructor()async
  {
    Instructor instructor=Instructor();
    instructor.setDocId(instructorObjectId);
    await instructor.getFromDB();
    return instructor;
  }

  static Future<Service> createService(Service service)async
  {

  //get instructor
  var insref=await FirebaseFirestore.instance.collection(Model.INSTRUCTOR).
  where('insId',isEqualTo: service.instructorId).
  where('schoolId',isEqualTo: service.schoolObjectId).get();
  Instructor instructor=Instructor();
  instructor.fromSnapShot(insref.docs.first);

//get Review
Review review=Review();
await review.autoDocId();

//set fields and update to db
service.reviewObjectId=review.getDocId();
service.instructorName=instructor.name;
service.instructorObjectId=insref.docs.first.id;
await service.setToDB();

//set and update review fields
review.receiverId=service.getDocId();
await review.setToDB();

//update instructor
instructor.serviceIds.add(service.getDocId());
await instructor.setToDB();

//update school
final ds=User.getDS();
ds.serviceIds.add(service.getDocId());
User.setDS(ds);

    return service;

  }

  // Future<void> setIds()async
  // {

  // }

@override
  void fromSnapShot(DocumentSnapshot snapshot) {
Map<String, dynamic> map=snapshot.data()! as Map<String, dynamic>;
setDocId(snapshot.id);

      instructorName= map['instructorName'];
      name= map['name'] as String? ?? '';
      fee= map['fee'] as double? ?? 0.0;
      description= map['description'] as String? ?? '';
      instructorId= map['instructorId'] as String? ?? '';
      requiredDocuments= List<String>.from(map['requiredDocuments'] ?? []);
      studentObjectIds= List<String>.from(map['studentObjectIds'] ?? []);
      applicationObjectIds= List<String>.from(map['applicationObjectIds'] ?? []);
      schoolName= map['schoolName'] as String? ?? '';
      schoolObjectId=map['schoolObjectId'] as String? ?? 'not mentioned'; 
      reviewObjectId= map['reviewObjectId'] as String? ?? '';
      instructorObjectId=map['instructorObjectId'] as String? ?? 'not mentioned';

  }

  Map<String, dynamic> toMap() {
    return {
      'instructorName':instructorName,
      'name': name,
      'fee': fee,
      'description': description,
      'instructorId': instructorId,
      'requiredDocuments': requiredDocuments,
      'studentObjectIds': studentObjectIds,
      'applicationObjectIds': applicationObjectIds,
      'schoolObjectId':schoolObjectId,
      'schoolName0':schoolName,
      'reviewObjectId': reviewObjectId,
      'instructorObjectId':instructorObjectId,
    };
  }
}
