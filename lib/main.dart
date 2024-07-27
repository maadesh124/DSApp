import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/CourseView.dart';
import 'package:fp3/DrivingSchool/CreateCourse.dart';
import 'package:fp3/DrivingSchool/CreateInstructor.dart';
import 'package:fp3/DrivingSchool/CreateService.dart';
import 'package:fp3/DrivingSchool/CreateVehicle.dart';
import 'package:fp3/DrivingSchool/InstructorView.dart';
import 'package:fp3/DrivingSchool/ServiceView.dart';
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


 Course? gcourse;
 Service? gservice;
 Instructor? ginstructor;
void main() async{

    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 FirebaseFirestore db=FirebaseFirestore.instance;
 User.initialize('w42tQh0oLjlD0LsEGxPs');


  //  final coref= await db.collection(DataBase.COURSE_COLLECTION).doc('3T7477jI3CepWry9vlAo').get();
  //   gcourse=Course.fromMap(coref.data()!);

    //   final leref= await db.collection(DataBase.LEARNER_COLLECTION).doc('3ls1508zatxqMzCx0VIY').get();
    // final learner=Learner.fromMap(leref.data()!);

    // Application.createCourse(course!, learner, '3ls1508zatxqMzCx0VIY');
  //  final insref= await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
  //  doc('rI2UWWwSz85LBnmbz1Ig').get();
  //  print(insref.data()!);


//   final l=  await DataBase.getAllDocuments(ids,DataBase.APPLICATION_COLLECTION);
//   List<Application> list=[];
//   l.forEach((doc)=>list.add(Application.fromMap(doc)));
//   print(list.first.toMap());

  // final leref= await db.collection(DataBase.LEARNER_COLLECTION).add(Examples.LEARNER.toMap());
//     final learner=Learner.fromMap(leref.data()!);

//  await Enquiry.create('w42tQh0oLjlD0LsEGxPs',learner,'XiTB0DaQwd1Lqnz9MpNa');

  //  final leref= await db.collection(DataBase.LEARNER_COLLECTION).doc('XiTB0DaQwd1Lqnz9MpNa').get();
  //   final learner=Learner.fromMap(leref.data()!);

// final servref=await FirebaseFirestore.instance.collection(DataBase.SERVICE_COLLECTION).
// doc('ShkFj4H1djYVJkiznHJH').get();
//  gservice=Service.fromMap(servref.data()!);
//  final ins= await service!.getInstructor();
//  print(ins.toMap());

final insref=await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
doc('rI2UWWwSz85LBnmbz1Ig').get();
ginstructor=Instructor.fromMap(insref.data()!);


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
       // body:CourseView(course: course!),
        body:InstructorView(instructor: ginstructor!,),
      ),
    );
  }
}



TimeOfDay parseTimeOfDay(String time) {
  // Split the string into hour and minute components
  final parts = time.split(':');
  if (parts.length != 2) {
    throw FormatException('Invalid time format. Expected HH:MM');
  }

  // Parse the hour and minute components
  final hour = int.tryParse(parts[0]);
  final minute = int.tryParse(parts[1]);

  if (hour == null || minute == null) {
    throw FormatException('Invalid hour or minute');
  }

  // Construct and return a TimeOfDay instance
  return TimeOfDay(hour: hour, minute: minute);
}