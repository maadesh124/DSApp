import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Enquiry.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Service.dart';
import 'package:fp3/Models/Vehicle.dart';


class CourseOverview extends StatelessWidget {
  

  Course course;
  Instructor instructor;
  Vehicle vehicle;
  
  CourseOverview({super.key,required this.course}): 
  instructor = course.getInstructor1(),
  vehicle = course.getVehicle1();

  
  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(10)),
      width: screenWidth*0.95,
      height: 130,
     // padding: EdgeInsets.all(5),
      child: Stack(children: [
        Positioned(left: 5,top: 0,bottom: 0,child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(course.name),
          Text(instructor.name),
          Text(instructor.insId),
          Text('${course.startTime.hour}.${course.startTime.minute}-${course.endTime.hour}.${course.endTime.minute}'),
          Text(vehicle.vehicleNumber),
          Text('${course.availableSeats}/${course.totalSeats} seats available')

        ],),),
        Positioned(top: 0,bottom: 0,right: 0.45*screenWidth, child: 
        Center(child: Container(width: 1,height: 100,color: Colors.black,),)),
        Positioned(right: 5,top: 0,bottom: 0, child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Container( width: 0.4*screenWidth,height: 100,//color: Colors.blue, 
        child:Text(course.courseDescription)),
          RatingWidget(rating: course.currentRating, size: 16)
        ],),)
      ]),

    );
  }
}


class ServiceOverview extends StatelessWidget {

  Service service;
  ServiceOverview({super.key,required this.service});

  @override
  Widget build(BuildContext context) {
   final double screenWidth=MediaQuery.of(context).size.width;
    return Container(width: 0.95*screenWidth,
    height: 45,
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child:Center(child: Text('Service Name:${service.name} | Instructor Name :${service.instructorName}',
    style: TextStyle(fontSize: 18),),
    ));
  }
}

class InstructorOverview extends StatelessWidget {
  Instructor instructor;
  InstructorOverview({super.key,required this.instructor});

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
      width: 0.95*screenWidth,
      height: 130,
      //padding: EdgeInsets.all(0),
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
    );
  }
}

class VehicleOverview extends StatelessWidget {
  Vehicle vehicle;
  VehicleOverview({super.key,required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(width: 0.95*screenWidth,
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
    );
  }
}

class ApplicationOverview extends StatelessWidget {

  Application application;
  ApplicationOverview({super.key,required this.application});

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(
      width:0.95*screenWidth ,
      height: 120,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Course Name: ${application.courseName}'),
        Text('Course Id: ${application.courseId}'),
        Text('Student Name: ${application.learnerName}'),
        Text('Application No.: ${application.applicationNumber}'),
        Text('Applied date: ${application.dateApplied!.day}-${application.dateApplied!.month}-${
          application.dateApplied!.year}')
        
      ],),
    );
  }
  
}

class EnquiryOverview extends StatelessWidget {
  Enquiry enquiry;
  EnquiryOverview({super.key,required this.enquiry});

  @override
  Widget build(BuildContext context) {
    Learner learner=enquiry.getLearner();
     final double screenWidth=MediaQuery.of(context).size.width;
   return Container(
      width:0.95*screenWidth ,
      height: 120,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name: ${learner.name}'),
        Text('Address: ${learner.address}'),
        Text('Mobile No.: ${learner.mobileNumber}'),
        Text('Enquiry No.: ${enquiry.enquiryNo}'),
        Text('Replied: ${enquiry.getStatus()}')
        
      ],),
    );
  }
}

class LearnerOverview extends StatelessWidget {


  Learner learner;
 // Course course;
  LearnerOverview({super.key,required this.learner});

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(
      width:0.95*screenWidth ,
      height: 100,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Student Name: ${learner.name}'),
        Text('Age: ${learner.age}'),
        // Text('Student Name: ${le}'),
        Text('Gender: ${learner.gender}'),
        Text('Address: ${learner.address}')
        
      ],),
    );
  }
}