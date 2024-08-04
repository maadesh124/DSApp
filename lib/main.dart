import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Instructor/Home.dart';
import 'package:fp3/Learner/ApplicationView.dart';
import 'package:fp3/Learner/CourseViewL.dart';
import 'package:fp3/Learner/RegisteredCourse.dart';
import 'package:fp3/Learner/SearchResults.dart';
import 'package:fp3/Learner/ServiceViewL.dart';



import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/CourseAttendance.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Enquiry.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
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
 List<String> gcourseIds=['lO1qsZCxc4yz6RDghR9n','wq0bvtGWAhtOtmb4Lco0',];
 List<String> gserviceIds=['vPx845ZZKuISAyLJFd2I'];
 List<String> ginstructorIds=['rdd5DRrEQNawdDpyjaZK','U19ptDvWhqnOysfzL2gu'];
 List<String> gvehicleIds=['LkQH1hGDc5IjPGYUfoEY','s5gwOGY5ZwFNnLaXpcQe'];
 List<String> gdsIds=['w42tQh0oLjlD0LsEGxPs'];
 Application gapplication=Application();
 CourseAttendance gCourseAttenance=CourseAttendance();
void main() async{

    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 FirebaseFirestore db=FirebaseFirestore.instance;
 await User.initializeLearner('LRMpU3c6QdOOAkONHcdC');

gservice.setDocId('vPx845ZZKuISAyLJFd2I');
await gservice.getFromDB();

gcourse.setDocId('wq0bvtGWAhtOtmb4Lco0');
await gcourse.getFromDB();

// await Application.createCourse(course: gcourse,learner: glearner);



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   final double sh=MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
            home: Scaffold(
       body:SearchResultsView(instructorIds: ginstructorIds, schoolIds:gdsIds, 
       courseIds: gcourseIds, serviceIds: gserviceIds)
      //body: AllOverView(drivingSchool: User.getDS()),
      ),
    );
  }
}


