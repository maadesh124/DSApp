
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/DrivingSchool/InstructorView.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/Examples.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/Models/Vehicle.dart';

import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/Overviews.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/Examples.dart';
import 'package:fp4/Models/Instructor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class VehicleView extends StatefulWidget {
  Vehicle vehicle;
  String type;
  VehicleView({required this.vehicle ,super.key,required this.type});

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {

BoxDecoration background=BoxDecoration();
List<Course> courses=[];
bool gotData=false;
  Future<void> initialize()async
  {
    gotData=false;

    courses=List.generate(widget.vehicle.courseObjectIds.length,(_)=>Course());
    await Model.getAllModels(widget.vehicle.courseObjectIds,courses);
   
    setState(() {
      gotData=true;
    });
  }

@override
 void initState()
  {

   background =(widget.type==Model.DRIVINGSCHOOL)? PageConstants.PAGEBACKGROUND:PageConstants.INSTRUCTOR_BACKGROUND;
    initialize();
    super.initState();
  }



  Course? getCourse(String docId)
{
  print('docId is $docId');
  print(widget.vehicle.courseObjectIds);
 int index= widget.vehicle.courseObjectIds.indexOf(docId);
  print(index);
 if(index==-1)
 return null;
 if(gotData)
 return courses[index];
}


  @override
  Widget build(BuildContext context) {

    final sw=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(child: 
      Container(decoration:background,child: Column(children: [
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
      TimeTable(timeTable: widget.vehicle.timeTable,getC: getCourse),
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
      ],),),),
    );
  }
}

