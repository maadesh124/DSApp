import 'package:flutter/material.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Vehicle.dart';


class Course {
  String dsObjectId;
  String dsName;
  String name;
  String courseId;
  DateTime startDate;
  DateTime endDate;
  Duration courseDuration;
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
    Duration? courseDuration,
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
        courseDuration = courseDuration ?? Duration(hours: 0),
        startTime = startTime ?? TimeOfDay(hour: 0, minute: 0),
        endTime = endTime ?? TimeOfDay(hour: 0, minute: 0),
        progress = progress ?? [],
        learnerObjectIds = learnerObjectIds ?? [],
        applicationObjectIds = applicationObjectIds ?? [],
        enquiryObjectIds = enquiryObjectIds ?? [];

  Instructor getInstructor() => Examples.INSTRUCTOR;

  Vehicle getVehicle() => Examples.VEHICLE;

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      dsObjectId: map['dsObjectId'] ?? '',
      dsName: map['dsName'] ?? '',
      name: map['name'] ?? '',
      courseId: map['courseId'] ?? '',
      startDate: DateTime.fromMillisecondsSinceEpoch((map['startDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      endDate: DateTime.fromMillisecondsSinceEpoch((map['endDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      courseDuration: Duration(hours: map['courseDuration'] ?? 0),
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
      'courseDuration': courseDuration.inHours,
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
