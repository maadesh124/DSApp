import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/Model.dart';


class Application extends Model {

  double learnerAge;
   bool isMale;
   String learnerAddress;

   DateTime dateApplied;
   String learnerObjectId;
   String applicationNumber;
   String courseId; // Required
   String schoolId; // Can be null if service application
   String serviceId; // Can be null if course application
   String courseName; // Added
   String learnerName; // Added
   String serviceName;

  Application({super.collectionType=Model.APPLICATION,
    dateApplied,
    this.learnerAddress='',
    this.learnerAge=20,
    this.isMale=false,
    this.learnerObjectId='',
    this.applicationNumber='',
    this.courseId='', // Made non-nullable
    this.schoolId='', // Default empty string for optional fields
    this.serviceId = 'not applicable',
    this.serviceName = 'not applicable',
    this.courseName = '', // Default empty string for courseName
    this.learnerName = '', // Default empty string for learnerName
  }):this.dateApplied=dateApplied??DateTime.now();



  @override
  void fromSnapShot(DocumentSnapshot snapshot) {    
    Map<String,dynamic> map=snapshot.data()! as Map<String,dynamic>;
    setDocId(snapshot.id);
      try {
  dateApplied= DateTime.fromMillisecondsSinceEpoch((map['dateApplied'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch);
  learnerAge= map['learnerAge'];
  learnerAddress= map['learnerAddress'];
  isMale= map['isMale'] as bool;
  learnerObjectId= map['learnerObjectId'] as String  ;
  applicationNumber= map['applicationNumber'] as String;
  courseId= map['courseId'] as String; // Ensure non-null
  schoolId= map['schoolId'] ?? '';
  serviceId= map['serviceId'] ?? 'not applicable';
  courseName= map['courseName'] ?? ''; // Handle potential missing courseName
  learnerName= map['learnerName'] ?? ''; // Handle potential missing learnerName
  serviceName= map['seviceName'] ?? 'not applicable';
} on Exception catch (e) {
  Error.throwError('Error in Application fromMap');
}
    
  }

  Map<String, dynamic> toMap() {
    return {
      'learnerAge':learnerAge,
      'learnerAddress':learnerAddress,
      'isMale':isMale,
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

  // Future<Learner> getLearner()async
  // {
  //   final learef=await FirebaseFirestore.instance.collection(DataBase.LEARNER_COLLECTION).
  //   doc(learnerObjectId).get();
  //   return Learner.fromMap(learef.data()!);
  // }

//   Future<Course> register()async{
    
//    final coref=await FirebaseFirestore.instance.collection(DataBase.COURSE_COLLECTION).
//    where('dsObjectId',isEqualTo: schoolId).
//    where('courseId',isEqualTo: courseId).get().then((value) => value.docs.first);

//    final aplref=await FirebaseFirestore.instance.collection(DataBase.APPLICATION_COLLECTION).
//    where('schoolId',isEqualTo: schoolId).
//    where('applicationNumber',isEqualTo: applicationNumber).get().then((value) => value.docs.first);

//   Course course=Course.fromMap(coref.data());
//   course.applicationObjectIds.remove(aplref.id);
//   course.learnerObjectIds.add(learnerObjectId);

//   await FirebaseFirestore.instance.collection(DataBase.COURSE_COLLECTION).
//   doc(coref.id).set(course.toMap());


//   await FirebaseFirestore.instance.collection(DataBase.APPLICATION_COLLECTION).
//   doc(aplref.id).delete();

//  final leref=await FirebaseFirestore.instance.collection(DataBase.LEARNER_COLLECTION).
//  doc(learnerObjectId).get();

//   Learner learner=Learner.fromMap(leref.data()!);
//   learner.courseObjectIds.add(coref.id);
//  await FirebaseFirestore.instance.collection(DataBase.LEARNER_COLLECTION).doc(leref.id).set(learner.toMap());
//   return course;
   
//   }



  // static Future<Application> createCourse(Course course,Learner learner,String learnerObjectId) async
  // {
    
  //   Application application=Application(learnerAddress: learner.address, 
  //   courseName: course.name,
  //   learnerName: learner.name,
  //   learnerAge: learner.age+0.0,
  //    isMale: (learner.gender=='Male'),
  //     learnerObjectId: learnerObjectId,
  //      applicationNumber: course.dsObjectId+course.applicationObjectIds.length.toString(), 
  //      courseId: course.courseId,
  //       schoolId: course.dsObjectId);

  //  final appref= await FirebaseFirestore.instance.collection(DataBase.APPLICATION_COLLECTION).
  //  add(application.toMap());

  // final corefs= await FirebaseFirestore.instance.collection(DataBase.COURSE_COLLECTION).
  //  where('dsObjectId',isEqualTo: course.dsObjectId).
  //  where('courseId',isEqualTo: course.courseId).get();
  //  print(corefs.docs.first.id);

  // course.applicationObjectIds.add(appref.id);
  // print(course.toMap());
  //  await FirebaseFirestore.instance.collection(DataBase.COURSE_COLLECTION).doc((corefs.docs.first.id)).
  // set(course.toMap());



  //      return application;
  // }

}