
import 'package:fp3/Models/CourseAttendance.dart';


class SchoolAttendance {
  final String schoolId;
  final Map<String, List<SingleAttendance>> attendance; // Map of date to student attendance

  SchoolAttendance({
    required this.schoolId, // Made non-nullable// Made non-nullable
    this.attendance = const {}, // Default empty map for attendance
  });

   factory SchoolAttendance.fromMap(Map<String, dynamic> map) {
    // Handle potential missing or invalid values in the map
    final attendanceMap = (map['attendance'] as Map<String, dynamic>?)?.cast<String, List<dynamic>>();

    // Convert inner lists to SingleAttendance objects (assuming valid data)
    final processedAttendance = attendanceMap?.map((date, studentAttendanceList) =>
      MapEntry(
        date as String,
        studentAttendanceList.cast<Map<String, dynamic>>().map((studentData) => SingleAttendance.fromMap(studentData)).toList(),
      )
    );

    return SchoolAttendance(
      schoolId: map['schoolId'] as String,
      attendance: processedAttendance ?? const {}, // Ensure non-null attendance map
    );
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
