

import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/CourseAttendance.dart';
import 'package:fp3/Learner/CourseMessageL.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RegisteredCourse extends StatefulWidget {

  Course course;
  RegisteredCourse({super.key,required this.course});

  @override
  State<RegisteredCourse> createState() => _RegisteredCourseState();
}

class _RegisteredCourseState extends State<RegisteredCourse> {
bool gotData=false;
  Instructor instructor=Instructor();
Future<void> initialize()async
{
instructor=  await widget.course.getInstructor();

  setState(() {
    gotData=true;
  });
}

@override
void initState()
{
  gotData=false;
  initialize();
  super.initState();

}

void goToCourseMessage()
{
Navigator.push(context,
MaterialPageRoute(builder: (context) =>CourseMessageViewL(course: widget.course),));
}



  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return Scaffold(body: 
    Container(decoration:PageConstants.LEARNER_BG,child:Column(children: [
      SizedBox(height: 40,),
      CSearchBar(),
      SizedBox(height: 20,),
      Container(width: sw*0.95,
        child: Row(children: [Text(widget.course.name),Spacer(flex: 1,),
        RatingWidget(rating: widget.course.currentRating, size: 22)],) ),
        Container(width: sw*0.95,padding: EdgeInsets.fromLTRB(10,10,10,20),  decoration:
         BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),child: 
         
          Row(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             !gotData?Center(child: CircularProgressIndicator(),):
               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.course.instructorName),
                  Text(widget.course.dsName),
                  Text(instructor.mobileNumber),
                  Text(instructor.email),
                  Text('${formatTimeOfDay(widget.course.startTime)}-${formatTimeOfDay(widget.course.endTime)}'),
                  Text('${formatDateTime(widget.course.endDate)}'),
                  Text('${widget.course.noOfLessonsCompleted()}/${widget.course.progress.length} completed')
               ],),
               Spacer(flex: 1,),
               Column(
                 children: [
                   Align(alignment: Alignment.centerRight,
                    child: CircularPercentIndicator(radius: 50,percent: 0.9,
                    progressColor: PageConstants.LEARNER_DARK,lineWidth: 7.5,
                    center: Text('90%',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),)),
                    Text('Attendance'),
                    SizedBox(height: 25),
                   InkWell(onTap: goToCourseMessage,
                     child: Container(width: 120,height: 30, padding: EdgeInsets.fromLTRB(7,3,7,3), decoration: BoxDecoration(
                                   color: PageConstants.LEARNER_DARK,borderRadius: BorderRadius.circular(7)
                                 ),child: Row(children: [Text('Messages',style: TextStyle(color: Colors.white),),
                                 Spacer(flex: 1,),Icon(Icons.message_rounded,color: Colors.white,)],),),
                   ),
                 ],
               )
             ],
         ),),
         SizedBox(height: 20,),
          ProgressView(list: widget.course.progress, editable:false, height:200)
    ],) ,),);
  }
}