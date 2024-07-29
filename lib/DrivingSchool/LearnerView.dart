

import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/CourseAttendance.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/User.dart';

class LearnerView extends StatefulWidget {
  Learner learner;
  LearnerView({super.key,required this.learner});

  @override
  State<LearnerView> createState() => _LearnerViewState();
}

class _LearnerViewState extends State<LearnerView> {
bool gotData=false;
String courseNames='';
String courseIds='';
Future<void> initialize()async
{
   final courses= await widget.learner.getCoursesRegisteredInSchool(User.getDS());
   courses.forEach((element) { 
    courseNames+=element.name+', ';
    courseIds+=element.courseId+' ,';

   });

   setState(() {
     gotData=true;
   });
}


@override
void initState()
{
  initialize();
  super.initState();

}


@override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return Scaffold(body: Container(
      decoration: PageConstants.PAGEBACKGROUND,
      child:Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 20,),
        CSearchBar(),
        SizedBox(height: 20,),
       !gotData?SizedBox(): Container(width: sw*0.95,padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
        child: 
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Align(alignment: Alignment.topCenter,  
          child: Icon(Icons.person,color: PageConstants.LIGHTGREEN,size: 100,)),
          Text('Name: ${widget.learner.name}'),
          Text('Course Name: $courseNames'),
          Text('Course Id: $courseIds'),
          Text('Age: ${widget.learner.age}'),
          Text('Gender: ${widget.learner.gender}'),
          Text('Email id: ${widget.learner.email}'),
          Text('Mobile Number: ${widget.learner.mobileNumber}'),
          Text('Date of Birth: ${formatDateTime(widget.learner.dob)}'),
          SizedBox(height: 20,),
         

        ],),)
      ],) ,
    ),);
  }
}

