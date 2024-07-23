import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Learner.dart';

class Application {
  DateTime? dateApplied;
  String? learnerObjectId;
  String? applicationNumber;
  String? courseId; // Nullable for service applications
  String? schoolId; // Nullable for service applications
  String? serviceId;
   // Nullable for course applications

  Application({
    this.dateApplied,
    this.learnerObjectId,
    this.applicationNumber,
    this.courseId,
    this.schoolId,
    this.serviceId,
  });

Course getCourse()=>Examples.CORURSE;
Learner getLearner()=>Examples.LEARNER;


}
