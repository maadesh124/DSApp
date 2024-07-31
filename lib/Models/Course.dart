import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fp3/Models/CourseAttendance.dart';
import 'package:fp3/Models/CourseMessage.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/Models/Reviews.dart';
import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/User.dart';

class Course extends Model {
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
  int totalSeats;
  int availableSeats;
  String courseDescription;
  String instructorObjectId;
  String instructorId;
  String instructorName;
  String vehicleObjectId;
  String vehicleNumber;
  String reviewObjectId;
  List<Progress> progress;
  List<String> learnerObjectIds;
  List<String> applicationObjectIds;
  //Attendance,Message have same document id as course




  Course({super.collectionType=Model.COURSE,
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
    this.totalSeats = 0,
    this.availableSeats = 0,
    this.courseDescription = '',
    this.instructorObjectId = '',
    this.instructorId = '',
    this.instructorName = '',
    this.vehicleObjectId = '',
    this.vehicleNumber = '',
    this.reviewObjectId='',
    List<Progress>? progress,
    List<String>? learnerObjectIds,
    List<String>? applicationObjectIds,
    List<String>? enquiryObjectIds,
  })  : startDate = startDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now(),
        courseDuration = courseDuration ??'not mentioned',
        startTime = startTime ?? TimeOfDay(hour: 0, minute: 0),
        endTime = endTime ?? TimeOfDay(hour: 0, minute: 0),
        progress = progress ?? [],
        learnerObjectIds = learnerObjectIds ?? [],
        applicationObjectIds = applicationObjectIds ?? [];






  static Future<Course> create(Course course)async
  {

//    final revref= await FirebaseFirestore.instance.collection(DataBase.REVIEWS_COLLECTION).add({});
//    final attref=await FirebaseFirestore.instance.collection(DataBase.COURSE_ATTENDANCE_COLLECTION).add({});
Review review=Review();
await review.autoDocId();
   final insrefs=await FirebaseFirestore.instance.collection(Model.INSTRUCTOR).
where('insId',isEqualTo: course.instructorId).where('schoolId',isEqualTo: User.getDS().getDocId()).get();
   final vehrefs=await FirebaseFirestore.instance.collection(Model.VEHICLE).
where('vehicleNumber',isEqualTo: course.vehicleNumber).
where('schoolId',isEqualTo: User.getDS().getDocId()).get();

Instructor instructor=Instructor();
instructor.fromSnapShot(insrefs.docs.first);
Vehicle vehicle=Vehicle();
vehicle.fromSnapShot(vehrefs.docs.first);



course.instructorObjectId=instructor.getDocId();
course.instructorName=instructor.name;
course.vehicleObjectId=vehicle.getDocId();
course.reviewObjectId=review.getDocId();
await course.setToDB();

review.receiver=Model.COURSE;
review.receiverId=course.getDocId();
await review.setToDB();

CourseAttendance courseAttendance=CourseAttendance( courseName: course.name);
courseAttendance.setDocId(course.getDocId());
await courseAttendance.setToDB();

CourseMessage courseMessage=CourseMessage();
courseMessage.setDocId(course.getDocId());
courseMessage.setToDB();



//add to timetable and courseids list
instructor.courseIds.add(course.getDocId());
Map<String,Map<String,String>> map=instructor.timeTable;
map.forEach((key, value) {
  Map<String,String> dayTimeTable=map[key]!;
  dayTimeTable['${formatTimeOfDay(course.startTime)}-${formatTimeOfDay(course.endTime)}']='${course.name}|${course.getDocId()}';
});

//add to timetable and couse list 
vehicle.courseObjectIds.add(course.getDocId());
map=vehicle.timeTable;
map.forEach((key, value) {
  Map<String,String> dayTimeTable=map[key]!;
  dayTimeTable['${formatTimeOfDay(course.startTime)}-${formatTimeOfDay(course.endTime)}']='${course.name}|${course.getDocId()}';
});

// await   FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
// doc(course.instructorObjectId).set(instructor.toMap());
// await   FirebaseFirestore.instance.collection(DataBase.VEHICLE_COLLECTION).
// doc(course.vehicleObjectId).set(vehicle.toMap());
instructor.setToDB();
vehicle.setToDB();

//add to course list in ds
final ds=User.getDS();
ds.courseIds.add(course.getDocId());
User.setDS(ds);
return course;
  }


  // Future<CourseAttendance> getAttendance()async
  // {
  //  final attref=await FirebaseFirestore.instance.collection(DataBase.COURSE_ATTENDANCE_COLLECTION).
  //  doc(attendanceObjectId).get();
  //  return CourseAttendance.fromMap(attref.data()!);

  // }


  // Future<Instructor> getInstructor() async
  // {
  //   print('in get ins');
  //   print(instructorObjectId);
  //  final insref= await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
  //  get();
  //  print('co');
  //  return Instructor.fromMap(insref.docs.first.data()!);
  // }


  // Future<Vehicle> getVehicle()async
  // {
  //   final vehref=await FirebaseFirestore.instance.collection(DataBase.VEHICLE_COLLECTION).
  //   doc(vehicleObjectId).get();

  //   return Vehicle.fromMap(vehref.data()!);
  // }



@override
   void fromSnapShot(DocumentSnapshot snapshot) {

    Map<String,dynamic> map=snapshot.data()! as Map<String,dynamic>;
    setDocId(snapshot.id);
      try {
  reviewObjectId=map['reviewObjectId'];
  dsObjectId= map['dsObjectId'] ?? '';
  dsName= map['dsName'] ?? '';
  name= map['name'] ?? '';
  courseId= map['courseId'] ?? '';
  startDate= DateTime.fromMillisecondsSinceEpoch((map['startDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch);
  endDate= DateTime.fromMillisecondsSinceEpoch((map['endDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch);
  courseDuration= map['courseDuration'] ?? '';
  courseFee= map['courseFee'] ?? 0.0;
  startTime= map['startTime'] != null ? TimeOfDay(hour: int.parse(map['startTime'].split(':')[0]), minute: int.parse(map['startTime'].split(':')[1])) :const TimeOfDay(hour: 0, minute: 0);
  endTime= map['endTime'] != null ? TimeOfDay(hour:int.parse(map['endTime'].split(':')[0]), minute: int.parse(map['endTime'].split(':')[1])) :const TimeOfDay(hour: 0, minute: 0);
  totalSeats= map['totalSeats'] ?? 0;
  availableSeats= map['availableSeats'] ?? 0;
  courseDescription= map['courseDescription'] ?? '';
  instructorObjectId= map['instructorObjectId'] ?? '';
  instructorId= map['instructorId'] ?? '';
  instructorName= map['instructorName'] ?? '';
  vehicleObjectId= map['vehicleObjectId'] ?? '';
  vehicleNumber= map['vehicleNumber'] ?? '';
  progress= (map['progress'] as List?)?.map((progressMap) => Progress.fromMap(progressMap)).toList() ?? [];
  learnerObjectIds= List<String>.from(map['learnerObjectIds'] ?? []);
  applicationObjectIds= List<String>.from(map['applicationObjectIds'] ?? []);
} on Exception catch (e,s) {

  print(e);
  print('StackTrace$s');
}
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
      'reviewObjectId':reviewObjectId,

    };
  }

// static Future<Course> getCourse(String docId)async
// {
//   final coref=await FirebaseFirestore.instance.collection(DataBase.COURSE_COLLECTION).
//   doc(docId).get();
//   return Course.fromMap(coref.data()!);
// }



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