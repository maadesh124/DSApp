import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/DrivingSchool/AllOverView.dart';

import 'package:fp3/User.dart'  as CustomUser; 
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Service.dart';
import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/Screens/AuthScreen.dart';

import 'package:fp3/firebase_options.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Models/Course.dart';

Learner? glearner;
Course? gcourse;
Service? gservice;
Instructor? ginstructor;
Vehicle? gvehicle;
List<String> gcourseIds = [
  '3T7477jI3CepWry9vlAo',
  'MTP1d152cEJAbafZjxF6',
  'jMfMnZfxiG1O70RGSqW2'
];
List<String> gserviceIds = ['ShkFj4H1djYVJkiznHJH'];
List<String> ginstructorIds = ['rI2UWWwSz85LBnmbz1Ig'];
List<String> gvehicleIds = ['52kIF9TLyv4L7CXPgRAh', 'rI2UWWwSz85LBnmbz1Ig'];
Application? gapplication;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore db = FirebaseFirestore.instance;
  await CustomUser.User.initialize('w42tQh0oLjlD0LsEGxPs');

  //  final coref= await db.collection(DataBase.COURSE_COLLECTION).doc('jMfMnZfxiG1O70RGSqW2').get();
  //   gcourse=Course.fromMap(coref.data()!);

  // final leref = await db
  //     .collection(DataBase.LEARNER_COLLECTION)
  //     .doc('3ls1508zatxqMzCx0VIY')
  //     .get();
  // glearner = Learner.fromMap(leref.data()!);

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
  //    glearner=Learner.fromMap(leref.data()!);

// final servref=await FirebaseFirestore.instance.collection(DataBase.SERVICE_COLLECTION).
// doc('ShkFj4H1djYVJkiznHJH').get();
//  gservice=Service.fromMap(servref.data()!);
//  final ins= await service!.getInstructor();
//  print(ins.toMap());

// final vehref=await FirebaseFirestore.instance.collection(DataBase.VEHICLE_COLLECTION).
// doc('52kIF9TLyv4L7CXPgRAh').get();
// gvehicle=Vehicle.fromMap(vehref.data()!);

// await FirebaseFirestore.instance.collection(DataBase.COURSE_ATTENDANCE_COLLECTION).
// doc('fq7OTP7HZK7KLQNe7viQ').set(Examples.COURSEATTENDANCE.toMap());

// final appref=await FirebaseFirestore.instance.collection(DataBase.APPLICATION_COLLECTION).
// doc('cDVtUq0FZzu21LogGivo').get();
// gapplication=Application.fromMap(appref.data()!);

  //User.getDS().getAllLearnerIds().then((value) => print(value));
  // Application.createCourse(gcourse!, glearner!,'XiTB0DaQwd1Lqnz9MpNa');

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasData) {
            return AllOverView(drivingSchool: CustomUser.User.getDS());
          }
          return AuthScreen();
        },
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.hasData) {
              return AllOverView(drivingSchool: CustomUser.User.getDS());
            }
            return AuthScreen();
          },
        ));
  }
}


