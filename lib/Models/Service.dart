import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/Model.dart';



class Service extends Model{
String instructorName;
String name;
double fee;
String description;
String instructorId;
List<String> requiredDocuments;
List<String> studentObjectIds;
List<String> applicationObjectIds;
String ratingObjectId;
String reviewObjectId;

  Service({super.collectionType=Model.SERVICE,
    this.instructorName='',
    this.name='',
    this.fee=1500,
    this.description='',
    this.instructorId='',
    this.requiredDocuments=const [],
    this.studentObjectIds = const [], // Default to an empty list
    this.applicationObjectIds = const [], // Default to an empty list
    this.ratingObjectId = 'ratingid1',
    this.reviewObjectId = 'reviewid1',
  });



  // Future<Instructor> getInstructor()async
  // {
  //   final insref=await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
  //   doc(instructorId).get();
  //   return Instructor.fromMap(insref.data()!);
  // }

  // static Future<Service> createService(Service service)async
  // {

  // //add to ins
  // var insref=await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
  // doc(service.instructorId).get();
  // print(insref.data());
  // var ins=Instructor.fromMap(insref.data()!);
  // service.instructorName=ins.name;

  //   //add rating and review id
  
  // final revref= await FirebaseFirestore.instance.collection(DataBase.REVIEWS_COLLECTION).add({});
  // service.reviewObjectId=revref.id;


  //     //add service
  //  final docref= await FirebaseFirestore.instance.collection(DataBase.SERVICE_COLLECTION).add(service.toMap());
  // Review review=Review(receiver: 'Service',receiverId: docref.id);
  // revref.set(review.toMap());


  // ins.serviceIds.add(docref.id);
  // print(ins.toMap());
  // await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).doc(service.instructorId).
  // set(ins.toMap());








  
  // //add to ds
  // final ds=User.getDS();
  // ds.serviceIds.add(docref.id);
  // User.setDS(ds);


  

  //   return service;

  // }

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
      ratingObjectId= map['ratingObjectId'] as String? ?? '';
      reviewObjectId= map['reviewObjectId'] as String? ?? '';

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
      'ratingObjectId': ratingObjectId,
      'reviewObjectId': reviewObjectId,
    };
  }
}
