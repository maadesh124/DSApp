

class DrivingSchool {
  String schoolName;
  int mobileNumber;
  String email;
  String location;
  String description;
  String ownerName;
  //String logo;
  //List<String> schoolImages;
  List<String>? instructorIds;
  List<String>? courseIds;
 
  List<String>? serviceIds;
  List<String>? vehicleIds;
  List<String>? enquiryIds;
  String? ratingIds;
  String? reviewIds;
  String? schoolId;
  String? password;

  DrivingSchool({
    required this.schoolName,
    required this.mobileNumber,
    required this.email,
    required this.location,
    required this.description,
    required this.ownerName,
    //required this.logo,
    //required this.schoolImages,
     this.instructorIds,
     this.courseIds,
     this.serviceIds,
     this.vehicleIds,
     this.enquiryIds,
     this.ratingIds,
     this.reviewIds,
     this.schoolId,
     this.password,
  });
}