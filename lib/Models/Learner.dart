import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Examples.dart';

class Learner {
  final String name;
  final String mobileNumber;
  final String email;
  final DateTime dob;
  final int age;
  final String address;
  final String gender;
  final List<String> courseObjectIds;
  final List<String> serviceObjectIds;

  Learner({
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.dob,
    required this.address,
    required this.gender,
    this.courseObjectIds = const [], // Default to an empty list
    this.serviceObjectIds = const [], // Default to an empty list
  }):this.age=calculateAge(dob);

  factory Learner.fromMap(Map<String, dynamic> map) {
    return Learner(
      name: map['name'] as String? ?? '',
      mobileNumber: map['mobileNumber'] as String? ?? '',
      email: map['email'] as String? ?? '',
      dob: DateTime.fromMillisecondsSinceEpoch((map['dob'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      address: map['address'] as String? ?? '',
      gender: map['gender'] as String? ?? '',
      courseObjectIds: List<String>.from(map['courseObjectIds'] ?? []),
      serviceObjectIds: List<String>.from(map['serviceObjectIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age':age,
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
      'dob': dob,
      'address': address,
      'gender': gender,
      'courseObjectIds': courseObjectIds,
      'serviceObjectIds': serviceObjectIds,
    };
  }

  Future<List<Course>> getCoursesRegisteredInSchool(DrivingSchool drivingSchool)async
  {
    List<Course> courses=[];
    Set<String> set1=courseObjectIds.toSet();
    Set<String> set2=drivingSchool.courseIds.toSet();
   List<String> interCourseIds= set1.intersection(set2).toList();
  final comaps= await DataBase.getAllDocuments(interCourseIds,DataBase.COURSE_COLLECTION);
  comaps.forEach((element) {courses.add(Course.fromMap(element));});
  return courses;
  }



}



int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int monthDiff = currentDate.month - birthDate.month;

  if (monthDiff < 0 || (monthDiff == 0 && currentDate.day < birthDate.day)) {
    age--;
  }

  return age;
}