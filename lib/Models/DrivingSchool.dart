



import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Examples.dart';

class DrivingSchool {
  String schoolName;
  int mobileNumber;
  String email;
  String location;
  String description;
  String ownerName;
  //String logo;
  //List<String> schoolImages;
  List<String> instructorIds;
  List<String> courseIds;
  List<String> serviceIds;
  List<String> vehicleIds;
  List<String> enquiryIds;
  String ratingIds;
  String reviewIds;
  String schoolId;
  String password;

  DrivingSchool({
    required this.schoolName,
    required this.mobileNumber,
    required this.email,
    required this.location,
    required this.description,
    required this.ownerName,
    //required this.logo,
    //required this.schoolImages,
    this.instructorIds = const [],
    this.courseIds = const [],
    this.serviceIds = const [],
    this.vehicleIds = const [],
    this.enquiryIds = const [],
    this.ratingIds = '',
    this.reviewIds = '',
    this.schoolId = '',
    this.password = '',
  });

  factory DrivingSchool.fromMap(Map<String, dynamic> map) {
    return DrivingSchool(
      schoolName: map['schoolName'] as String? ?? '',
      mobileNumber: map['mobileNumber'] as int? ?? 0,
      email: map['email'] as String? ?? '',
      location: map['location'] as String? ?? '',
      description: map['description'] as String? ?? '',
      ownerName: map['ownerName'] as String? ?? '',
      instructorIds: List<String>.from(map['instructorIds'] ?? []),
      courseIds: List<String>.from(map['courseIds'] ?? []),
      serviceIds: List<String>.from(map['serviceIds'] ?? []),
      vehicleIds: List<String>.from(map['vehicleIds'] ?? []),
      enquiryIds: List<String>.from(map['enquiryIds'] ?? []),
      ratingIds: map['ratingIds'] as String? ?? '',
      reviewIds: map['reviewIds'] as String? ?? '',
      schoolId: map['schoolId'] as String? ?? '',
      password: map['password'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'schoolName': schoolName,
      'mobileNumber': mobileNumber,
      'email': email,
      'location': location,
      'description': description,
      'ownerName': ownerName,
      'instructorIds': instructorIds,
      'courseIds': courseIds,
      'serviceIds': serviceIds,
      'vehicleIds': vehicleIds,
      'enquiryIds': enquiryIds,
      'ratingIds': ratingIds,
      'reviewIds': reviewIds,
      'schoolId': schoolId,
      'password': password,
    };
  }

  Future<List<String>> getAllApplicationIds()async
  {
    //List<Application> applications=[]; 
    List<Course> courses=[];
    List<String> applicationIds=[];
      final comaps=  await DataBase.getAllDocuments(courseIds,DataBase.COURSE_COLLECTION);
    comaps.forEach((element)=> courses.add(Course.fromMap(element)));
    courses.forEach((course)=>applicationIds.addAll(course.applicationObjectIds));
    // final apprefs=await DataBase.getAllDocuments(applicationIds,DataBase.APPLICATION_COLLECTION);
    // apprefs.forEach((element) {applications.add(Application.fromMap(element));});

    return applicationIds;
  }


  Future<List<String>> getAllLearnerIds()async
  {
    //List<Application> applications=[]; 
    List<Course> courses=[];
    List<String> learnerIds=[];
      final comaps=  await DataBase.getAllDocuments(courseIds,DataBase.COURSE_COLLECTION);
    comaps.forEach((element)=> courses.add(Course.fromMap(element)));
    courses.forEach((course)=>learnerIds.addAll(course.learnerObjectIds));
    // final apprefs=await DataBase.getAllDocuments(applicationIds,DataBase.APPLICATION_COLLECTION);
    // apprefs.forEach((element) {applications.add(Application.fromMap(element));});

    return learnerIds;
  }




}