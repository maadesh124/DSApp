import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/Model.dart';

class DrivingSchool extends Model{
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
  String reviewId;


  DrivingSchool({super.collectionType=Model.DRIVINGSCHOOL,
    this.schoolName='Not Mentioned',
    this.mobileNumber=9988776655,
    this.email='Not Mentioned',
    this.location='Not Mentioned',
    this.description='Not Mentioned',
    this.ownerName='Not Mentioned',
    this.instructorIds = const [],
    this.courseIds = const [],
    this.serviceIds = const [],
    this.vehicleIds = const [],
    this.enquiryIds = const [],
    this.reviewId = '',

  });

  @override
  void fromSnapShot(DocumentSnapshot snapshot) {

    setDocId(snapshot.id);
    Map<String, dynamic> map =snapshot.data()! as Map<String, dynamic> ;

      schoolName= map['schoolName'] as String? ?? '';
      mobileNumber= map['mobileNumber'] as int? ?? 0;
      email= map['email'] as String? ?? '';
      location= map['location'] as String? ?? '';
      description= map['description'] as String? ?? '';
      ownerName= map['ownerName'] as String? ?? '';
      instructorIds= List<String>.from(map['instructorIds'] ?? []);
      courseIds= List<String>.from(map['courseIds'] ?? []);
      serviceIds= List<String>.from(map['serviceIds'] ?? []);
      vehicleIds= List<String>.from(map['vehicleIds'] ?? []);
      enquiryIds= List<String>.from(map['enquiryIds'] ?? []);
      reviewId= map['reviewIds'] as String? ?? '';


  }

  @override
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
      'reviewIds': reviewId,

    };
  }

  // Future<List<String>> getAllApplicationIds()async
  // {
  //   //List<Application> applications=[]; 
  //   List<Course> courses=[];
  //   List<String> applicationIds=[];
  //     final comaps=  await DataBase.getAllDocuments(courseIds,DataBase.COURSE_COLLECTION);
  //   comaps.forEach((element)=> courses.add(Course.fromMap(element)));
  //   courses.forEach((course)=>applicationIds.addAll(course.applicationObjectIds));
  //   // final apprefs=await DataBase.getAllDocuments(applicationIds,DataBase.APPLICATION_COLLECTION);
  //   // apprefs.forEach((element) {applications.add(Application.fromMap(element));});

  //   return applicationIds;
  // }


  // Future<List<String>> getAllLearnerIds()async
  // {
  //   //List<Application> applications=[]; 
  //   List<Course> courses=[];
  //   List<String> learnerIds=[];
  //     final comaps=  await DataBase.getAllDocuments(courseIds,DataBase.COURSE_COLLECTION);
  //   comaps.forEach((element)=> courses.add(Course.fromMap(element)));
  //   courses.forEach((course)=>learnerIds.addAll(course.learnerObjectIds));
  //   // final apprefs=await DataBase.getAllDocuments(applicationIds,DataBase.APPLICATION_COLLECTION);
  //   // apprefs.forEach((element) {applications.add(Application.fromMap(element));});

  //   return learnerIds;
  // }




}