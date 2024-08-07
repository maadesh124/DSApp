import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/DrivingSchool/AllOverView.dart';
import 'package:fp4/DrivingSchool/CreateCourse.dart';
import 'package:fp4/DrivingSchool/CreateService.dart';
import 'package:fp4/DrivingSchool/CreateVehicle.dart';
import 'package:fp4/DrivingSchool/test.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Examples.dart';
import 'package:fp4/Models/Reviews.dart';
import 'package:fp4/Models/Vehicle.dart';
import 'package:fp4/Others/ImageCarousel.dart';
import 'package:fp4/Others/MyFiles.dart';
import 'package:fp4/Others/PdfViewer.dart';
import 'package:fp4/User.dart';
import 'package:fp4/firebase_options.dart';

Course gcourse=Course();
Vehicle gvehicle=Vehicle();
void main()async
 {
    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

await User.initializeDS('3Kch3uLFYkWUDYRPaVvo');


gcourse.setDocId('CN8LAw33FbFvxrAmB4Cd');
await gcourse.getFromDB();

gvehicle.setDocId('7NG8K7ISpY2eqESt7WAa');
await gvehicle.getFromDB();



   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PageConstants.LIGHTGREEN),
        useMaterial3: true,
      ),
      home:Scaffold(
        body:ImageCarousel(model: gvehicle,size: 400,))
        
        )
    ;
  }
}


