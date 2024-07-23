

import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Instructor.dart';

class Service {
  String name;
  double fee;
  String description;
  String instructorId;
  List<String> requiredDocuments;
  List<String>? studentObjectIds;
  List<String>? applicationObjectIds;
  String? ratingObjectId;
  String? reviewObjectId;

  Service({
    required this.name,
    required this.fee,
    required this.description,
    required this.instructorId,
    required this.requiredDocuments,
    this.studentObjectIds,
    this.applicationObjectIds,
    this.ratingObjectId,
    this.reviewObjectId,
  });

Instructor getInstructor()=>Examples.INSTRUCTOR;


}
