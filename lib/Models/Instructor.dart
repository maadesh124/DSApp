import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fp3/DrivingSchool/CreateInstructor.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/User.dart';

class Instructor {
  String name;
  String insId;
  String mobileNumber;
  String email;
  DateTime? joinDate=DateTime.now();
  double salary;
  DateTime? dob;
  String gender;
  String specialization;
  String schoolId;
  Map<String, Map<String, String>> timeTable;
  List<String> courseIds;
  List<String> serviceIds;
  String objectId;
  String password;

  Instructor({
    this.name='',
    required this.insId,
    this.mobileNumber='',
    this.email='',
    this.joinDate,
    this.salary=0,
    this.dob,
    this.gender='',
    this.specialization='',
    this.schoolId = '', // Default to an empty string
    this.timeTable = const {}, // Default to an empty map
    this.courseIds = const [], // Default to an empty list
    this.serviceIds = const [], // Default to an empty list
    this.objectId = '', // Default to an empty string
    required  this.password , // Default to an empty string
  });

  
 static Future<Instructor> createInstructor({required String id,required String pwd})async
  {
      Instructor instructor=Instructor(insId: id, password: pwd);
      instructor.joinDate=DateTime.now();
      instructor.dob=DateTime.parse('1998-07-24 15:44:00');
      instructor.schoolId=User.docId;

      final doc=await FirebaseFirestore.instance.collection(DataBase.INSTRUCTOR_COLLECTION).
      add(instructor.toMap());
      instructor.objectId=doc.id;
      DrivingSchool ds=User.getDS();
      ds.instructorIds.add(doc.id);
      User.setDS(ds);

      return instructor;

  }

  factory Instructor.fromMap(Map<String, dynamic> map) {
    return Instructor(
      name: map['name'] as String? ?? '',
      insId: map['insId'] as String? ?? '',
      mobileNumber: map['mobileNumber'] as String? ?? '',
      email: map['email'] as String? ?? '',
      joinDate: DateTime.fromMillisecondsSinceEpoch((map['joinDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      salary: map['salary'] as double? ?? 0.0,
      dob: DateTime.fromMillisecondsSinceEpoch((map['dob'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      gender: map['gender'] as String? ?? '',
      specialization: map['specialization'] as String? ?? '',
      schoolId: map['schoolId'] as String? ?? '',
      timeTable: (map['timeTable'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(
                key,
                (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)),
              )),
      courseIds: List<String>.from(map['courseIds'] ?? []),
      serviceIds: List<String>.from(map['serviceIds'] ?? []),
      objectId: map['objectId'] as String? ?? '',
      password: map['password'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'insId': insId,
      'mobileNumber': mobileNumber,
      'email': email,
      'joinDate': joinDate,
      'salary': salary,
      'dob': dob,
      'gender': gender,
      'specialization': specialization,
      'schoolId': schoolId,
      'timeTable': timeTable.map((key, value) => MapEntry(
            key,
            value.map((k, v) => MapEntry(k, v)),
          )),
      'courseIds': courseIds,
      'serviceIds': serviceIds,
      'objectId': objectId,
      'password': password,
    };
  }
}
