
class CourseAttendance {
  String courseId;
  String courseName;
  Map<String, Map<String, bool>>? attendance; // Map of date to student attendance

  CourseAttendance({
    required this.courseName,
    required this.courseId,
    this.attendance
  });
}
