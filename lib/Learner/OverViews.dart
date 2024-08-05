
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/DrivingSchool/CourseAttendance.dart';
import 'package:fp4/DrivingSchool/VehicleView.dart';
import 'package:fp4/Learner/CourseViewL.dart';
import 'package:fp4/Learner/SchoolViewL.dart';
import 'package:fp4/Learner/ServiceViewL.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Instructor.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/Models/Service.dart';
import 'package:fp4/Models/Vehicle.dart';

class DrivingSchoolOverView extends StatelessWidget {

  DrivingSchool drivingSchool;
 DrivingSchoolOverView({super.key,required this.drivingSchool});

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return InkWell(onTap: () => {
                  Navigator.push(context,
MaterialPageRoute(builder: (context) =>SchoolViewL(drivingSchool: drivingSchool)),)
    },
      child: Container(width: sw*0.95,height: 350,decoration: 
      BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),child: 
      Column(children: [
        Align(alignment: Alignment.topCenter, child:Image.asset('assets/images/img.png')),
        Container(padding: EdgeInsets.all(10),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Text('x km away'),
          Row(children: [Text(drivingSchool.schoolName),Spacer(flex: 1,),RatingWidget(rating: 4, size: 20) ],),
          Text(drivingSchool.description),
        ],),)
      ],),),
    );
  }
}


class CourseOverView extends StatelessWidget {
  Course course;
 CourseOverView({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width*0.95;
    return InkWell(onTap: ()
    {
    Navigator.push(context,
MaterialPageRoute(builder: (context) =>CourseViewLearner(course: course,)),);
    },
      child: Container(width: sw,height: 150,padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),child: 
      Stack(children: [Align(alignment: Alignment.centerLeft,child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        Text(course.name),
        Text(course.dsName),
        Text(course.instructorName),
        Text('${formatTimeOfDay(course.startTime)}-${formatTimeOfDay(course.endTime)}'),
        Text('${formatDateTime(course.startDate)}-${formatDateTime(course.endDate)}'),
        Text('${course.learnerObjectIds.length}/${course.totalSeats} seats available')
      ],),),
      
      Align(alignment: Alignment.centerRight,
        child: Container(width: 0.35*sw,height: 150,child: Row(children: [
          Container(width: 1,height: 120,color: Colors.black,),
          SizedBox(width: 10,),
          Container(width: 0.35*sw-11,padding: EdgeInsets.fromLTRB(0,0,0,10),
            child: Stack(children: [    
            Align(alignment:Alignment.topCenter, child: Text('${course.courseDescription}')),
            Align(alignment: Alignment.bottomCenter, child: RatingWidget(rating: course.currentRating, size:15))],),
          )
        ],),),
      )
      
      ]),),
    );
  }
}



class InstructorOverView extends StatelessWidget {
  Instructor instructor;
  InstructorOverView({super.key,required this.instructor});

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return InkWell(onTap: () {
//             Navigator.push(context,
// MaterialPageRoute(builder: (context) =>InstructorView(instructor: instructor)),);
    },
      child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
        width: 0.95*screenWidth,
        height: 130,
       // padding: EdgeInsets.fromLTRB(0,10, 0, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(alignment: Alignment.center, child:Icon(Icons.account_box,size: 130,color: PageConstants.LIGHTGREEN,)),
          Column(crossAxisAlignment: CrossAxisAlignment.start, 
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(instructor.name),
            Text(instructor.insId),
            Text(instructor.mobileNumber),
            Text(instructor.email),
            Text(instructor.specialization),
            Text(instructor.courseIds!.length.toString()+' courses handling')
          ],)
        ],),
      ),
    );
  }
}



class VehicleOverview extends StatelessWidget {
  Vehicle vehicle;
  String type;
  VehicleOverview({super.key,required this.vehicle,this.type=Model.DRIVINGSCHOOL});

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return InkWell(onTap:null,
      child: Container(width: 0.95*screenWidth,
      height: 331,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Align(alignment: Alignment.topCenter, child:Image.asset('assets/images/img.png')),
          Text("Vehicle Number: "+vehicle.vehicleNumber),
          Text("Vehicle name: "+vehicle.vehicleNumber),
          Text("Vehicle description: "+vehicle.description),
            Text('Used in ${vehicle.courseObjectIds.length}')
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
   final double screenWidth=MediaQuery.of(context).size.width;
    return InkWell(onTap: () {
      Navigator.push(context,
MaterialPageRoute(builder: (context) =>ServiceViewL(service: service, )),);

    },
      child: Container(width: 0.95*screenWidth,
      height: 45,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child:Center(child: Text('Service Name:${service.name} | Instructor Name :${service.instructorName}',
      style: TextStyle(fontSize: 18),),
      )),
    );
  }
}