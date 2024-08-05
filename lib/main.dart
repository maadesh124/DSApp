import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/DrivingSchool/AllOverView.dart';
import 'package:fp4/DrivingSchool/CreateCourse.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Examples.dart';
import 'package:fp4/Models/Reviews.dart';
import 'package:fp4/Others/MyFiles.dart';
import 'package:fp4/User.dart';
import 'package:fp4/firebase_options.dart';

void main()async
 {
    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

await User.initializeDS('3Kch3uLFYkWUDYRPaVvo');

// Examples.REVIEW.setToDB();



   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DaysOfWeekCheckboxes v=DaysOfWeekCheckboxes();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PageConstants.LIGHTGREEN),
        useMaterial3: true,
      ),
      home:Scaffold(body:  Column(
        children: [
          ElevatedButton(onPressed: ()=>print(v.getController()), child:Text('data')),
          DaysOfWeekCheckboxes(),
        ],
      ),),)
    ;
  }
}


