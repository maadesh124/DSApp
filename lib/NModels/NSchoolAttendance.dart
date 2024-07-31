
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/NModels/NCourseAttendance.dart';
import 'package:fp3/NModels/NModel.dart';

class NSchoolAttendance extends Model {
String schoolId;
Map<String, List<SingleAttendance>> attendance; // Map of date to student attendance

  NSchoolAttendance({super.collectionType=Model.SCHOOL_ATTENDANCE,
   this.schoolId='', // Made non-nullable// Made non-nullable
    this.attendance = const {}, // Default empty map for attendance
  });

   void fromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map=snapshot.data()! as Map<String, dynamic>;
    setDocId(snapshot.id);

    final attendanceMap = (map['attendance'] as Map<String, dynamic>?)?.cast<String, List<dynamic>>();

    // Convert inner lists to SingleAttendance objects (assuming valid data)
    final processedAttendance = attendanceMap?.map((date, studentAttendanceList) =>
      MapEntry(
        date as String,
        studentAttendanceList.cast<Map<String, dynamic>>().map((studentData) => SingleAttendance.fromMap(studentData)).toList(),
      )
    );

   
      schoolId= map['schoolId'] as String;
      attendance= processedAttendance ?? const {}; // Ensure non-null attendance map
    
  }

  Map<String, dynamic> toMap() {
    // Convert attendance map back to a map with String keys and dynamic values
    final attendanceMap = attendance.map((date, studentAttendance) =>
      MapEntry(date, studentAttendance.map((singleAttendance) => singleAttendance.toMap()).toList())
    );

    return {
      'schoolId': schoolId,
      'attendance': attendanceMap,
    };
  }
}
