

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Model.dart';

class Learner extends Model{
  String name;
   String mobileNumber;
   String email;
   DateTime dob;
   int age;
   String address;
   String gender;
   List<String> courseObjectIds;
   List<String> serviceObjectIds;
   Map<String,dynamic> enquiries;
    Map<String,dynamic> applications;
   //LinkedMap<String, dynamic> ma1; 

  Learner({super.collectionType=Model.LEARNER,
  this.enquiries=const {},
  this.applications=const {},
     this.name='NOt mentioned',
     this.mobileNumber='NOt mentioned',
     this.email='NOt mentioned',
     DateTime? dob1,
     this.address='NOt mentioned',
     this.gender='NOt mentioned',
    this.courseObjectIds = const [], // Default to an empty list
    this.serviceObjectIds = const [], // Default to an empty list
  }):this.dob=dob1??DateTime.utc(222),
  this.age=calculateAge(dob1??DateTime.utc(2000));

  void fromSnapShot(DocumentSnapshot snapshot) {
    setDocId(snapshot.id);
      Map<String, dynamic> map=snapshot.data()! as Map<String, dynamic> ;
      enquiries=map['enquiries']??{};
      applications=map['applications'];//.map((key, value) => MapEntry(key, value.toString())); ;
      name= map['name'] as String? ?? '';
      mobileNumber= map['mobileNumber'] as String? ?? '';
      email= map['email'] as String? ?? '';
      dob= DateTime.fromMillisecondsSinceEpoch((map['dob'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch);
      address= map['address'] as String? ?? '';
      gender= map['gender'] as String? ?? '';
      courseObjectIds= List<String>.from(map['courseObjectIds'] ?? []);
      serviceObjectIds= List<String>.from(map['serviceObjectIds'] ?? []);

  }

  Map<String, dynamic> toMap() {
    return {
      'enquiries':enquiries,
      'applications':applications,
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
    
    Set<String> set1=courseObjectIds.toSet();
    Set<String> set2=drivingSchool.courseIds.toSet();
   List<String> interCourseIds= set1.intersection(set2).toList();
   List<Course> courses=List.filled(interCourseIds.length,Course());
  await Model.getAllModels(interCourseIds,courses);
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