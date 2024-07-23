

class SchoolAttendance {
  String schoolObjectId;
  Map<String, Map<String, bool>>? attendanceData;

  SchoolAttendance({
    required this.schoolObjectId,
    this.attendanceData,
  });
}
