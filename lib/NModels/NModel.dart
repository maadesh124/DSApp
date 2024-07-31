// ignore_for_file: unnecessary_this, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Model {
  String _docId='not set';
  String collectionType;

Model({required this.collectionType});
static String TYPE1='Test1';


Map<String, dynamic> toMap();
void fromMap(Map<String, dynamic> map);

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
    fromMap(docref.data()!);
  }


}


class DB
{

static Map<String,dynamic> map={};

}




class A extends Model
{
  String st;
    A({this.st='no st'}):super(collectionType: Model.TYPE1);

    Map<String,dynamic> toMap()
    {
      return {
        'st':st,
        'id':_docId,
        'type':collectionType
      };
    }


void fromMap(Map<String, dynamic> map) 
{
  st=map['st'];
  _docId=map['id'];
  collectionType=map['type'];

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