import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/DrivingSchool/AllForms.dart';
import 'package:fp3/DrivingSchool/AllOverView.dart';
import 'package:fp3/DrivingSchool/CreateCourse.dart';
import 'package:fp3/DrivingSchool/CreateInstructor.dart';
import 'package:fp3/DrivingSchool/CreateService.dart';
import 'package:fp3/DrivingSchool/CreateVehicle.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Enquiry.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/Models/Service.dart';
import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/User.dart';
import 'package:fp3/firebase_options.dart';

DrivingSchool gds=DrivingSchool();
Enquiry genuiry=Enquiry();
Learner glearner=Learner();
 Course gcourse=Course();
 Service gservice=Service();
 Instructor ginstructor=Instructor();
 Vehicle gvehicle=Vehicle();
 List<String> gcourseIds=[];
 List<String> gserviceIds=[];
 List<String> ginstructorIds=[];
 List<String> gvehicleIds=[];
 Application gapplication=Application();
void main() async{

    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 FirebaseFirestore db=FirebaseFirestore.instance;
 await User.initialize('w42tQh0oLjlD0LsEGxPs');



// await Application.createCourse(course: gcourse,learner: glearner);



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
       // body:CourseAttendanceView(courseAttendance: Examples.COURSEATTENDANCE,editable: false,),
       // body: AllFormsView(drivingSchool: User.getDS()),
       //body: ApplicationView(application: gapplication!,),
      //  body: AllOverView(drivingSchool: User.getDS()!),
       // body: MessageView(messages: Examples.ENQUIRY.messages),
    // body: CreateService(),
       body: AllOverView(drivingSchool: User.getDS()),
      ),
    );
  }
}


