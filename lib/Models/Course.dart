import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/CourseAttendance.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Reviews.dart';

import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/User.dart';


class Course {
  String dsObjectId;
  String dsName;
  String name;
  String courseId;
  DateTime startDate;
  DateTime endDate;
  String courseDuration;
  double courseFee;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String attendanceObjectId;
  int totalSeats;
  int availableSeats;
  String courseDescription;
  String instructorObjectId;
  String instructorId;
  String instructorName;
  String vehicleObjectId;
  String vehicleNumber;
  List<Progress> progress;
  List<String> learnerObjectIds;
  List<String> applicationObjectIds;
  List<String> enquiryObjectIds;
  String reviewsObjectId;
  int numberOfRatings;
  double currentRating;

  Course({
    this.dsObjectId = '',
    this.dsName = '',
    this.name = '',
    this.courseId = '',
    DateTime? startDate,
    DateTime? endDate,
    String? courseDuration,
    this.courseFee = 0.0,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    this.attendanceObjectId = '',
    this.totalSeats = 0,
    this.availableSeats = 0,
    this.courseDescription = '',
    this.instructorObjectId = '',
    this.instructorId = '',
    this.instructorName = '',
    this.vehicleObjectId = '',
    this.vehicleNumber = '',
    List<Progress>? progress,
    List<String>? learnerObjectIds,
    List<String>? applicationObjectIds,
    List<String>? enquiryObjectIds,
    this.reviewsObjectId = '',
    this.currentRating = 0.0,
    this.numberOfRatings = 0,
  })  : startDate = startDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now(),
        courseDuration = courseDuration ??'not mentioned',
        startTime = startTime ?? TimeOfDay(hour: 0, minute: 0),
        endTime = endTime ?? TimeOfDay(hour: 0, minute: 0),
        progress = progress ?? [],
        learnerObjectIds = learnerObjectIds ?? [],
        applicationObjectIds = applicationObjectIds ?? [],
        enquiryObjectIds = enquiryObjectIds ?? [];


  Instructor getInstructor1()=>Examples.INSTRUCTOR;
  Vehicle getVehicle1()=>Examples.VEHICLE;


  static Future<Course> create(Course course)async
  {

   final revref= await FirebaseFirestore.instance.collection(DataBase.REVIEWS_COLLECTION).add({});
   final attref=await FirebaseFirestore.instance.collection(DataBase.COURSE_ATTENDANCE_COLLECTION).add({});
   final insrefs=await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
where('insId',isEqualTo: course.instructorId).where('schoolId',isEqualTo: User.docId).get();
   final vehrefs=await FirebaseFirestore.instance.collection(DataBase.VEHICLE_COLLECTION).
where('vehicleNumber',isEqualTo: course.vehicleNumber).where('schoolId',isEqualTo: User.docId).get();


Instructor instructor=Instructor.fromMap(insrefs.docs.first.data());
Vehicle vehicle=Vehicle.fromMap(vehrefs.docs.first.data());

course.attendanceObjectId=attref.id;
course.instructorObjectId=insrefs.docs.first.id;
course.instructorName=instructor.name;
course.vehicleObjectId=vehrefs.docs.first.id;
course.reviewsObjectId=revref.id;

final coref=  await FirebaseFirestore.instance.collection(DataBase.COURSE_COLLECTION).add(course.toMap());
 CourseAttendance courseAttendance=CourseAttendance(courseId: coref.id, courseName: course.name);
 Review review=Review(receiver: 'Course',receiverId: coref.id);

 await revref.set(review.toMap());
 await attref.set(courseAttendance.toMap());


//add to timetable and courseids list
instructor.courseIds.add(coref.id);
Map<String,Map<String,String>> map=instructor.timeTable;
map.forEach((key, value) {
  Map<String,String> dayTimeTable=map[key]!;
  dayTimeTable['${formatTimeOfDay(course.startTime)}-${formatTimeOfDay(course.endTime)}']='${course.name}|${coref.id}';
});

//add to timetable and couse list 
vehicle.courseObjectIds.add(coref.id);
map=vehicle.timeTable;
map.forEach((key, value) {
  Map<String,String> dayTimeTable=map[key]!;
  dayTimeTable['${formatTimeOfDay(course.startTime)}-${formatTimeOfDay(course.endTime)}']='${course.name}|${coref.id}';
});

await   FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
doc(course.instructorObjectId).set(instructor.toMap());
await   FirebaseFirestore.instance.collection(DataBase.VEHICLE_COLLECTION).
doc(course.instructorObjectId).set(vehicle.toMap());


//add to course list in ds
final ds=User.getDS();
ds.courseIds.add(coref.id);
User.setDS(ds);
  return course;
  }


