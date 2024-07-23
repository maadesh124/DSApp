class Instructor {
  String name;
  String id;
  String mobileNumber;
  String email;
  DateTime joinDate;
  double salary;
  DateTime dob;
  String gender;
 // String attendanceId;
  String specialization;
  String? schoolId;
  Map<String,Map<String, String>>? timeTable;
  List<String>? courseIds;
  List<String>? serviceIds;
  String? objectId;
  String? password;

  Instructor({
    required this.name,
    required this.id,
    required this.mobileNumber,
    required this.email,
    required this.joinDate,
    required this.salary,
    required this.dob,
    required this.gender,
    //required this.attendanceId,
    required this.specialization,
     this.schoolId,
     this.timeTable,
     this.courseIds,
     this.serviceIds,
     this.objectId,
     this.password,
  });



}