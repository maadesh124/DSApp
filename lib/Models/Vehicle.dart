import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/User.dart';

class Vehicle {
  final String schoolId;
  final String vehicleNumber;
  final String name;
  final String vehicleId;
  final String description;
  final int numberOfCoursesUsing;
  final Map<String, Map<String, String>> timeTable;
  final List<String> courseObjectIds;

  Vehicle({
    required this.schoolId,
    required this.vehicleNumber,
    required this.name,
    required this.vehicleId,
    required this.description,
    this.numberOfCoursesUsing = 0, // Default to 0
    this.timeTable =const {'Monday':{},'Tuesday':{},
      'Wednesday':{},'Thursday':{},'Friday':{},'Saturday':{},'Sunday':{}} ,// Default to an empty map
    this.courseObjectIds = const [], // Default to an empty list
  });

  static Future<Vehicle> create(Vehicle vehicle)async{
    
    final docref= await FirebaseFirestore.instance.collection(DataBase.VEHICLE_COLLECTION).add(vehicle.toMap());
    var ds=User.getDS();
    ds.vehicleIds.add(docref.id);
    User.setDS(ds);
    return vehicle;
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      schoolId: map['schoolId'],
      vehicleNumber: map['vehicleNumber'] as String? ?? '',
      description: map['description'],
      name: map['type'] as String? ?? '',
      vehicleId: map['vehicleId'] as String? ?? '',
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
      'schoolId':schoolId,
      'vehicleNumber': vehicleNumber,
      'name': name,
      'vehicleId': vehicleId,
      'description':description,
      'numberOfCoursesUsing': numberOfCoursesUsing,
      'timeTable': timeTable.map((key, value) => MapEntry(
        key,
        value.map((k, v) => MapEntry(k, v)),
      )),
      'courseObjectIds': courseObjectIds,
    };
  }
}
