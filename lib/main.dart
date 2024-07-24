import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/DrivingSchool/CreateInstructor.dart';
import 'package:fp3/DrivingSchool/CreateService.dart';
import 'package:fp3/DrivingSchool/test.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/CourseAttendance.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Enquiry.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Ratings.dart';
import 'package:fp3/Models/Reviews.dart';
import 'package:fp3/Models/SchoolAttendance.dart';
import 'package:fp3/Models/Service.dart';
import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/User.dart';
import 'package:fp3/firebase_options.dart';

void main() async{

    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 //FirebaseFirestore db=FirebaseFirestore.instance;
  // var docs= await db.collection(DataBase.DRIVINGSCHOOL_COLLECTION).doc('w42tQh0oLjlD0LsEGxPs').
  // set(Examples.DRIVINGSCHOOL.toMap());//.then((qurysnap)

  await User.initialize('w42tQh0oLjlD0LsEGxPs');
  print('hello');
  print(User.getDS().description);

  // db.collection('Test').doc('t1').get().then((value) {
  //   Vehicle r=Vehicle.fromMap(value.data()!);
  //   print(r.timeTable.runtimeType);
  // },);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //ppBar: AppBar(title: Text('Checkbox Example')),
        body:CreateService(),
      ),
    );
  }
}