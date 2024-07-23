class Vehicle {
  final String vehicleNumber;
  final String type;
  final String vehicleId;
  final DateTime lastServiceDate;
  final DateTime nextServiceDate;
  final int numberOfCoursesUsing;
  final Map<String, Map<String, String>> timeTable;
  final List<String> courseObjectIds;

  Vehicle({
    required this.vehicleNumber,
    required this.type,
    required this.vehicleId,
    required this.lastServiceDate,
    required this.nextServiceDate,
    this.numberOfCoursesUsing = 0, // Default to 0
    this.timeTable = const {}, // Default to an empty map
    this.courseObjectIds = const [], // Default to an empty list
  });

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehicleNumber: map['vehicleNumber'] as String? ?? '',
      type: map['type'] as String? ?? '',
      vehicleId: map['vehicleId'] as String? ?? '',
      lastServiceDate: DateTime.parse(map['lastServiceDate'] as String),
      nextServiceDate: DateTime.parse(map['nextServiceDate'] as String),
      numberOfCoursesUsing: map['numberOfCoursesUsing'] as int? ?? 0,
      timeTable: (map['timeTable'] as Map<String, dynamic>? ?? {}).map((key, value) => MapEntry(
        key,
        (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)),
      )),
      courseObjectIds: List<String>.from(map['courseObjectIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicleNumber': vehicleNumber,
      'type': type,
      'vehicleId': vehicleId,
      'lastServiceDate': lastServiceDate.toIso8601String(),
      'nextServiceDate': nextServiceDate.toIso8601String(),
      'numberOfCoursesUsing': numberOfCoursesUsing,
      'timeTable': timeTable.map((key, value) => MapEntry(
        key,
        value.map((k, v) => MapEntry(k, v)),
      )),
      'courseObjectIds': courseObjectIds,
    };
  }
}
