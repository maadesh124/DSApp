import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Examples.dart';
 // Import your DrivingSchool class

class User {
  static String docId = '';
  static DrivingSchool _currentSchool = DrivingSchool.fromMap({});

  static Future<void> initialize(String docIda) async {
    int n=0;
    User.docId = docIda;
    final docRef = FirebaseFirestore.instance.collection(DataBase.DRIVINGSCHOOL_COLLECTION).doc(User.docId);

    // Fetch initial data
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      User._currentSchool = DrivingSchool.fromMap(snapshot.data()!);
    }

    // Listen for updates
    docRef.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        User._currentSchool = DrivingSchool.fromMap(snapshot.data()!);
        n++;
        print('changed'+n.toString());
      }
    });
  }

  static DrivingSchool getDS()=>User._currentSchool;

  static setDS(DrivingSchool ds)=>
    FirebaseFirestore.instance.collection(DataBase.DRIVINGSCHOOL_COLLECTION).doc(docId).set(ds.toMap());
  
}
