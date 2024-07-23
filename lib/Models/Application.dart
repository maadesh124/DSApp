import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Learner.dart';

class Application {
  final DateTime dateApplied;
  final String learnerObjectId;
  final String applicationNumber;
  final String courseId; // Required
  final String schoolId; // Can be null if service application
  final String serviceId; // Can be null if course application
  final String courseName; // Added
  final String learnerName; // Added
  final String serviceName;

  Application({
    dateApplied,
    required this.learnerObjectId,
    required this.applicationNumber,
    required this.courseId, // Made non-nullable
    required  this.schoolId, // Default empty string for optional fields
    this.serviceId = 'bot applicable',
    this.serviceName = 'not applicable',
    this.courseName = '', // Default empty string for courseName
    this.learnerName = '', // Default empty string for learnerName
  }):this.dateApplied=dateApplied??DateTime.now();

  Course getCourse() => Examples.CORURSE; // Assuming Examples provides a Course object

  Learner getLearner() => Examples.LEARNER; // Assuming Examples provides a Learner object

  factory Application.fromMap(Map<String, dynamic> map) {
    // Handle potential missing or null values in the map
    return Application(
      dateApplied: DateTime.fromMillisecondsSinceEpoch((map['dateApplied'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      learnerObjectId: map['learnerObjectId'] as String  ,
      applicationNumber: map['applicationNumber'] as String,
      courseId: map['courseId'] as String, // Ensure non-null
      schoolId: map['schoolId'] ?? '',
      serviceId: map['serviceId'] ?? 'not applicable',
      courseName: map['courseName'] ?? '', // Handle potential missing courseName
      learnerName: map['learnerName'] ?? '', // Handle potential missing learnerName
      serviceName: map['seviceName'] ?? 'not applicable'
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateApplied': dateApplied,
      'learnerObjectId': learnerObjectId,
      'applicationNumber': applicationNumber,
      'courseId': courseId,
      'schoolId': schoolId,
      'serviceId': serviceId,
      'courseName': courseName,
      'learnerName': learnerName,
      'serviceName':serviceName,
    };
  }
}