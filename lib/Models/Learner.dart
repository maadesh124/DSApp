


class Learner {
  String name;
  String mobileNumber;
  String email;
  DateTime dob;
  String address;
  String gender;
  List<String>? courseObjectIds;
  List<String>? serviceObjectIds;

  Learner({
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.dob,
    required this.address,
    required this.gender,
    this.courseObjectIds,
    this.serviceObjectIds,
  });
}