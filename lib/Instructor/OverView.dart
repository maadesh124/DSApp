import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Instructor/CourseAttendanceInsView.dart';
import 'package:fp3/Instructor/CourseMessage.dart';
import 'package:fp3/Instructor/CourseViewIns.dart';
import 'package:fp3/Instructor/ServiceView.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Service.dart';

class CourseOverview extends StatelessWidget {

  Course course=Course();
  CourseOverview({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return InkWell(onTap: () {
      Navigator.push(context,
MaterialPageRoute(builder: (context) =>CourseViewIns(course: course,)),);
    },
      child: Container(width: sw*0.95,height: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start,   children: [
          Text(course.name),
          Text(course.courseId),
          Text('${formatTimeOfDay(course.startTime)}-${formatTimeOfDay(course.endTime)}'),
          InkWell(onTap: () {
            Navigator.push(context,
MaterialPageRoute(builder: (context) =>CourseMessageView(course: course,)),);
          },
            child: Container(width: 120,height: 30, padding: EdgeInsets.fromLTRB(7,3,7,3), decoration: BoxDecoration(
              color: PageConstants.INS_DARK,borderRadius: BorderRadius.circular(7)
            ),child: Row(children: [Text('Messages'),Spacer(flex: 1,),Icon(Icons.message_rounded)],),),
          )
          
        ],),
        Spacer(flex: 1,),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${course.endDate}'),
          Text('${course.vehicleNumber}'),
          Text(''),
          InkWell(onTap: () {
        Navigator.push(context,
MaterialPageRoute(builder: (context) =>CourseAttendanceView(course: course,editable: true,)),);
          },
            child: Container(width: 120,height: 30, padding: EdgeInsets.fromLTRB(7,3,7,3), decoration: BoxDecoration(
              color: PageConstants.INS_DARK,borderRadius: BorderRadius.circular(7)
            ),child: Row(children: [Text('Attendance'),Spacer(flex: 1,),Icon(Icons.calendar_month_rounded)],),),
          )
          
      
        ],)
      ],),
      ),
    );
  }
}


class ServiceOverview extends StatelessWidget {
  Service service;
  ServiceOverview({super.key,required this.service});

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return InkWell(onTap:()
    {
       Navigator.push(context,
MaterialPageRoute(builder: (context) =>ServiceView(service: service)),);
    } ,
      child: Container(width: sw*0.95,height: 40,padding: EdgeInsets.fromLTRB(10,3, 10,3),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Center(child: Text('${service.name}')),
          Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios_rounded),)
        ],
      ),),
    );
  }
}




