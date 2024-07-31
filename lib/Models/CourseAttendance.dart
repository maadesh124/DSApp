import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/Model.dart';

class CourseAttendance extends Model{

  String courseName;
  Map<String, List<SingleAttendance>> attendance; // Map of date to student attendance

  CourseAttendance({super.collectionType=Model.COURSE_ATTENDANCE,
    this.courseName='', // Made non-nullable
    this.attendance = const {}, // Default empty map for attendance
  });

   void fromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map=snapshot.data()! as Map<String, dynamic> ;
    setDocId(snapshot.id);
    // Handle potential missing or invalid values in the map
    final attendanceMap = (map['attendance'] as Map<String, dynamic>?)?.cast<String, List<dynamic>>();

    // Convert inner lists to SingleAttendance objects (assuming valid data)
    final processedAttendance = attendanceMap?.map((date, studentAttendanceList) =>
      MapEntry(
        date as String,
        studentAttendanceList.cast<Map<String, dynamic>>().map((studentData) => SingleAttendance.fromMap(studentData)).toList(),
      )
    );

  
      courseName= map['courseName'] as String;
      attendance= processedAttendance ?? const {}; // Ensure non-null attendance map
    
  }

  Map<String, dynamic> toMap() {
    // Convert attendance map back to a map with String keys and dynamic values
    final attendanceMap = attendance.map((date, studentAttendance) =>
      MapEntry(date, studentAttendance.map((singleAttendance) => singleAttendance.toMap()).toList())
    );

    return {
      'courseName': courseName,
      'attendance': attendanceMap,
    };
  }
}





class SingleAttendance {
  final String name;
  final String id;
  final bool status;

  SingleAttendance({
    this.name = 'exampleName', // Default value
    this.id = 'exampleId', // Default value
    this.status = false, // Default value
  });

  factory SingleAttendance.fromMap(Map<String, dynamic> map) {
    return SingleAttendance(
      name: map['name'] as String,
      id: map['id'] as String,
      status: map['status'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'status': status,
    };
  }
}
