import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Model.dart';
 // Import your DrivingSchool class

class User {
  static DrivingSchool _currentSchool = DrivingSchool();

  static Future<void> initialize(String docIda) async {
    int n=0;
    _currentSchool.setDocId(docIda);
    final docRef = FirebaseFirestore.instance.collection(Model.DRIVINGSCHOOL).
    doc(User._currentSchool.getDocId());

    // Fetch initial data
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      User._currentSchool.fromSnapShot(snapshot);
    }

    // Listen for updates
    docRef.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        User._currentSchool.fromSnapShot(snapshot);
        n++;
        print('changed'+n.toString());
      }
    });
  }

  static DrivingSchool getDS()=>User._currentSchool;

  static setDS(DrivingSchool ds)=>
    _currentSchool.setToDB();
  
}


