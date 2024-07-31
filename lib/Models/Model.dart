// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Model {


  static const String COURSE='Course';
  static const String APPLICATION='Application';
  static const String COURSE_ATTENDANCE='CourseAttendance';
  static const String DRIVINGSCHOOL='DrivingSchool';
  static const String ENQUIRY='Enquiry';
  static const String INSTRUCTOR='Instructor';
  static const String LEARNER='Learner';
  static const String RATINGS='Ratings';
  static const String REVIEWS='Reviews';
  static const String SCHOOL_ATTENDANCE='SchoolAttendance';
  static const String SERVICE='Service';
  static const String VEHICLE='Vehicle';
  static const String COURSE_MESSAGE='CourseMessage';





String _docId='not set';
String collectionType;

Model({required this.collectionType});



Map<String, dynamic> toMap();
void fromSnapShot(DocumentSnapshot snapshot);

String getDocId()=>_docId;
void setDocId(String docId)=>_docId=docId;


Future<Model> autoDocId()async
{
  final docref=await FirebaseFirestore.instance.collection(collectionType).add({});
  _docId=docref.id;
  setToDB();
  return this;
}

  Future<void> setToDB()async
  {
    if(_docId=='not set')
    {
    await autoDocId();
    print('new document(id=$_docId) is created in Collection(id=$collectionType)');
    }
    await FirebaseFirestore.instance.collection(collectionType).doc(_docId).set(toMap());
  }

  Future<void> getFromDB()async
  {
    if(_docId=='not set')
    Error.throwError('docId NotSet');
    
    final docref=await FirebaseFirestore.instance.collection(collectionType).doc(_docId).get();
    fromSnapShot(docref);
  }

 static Future<void> getAllModels(List<String> docIds,List<Model> result)async
  {
  final refs=  await FirebaseFirestore.instance.collection(result.first.collectionType).
      where(FieldPath.documentId,whereIn: docIds).get();
      for (int i = 0; i < docIds.length; i++) {
        result[i].fromSnapShot(refs.docs[i]);
        print(i);
      }
   
  }

}


// class DB
// {

// static Map<String,dynamic> map={};

// }




class A extends Model
{
  String st;
    A({this.st='no st'}):super(collectionType: 'Test1');

    Map<String,dynamic> toMap()
    {
      return {
        'st':st,
      };
    }


void fromSnapShot(DocumentSnapshot snapshot) 
{
  Map<String,dynamic>  map=snapshot.data()! as Map<String,dynamic>;
  st=map['st'];
  _docId=snapshot.id;

}

   
}


class Error
{
  static void throwError(String error)
  {
    try{
      print('*****************************************\n***********$error************\n*****************************************');
      throw error;
    }catch(e)
    {
      print('Error catched\n$e');
    }
  }
}