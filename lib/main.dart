import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/CourseView.dart';
import 'package:fp3/DrivingSchool/CreateCourse.dart';
import 'package:fp3/DrivingSchool/CreateInstructor.dart';
import 'package:fp3/DrivingSchool/CreateService.dart';
import 'package:fp3/DrivingSchool/CreateVehicle.dart';
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


 Course? course;
void main() async{

    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 FirebaseFirestore db=FirebaseFirestore.instance;
 User.initialize('w42tQh0oLjlD0LsEGxPs');

   final coref= await db.collection(DataBase.COURSE_COLLECTION).doc('3T7477jI3CepWry9vlAo').get();
    course=Course.fromMap(coref.data()!);
//   final l=  await DataBase.getAllDocuments(ids,DataBase.APPLICATION_COLLECTION);
//   List<Application> list=[];
//   l.forEach((doc)=>list.add(Application.fromMap(doc)));
//   print(list.first.toMap());

  // final leref= await db.collection(DataBase.LEARNER_COLLECTION).add(Examples.LEARNER.toMap());
//     final learner=Learner.fromMap(leref.data()!);

//  await Enquiry.create('w42tQh0oLjlD0LsEGxPs',learner,'XiTB0DaQwd1Lqnz9MpNa');

  //  final leref= await db.collection(DataBase.LEARNER_COLLECTION).doc('XiTB0DaQwd1Lqnz9MpNa').get();
  //   final learner=Learner.fromMap(leref.data()!);





  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   final double screenWidth=MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //ppBar: AppBar(title: Text('Checkbox Example')),
        body:CreateCourse(),
      ),
    );
  }
}