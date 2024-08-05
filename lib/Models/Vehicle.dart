
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/User.dart';


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

  static Future<Vehicle> create(Vehicle vehicle)async{
    
    await vehicle.setToDB();
    var ds=User.getDS();
    ds.vehicleIds.add(vehicle.getDocId());
    User.setDS(ds);
    return vehicle;
  }


static Future<bool> alreadyExists({required String vehicleNumber,required String schoolId})async
{
  final refs=  await FirebaseFirestore.instance.collection(Model.VEHICLE).
  where('vehicleNumber',isEqualTo: vehicleNumber).
    where('schoolId',isEqualTo: schoolId).get();
    return refs.docs.isNotEmpty;
}

  void fromSnapShot(DocumentSnapshot snapshot) {
Map<String,dynamic> map=snapshot.data()! as Map<String,dynamic>;
setDocId(snapshot.id);
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
