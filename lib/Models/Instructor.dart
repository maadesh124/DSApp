import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/User.dart';

class Instructor extends Model {
  String name;
  String insId;
  String mobileNumber;
  String email;
  DateTime joinDate=DateTime.utc(2020);
  double salary;
  DateTime dob=DateTime.utc(2024);
  String gender;
  String specialization;
  String schoolId;
  Map<String, Map<String, String>> timeTable;
  List<String> courseIds;
  List<String> serviceIds;
  String password;

  Instructor({super.collectionType=Model.INSTRUCTOR,
    this.name='',
    this.insId='',
    this.mobileNumber='',
    this.email='',
    DateTime? joinDate1,
    this.salary=0,
    DateTime? dob1,
    this.gender='',
    this.specialization='',
    this.schoolId = '', // Default to an empty string
    this.timeTable =const {'Monday':{},'Tuesday':{},
      'Wednesday':{},'Thursday':{},'Friday':{},'Saturday':{},'Sunday':{}} , // Default to an empty map
    this.courseIds = const [], // Default to an empty list
    this.serviceIds = const [], // Default to an empty list// Default to an empty string
    this.password='', // Default to an empty string
  }):this.joinDate=joinDate1??DateTime(200),
  this.dob=dob1??DateTime(220);

  
 static Future<Instructor> createInstructor({required String id,required String pwd})async
  {
      Instructor instructor=Instructor(insId: id, password: pwd);
      instructor.joinDate=DateTime.now();
      instructor.dob=DateTime.parse('1998-07-24 15:44:00');
      instructor.schoolId=User.getDS().getDocId();

      await instructor.setToDB();
      DrivingSchool ds=User.getDS();
      ds.instructorIds.add(instructor.getDocId());
      User.setDS(ds);

      return instructor;

  }

  @override
  void fromSnapShot(DocumentSnapshot snapshot) {
Map<String, dynamic> map=snapshot.data()! as Map<String, dynamic> ;
setDocId(snapshot.id);
      try {
  name= map['name'] as String? ?? '';
  insId= map['insId'] as String? ?? '';
  mobileNumber= map['mobileNumber'] as String? ?? '';
  email= map['email'] as String? ?? '';
  joinDate= DateTime.fromMillisecondsSinceEpoch((map['joinDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch);
  salary= map['salary'] as double? ?? 0.0;
  dob= DateTime.fromMillisecondsSinceEpoch((map['dob'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch);
  gender= map['gender'] as String? ?? '';
  specialization= map['specialization'] as String? ?? '';
  schoolId= map['schoolId'] as String? ?? '';
  timeTable= (map['timeTable'] as Map<String, dynamic>? ?? {})
      .map((key, value) => MapEntry(
            key,
            (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)),
          ));
  courseIds= List<String>.from(map['courseIds'] ?? []);
  serviceIds= List<String>.from(map['serviceIds'] ?? []);
  password= map['password'] as String? ?? '';
} on Exception catch (e,s) {
  print('$e\n$s');
}
    
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
      'password': password,
    };
  }

    static Future<bool> alreadyExists({required String insId,required String schoolId})async
{
  final refs=  await FirebaseFirestore.instance.collection(Model.INSTRUCTOR).where('insId',isEqualTo: insId).
    where('schoolId',isEqualTo: schoolId).get();
    return refs.docs.isNotEmpty;
}




}
