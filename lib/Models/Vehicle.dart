
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp3/Models/Model.dart';


class Vehicle extends Model {
String schoolId;
String vehicleNumber;
String name;
  // final String vehicleId;
String description;
  // final int numberOfCoursesUsing;
Map<String, Map<String, String>> timeTable;
List<String> courseObjectIds;

  Vehicle({super.collectionType=Model.VEHICLE,
this.schoolId='',
this.vehicleNumber='',
this.name='',
    // required this.vehicleId,
this.description='',
    // this.numberOfCoursesUsing = 0, // Default to 0
this.timeTable =const {'Monday':{},'Tuesday':{},
      'Wednesday':{},'Thursday':{},'Friday':{},'Saturday':{},'Sunday':{}} ,// Default to an empty map
    this.courseObjectIds = const [], // Default to an empty list
  });

  // static Future<Vehicle> create(Vehicle vehicle)async{
    
  //   final docref= await FirebaseFirestore.instance.collection(DataBase.VEHICLE_COLLECTION).add(vehicle.toMap());
  //   var ds=User.getDS();
  //   ds.vehicleIds.add(docref.id);
  //   User.setDS(ds);
  //   return vehicle;
  // }

  void fromSnapShot(DocumentSnapshot snapshot) {
Map<String,dynamic> map=snapshot.data()! as Map<String,dynamic>;
      schoolId= map['schoolId'];
      vehicleNumber= map['vehicleNumber'] as String? ?? '';
      description= map['description'];
      name= map['type'] as String? ?? '';
      // vehicleId: map['vehicleId'] as String? ?? '',
      // numberOfCoursesUsing: map['numberOfCoursesUsing'] as int? ?? 0,
      timeTable= (map['timeTable'] as Map<String, dynamic>? ?? {}).map((key, value) => MapEntry(
        key,
        (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as String)),
      ));
      courseObjectIds= List<String>.from(map['courseObjectIds'] ?? []);

  }

  Map<String, dynamic> toMap() {
    return {
      'schoolId':schoolId,
      'vehicleNumber': vehicleNumber,
      'name': name,
      // 'vehicleId': vehicleId,
      'description':description,
      // 'numberOfCoursesUsing': numberOfCoursesUsing,
      'timeTable': timeTable.map((key, value) => MapEntry(
        key,
        value.map((k, v) => MapEntry(k, v)),
      )),
      'courseObjectIds': courseObjectIds,
    };
  }
}
