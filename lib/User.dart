import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Model.dart';
 // Import your DrivingSchool class

class User {
  static DrivingSchool _currentSchool = DrivingSchool();
  static Instructor _currentIns=Instructor();
  static Learner _currentLearner=Learner(); 


    static Future<void> initializeDS(String docIda) async {
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

  static Future<void> initializeIns(String docIda) async {
    int n=0;
    _currentIns.setDocId(docIda);
    final docRef = FirebaseFirestore.instance.collection(Model.INSTRUCTOR).
    doc(User._currentIns.getDocId());

    // Fetch initial data
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      User._currentIns.fromSnapShot(snapshot);
    }

    // Listen for updates
    docRef.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        User._currentIns.fromSnapShot(snapshot);
        n++;
        print('changed'+n.toString());
        // print(_currentIns.toMap());
      }
    });
  }



    static Future<void> initializeLearner(String docIda) async {
    int n=0;
    _currentLearner.setDocId(docIda);
    final docRef = FirebaseFirestore.instance.collection(Model.LEARNER).
    doc(User._currentLearner.getDocId());

    // Fetch initial data
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      User._currentLearner.fromSnapShot(snapshot);
    }

    // Listen for updates
    docRef.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        User._currentLearner.fromSnapShot(snapshot);
        n++;
        print('changed'+n.toString());
        //  print(_currentLearner.toMap());
      }
    });
  }

  static Learner getLearner()=>User._currentLearner;

  static void setLearner()=>_currentLearner.setToDB();






  static DrivingSchool getDS()=>User._currentSchool;

  static void setDS(DrivingSchool ds)=>
    _currentSchool.setToDB();
  
  static Instructor getIns()=>User._currentIns;

  static void setIns(Instructor ins)=>ins.setToDB();
}


