class Instructor {
  final String name;
  final String id;
  final String mobileNumber;
  final String email;
  final DateTime joinDate;
  final double salary;
  final DateTime dob;
  final String gender;
  final String specialization;
  final String schoolId;
  final Map<String, Map<String, String>> timeTable;
  final List<String> courseIds;
  final List<String> serviceIds;
  final String objectId;
  final String password;

  Instructor({
    required this.name,
    required this.id,
    required this.mobileNumber,
    required this.email,
    required this.joinDate,
    required this.salary,
    required this.dob,
    required this.gender,
    required this.specialization,
    this.schoolId = '', // Default to an empty string
    this.timeTable = const {}, // Default to an empty map
    this.courseIds = const [], // Default to an empty list
    this.serviceIds = const [], // Default to an empty list
    this.objectId = '', // Default to an empty string
    this.password = '', // Default to an empty string
  });

  factory Instructor.fromMap(Map<String, dynamic> map) {
    return Instructor(
      name: map['name'] as String? ?? '',
      id: map['id'] as String? ?? '',
      mobileNumber: map['mobileNumber'] as String? ?? '',
      email: map['email'] as String? ?? '',
      joinDate: DateTime.fromMillisecondsSinceEpoch((map['joinDate'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      salary: map['salary'] as double? ?? 0.0,
      dob: DateTime.fromMillisecondsSinceEpoch((map['dob'].seconds * 1000) ?? DateTime.now().millisecondsSinceEpoch),
      gender: map['gender'] as String? ?? '',
      specialization: map['specialization'] as String? ?? '',
      schoolId: map['schoolId'] as String? ?? '',
      timeTable: (map['timeTable'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(
                key,
                (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)),
              )),
      courseIds: List<String>.from(map['courseIds'] ?? []),
      serviceIds: List<String>.from(map['serviceIds'] ?? []),
      objectId: map['objectId'] as String? ?? '',
      password: map['password'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
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
      'objectId': objectId,
      'password': password,
    };
  }
}
