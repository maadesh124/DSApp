import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Instructor.dart';

class Service {
  final String name;
  final double fee;
  final String description;
  final String instructorId;
  final List<String> requiredDocuments;
  final List<String> studentObjectIds;
  final List<String> applicationObjectIds;
  String ratingObjectId;
  String reviewObjectId;

  Service({
    required this.name,
    required this.fee,
    required this.description,
    required this.instructorId,
    required this.requiredDocuments,
    this.studentObjectIds = const [], // Default to an empty list
    this.applicationObjectIds = const [], // Default to an empty list
    this.ratingObjectId = 'ratingid1',
    this.reviewObjectId = 'reviewid1',
  });

  Instructor getInstructor() => Examples.INSTRUCTOR;

  Future<void> setIds()async
  {
   await FirebaseFirestore.instance.collection(DataBase.RATINGS_COLLECTION).add({}).
   then((docref)=>ratingObjectId=docref.id);
   await FirebaseFirestore.instance.collection(DataBase.REVIEWS_COLLECTION).add({}).
   then((value) => reviewObjectId=value.id);
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      name: map['name'] as String? ?? '',
      fee: map['fee'] as double? ?? 0.0,
      description: map['description'] as String? ?? '',
      instructorId: map['instructorId'] as String? ?? '',
      requiredDocuments: List<String>.from(map['requiredDocuments'] ?? []),
      studentObjectIds: List<String>.from(map['studentObjectIds'] ?? []),
      applicationObjectIds: List<String>.from(map['applicationObjectIds'] ?? []),
      ratingObjectId: map['ratingObjectId'] as String? ?? '',
      reviewObjectId: map['reviewObjectId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fee': fee,
      'description': description,
      'instructorId': instructorId,
      'requiredDocuments': requiredDocuments,
      'studentObjectIds': studentObjectIds,
      'applicationObjectIds': applicationObjectIds,
      'ratingObjectId': ratingObjectId,
      'reviewObjectId': reviewObjectId,
    };
  }
}
