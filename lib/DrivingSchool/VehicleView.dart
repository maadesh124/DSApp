
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/InstructorView.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Vehicle.dart';

import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/Overviews.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class VehicleView extends StatefulWidget {
  Vehicle vehicle;
  VehicleView({required this.vehicle ,super.key});

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {


List<Course> courses=[];
bool gotData=false;
  Future<void> initialize()async
  {
    gotData=false;
    final comaps=  await DataBase.getAllDocuments(widget.vehicle.courseObjectIds,DataBase.COURSE_COLLECTION);
    comaps.forEach((element)=>courses.add(Course.fromMap(element)));
    setState(() {
      gotData=true;
    });
  }

@override
 void initState()
  {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sw=MediaQuery.of(context).size.width;
    return SingleChildScrollView(child: 
    Container(decoration: PageConstants.PAGEBACKGROUND,child: Column(children: [
      SizedBox(height: 40,),
      Top(),
      SizedBox(height: 20,),
    Container( padding: EdgeInsets.all(10), width:0.95*sw ,decoration: BoxDecoration(color: Colors.white,
    borderRadius: BorderRadius.circular(10)),child: Column( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Align(alignment: Alignment.topCenter, child:Image.asset('assets/images/img.png')),
        Text(widget.vehicle.name),
        Text(widget.vehicle.vehicleNumber),
        Text('Used in '+widget.vehicle.courseObjectIds.length.toString()+' courses'),

        SizedBox(height: 40,),    
         
    ],),),
    SizedBox(height: 20,),
    TimeTable(timeTable: widget.vehicle.timeTable),
    SizedBox(height: 20,),
    Container(width: sw*0.95,height: 25,child: 
    Text('Courses Using this Vehicle',style: TextStyle(fontWeight: FontWeight.w600),),),
   gotData? Container(width: sw*0.95,height: 250,child: 
    ListView.builder(itemCount: courses.length,itemBuilder:(context, index) {
      return Column(children: [
        CourseOverview(course: courses[index]),
        SizedBox(height: 10,)
      ],);
    },),):CircularProgressIndicator()
    ],),),);
  }
}

