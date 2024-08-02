import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/AllForms.dart';
import 'package:fp3/DrivingSchool/AllOverView.dart';
import 'package:fp3/DrivingSchool/CreateCourse.dart';
import 'package:fp3/DrivingSchool/CreateInstructor.dart';
import 'package:fp3/DrivingSchool/CreateService.dart';
import 'package:fp3/DrivingSchool/CreateVehicle.dart';
import 'package:fp3/Instructor/CourseAttendanceInsView.dart';
import 'package:fp3/Instructor/CourseMessage.dart';
import 'package:fp3/Instructor/Home.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/CourseAttendance.dart';
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
 CourseAttendance gCourseAttenance=CourseAttendance();
void main() async{

    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 FirebaseFirestore db=FirebaseFirestore.instance;
 await User.initializeIns('rdd5DRrEQNawdDpyjaZK');

gcourse.setDocId('lO1qsZCxc4yz6RDghR9n');
await gcourse.getFromDB();


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
       body: CourseAttendanceView(course: gcourse, editable: true),
       //body: AllOverView(drivingSchool: User.getDS()),
      ),
    );
  }
}


