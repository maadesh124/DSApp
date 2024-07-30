import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/AllForms.dart';
import 'package:fp3/DrivingSchool/AllOverView.dart';
import 'package:fp3/DrivingSchool/ApplicationView.dart';
import 'package:fp3/DrivingSchool/CourseAttendance.dart';
import 'package:fp3/DrivingSchool/CourseView.dart';
import 'package:fp3/DrivingSchool/CreateCourse.dart';
import 'package:fp3/DrivingSchool/CreateInstructor.dart';
import 'package:fp3/DrivingSchool/CreateService.dart';
import 'package:fp3/DrivingSchool/CreateVehicle.dart';
import 'package:fp3/DrivingSchool/EnquiryView.dart';
import 'package:fp3/DrivingSchool/InstructorView.dart';
import 'package:fp3/DrivingSchool/LearnerView.dart';
import 'package:fp3/DrivingSchool/ServiceView.dart';
import 'package:fp3/DrivingSchool/VehicleView.dart';
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



 final enqref=   await FirebaseFirestore.instance.collection(DataBase.ENQUIRY_COLLECTION).
doc('MZtY3CiBVUDGfiTb67Mh').get();
genquiry=Enquiry.fromMap(enqref.data()!);

  //  final coref= await db.collection(DataBase.COURSE_COLLECTION).doc('jMfMnZfxiG1O70RGSqW2').get();
  //   gcourse=Course.fromMap(coref.data()!);

    //   final leref= await db.collection(DataBase.LEARNER_COLLECTION).doc('3ls1508zatxqMzCx0VIY').get();
    // glearner=Learner.fromMap(leref.data()!);


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
       //body: AllOverView(drivingSchool: User.getDS()),
       // body: MessageView(messages: Examples.ENQUIRY.messages),
     body: EnquiryView(temp: genquiry!),
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