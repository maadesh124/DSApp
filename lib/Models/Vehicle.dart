

class Vehicle {
  String vehicleNumber;
  String type;
  String vehicleId;
  DateTime lastServiceDate;
  DateTime nextServiceDate;
  int? numberOfCoursesUsing;
  //bool? availability;
  // List<Certificate> certificates; // To be implemented later
  Map<String,Map<String,String>>? timeTable; // Assuming time table is a map
  List<String>? courseObjectIds;

  Vehicle({
    required this.vehicleNumber,
    required this.type,
    required this.vehicleId,
    required this.lastServiceDate,
    required this.nextServiceDate,
    this.numberOfCoursesUsing,
    //required this.availability,
    this.timeTable,
    this.courseObjectIds,
  });
}