  Future<Instructor> getInstructor() async
  {
    print('in get ins');
    print(instructorObjectId);
   final insref= await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
   get();
   print('co');
   return Instructor.fromMap(insref.docs.first.data()!);
  }


  Future<Vehicle> getVehicle()async
  {
    final vehref=await FirebaseFirestore.instance.collection(DataBase.VEHICLE_COLLECTION).
    doc(vehicleObjectId).get();

    return Vehicle.fromMap(vehref.data()!);
  }




  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      dsObjectId: map['dsObjectId'] ?? '',
      dsName: map['dsName'] ?? '',
      name: map['name'] ?? '',
      courseId: map['courseId'] ?? '',
      startDate: DateTime.fromMillisecondsSinceEpoch((map['startDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      endDate: DateTime.fromMillisecondsSinceEpoch((map['endDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      courseDuration: map['courseDuration'] ?? '',
      courseFee: map['courseFee'] ?? 0.0,
      startTime: map['startTime'] != null ? TimeOfDay(hour: int.parse(map['startTime'].split(':')[0]), minute: int.parse(map['startTime'].split(':')[1])) : TimeOfDay(hour: 0, minute: 0),
      endTime: map['endTime'] != null ? TimeOfDay(hour: int.parse(map['endTime'].split(':')[0]), minute: int.parse(map['endTime'].split(':')[1])) : TimeOfDay(hour: 0, minute: 0),
      attendanceObjectId: map['attendanceObjectId'] ?? '',
      totalSeats: map['totalSeats'] ?? 0,
      availableSeats: map['availableSeats'] ?? 0,
      courseDescription: map['courseDescription'] ?? '',
      instructorObjectId: map['instructorObjectId'] ?? '',
      instructorId: map['instructorId'] ?? '',
      instructorName: map['instructorName'] ?? '',
      vehicleObjectId: map['vehicleObjectId'] ?? '',
      vehicleNumber: map['vehicleNumber'] ?? '',
      progress: (map['progress'] as List?)?.map((progressMap) => Progress.fromMap(progressMap)).toList() ?? [],
      learnerObjectIds: List<String>.from(map['learnerObjectIds'] ?? []),
      applicationObjectIds: List<String>.from(map['applicationObjectIds'] ?? []),
      enquiryObjectIds: List<String>.from(map['enquiryObjectIds'] ?? []),
      reviewsObjectId: map['reviewsObjectId'] ?? '',
      numberOfRatings: map['numberOfRatings'] ?? 0,
      currentRating: map['currentRating'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dsObjectId': dsObjectId,
      'dsName': dsName,
      'name': name,
      'courseId': courseId,
      'startDate': startDate,
      'endDate': endDate,
      'courseDuration': courseDuration,
      'courseFee': courseFee,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'attendanceObjectId': attendanceObjectId,
      'totalSeats': totalSeats,
      'availableSeats': availableSeats,
      'courseDescription': courseDescription,
      'instructorObjectId': instructorObjectId,
      'instructorId': instructorId,
      'instructorName': instructorName,
      'vehicleObjectId': vehicleObjectId,
      'vehicleNumber': vehicleNumber,
      'progress': progress.map((progressItem) => progressItem.toMap()).toList(),
      'learnerObjectIds': learnerObjectIds,
      'applicationObjectIds': applicationObjectIds,
      'enquiryObjectIds': enquiryObjectIds,
      'reviewsObjectId': reviewsObjectId,
      'numberOfRatings': numberOfRatings,
      'currentRating': currentRating,
    };
  }

  List<Application> getApplications()
  {
    
    return [];
  }



}

class Progress {
  String lessonName;
  String lessonDescription;
  bool isCompleted;

  Progress({
    required this.lessonName,
    required this.lessonDescription,
    required this.isCompleted,
  });

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      lessonName: map['lessonName']??' ',
      lessonDescription: map['lessonDescription']??' ',
      isCompleted: map['isCompleted']??false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lessonName': lessonName,
      'lessonDescription': lessonDescription,
      'isCompleted': isCompleted,
    };
  }
}

String formatTimeOfDay(TimeOfDay time) {
  final int hour = time.hour;
  final int minute = time.minute;

  // Format the hour and minute to ensure two digits
  final String formattedHour = hour.toString().padLeft(2, '0');
  final String formattedMinute = minute.toString().padLeft(2, '0');

  // Combine hour and minute with a colon
  return '$formattedHour:$formattedMinute';
}