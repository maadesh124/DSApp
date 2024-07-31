import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/DrivingSchool/AllOverView.dart';
import 'package:fp3/DrivingSchool/CreateCourse.dart';
import 'package:fp3/DrivingSchool/CreateInstructor.dart';
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

DrivingSchool? gds;
Enquiry? genquiry;
Learner? glearner;
 Course? gcourse;
 Service? gservice;
 Instructor? ginstructor;
 Vehicle? gvehicle;
 List<String> gcourseIds=['3T7477jI3CepWry9vlAo','MTP1d152cEJAbafZjxF6','jMfMnZfxiG1O70RGSqW2'];
 List<String> gserviceIds=['ShkFj4H1djYVJkiznHJH'];
 List<String> ginstructorIds=['rI2UWWwSz85LBnmbz1Ig'];
 List<String> gvehicleIds=['52kIF9TLyv4L7CXPgRAh','rI2UWWwSz85LBnmbz1Ig'];
 Application? gapplication;
void main() async{

    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 FirebaseFirestore db=FirebaseFirestore.instance;
 await User.initialize('w42tQh0oLjlD0LsEGxPs');

List<String> ids=['A1HlVLFhilcSwMn28LKT','o1e8L1s2VouUqLcsken2','qrZThCy7S8Duf7VSjcoR'];
List<Application> list=List.filled(ids.length, Application());
await Model.getAllModels(ids,list);
print(list.last.toMap());
// Application application=Application();
// application.learnerName='check Name';
// application.setToDB();
// print(application.toMap());

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
    // body: EnquiryView(temp: genquiry!),
    body: CreateInstructor(),
      ),
    );
  }
}


