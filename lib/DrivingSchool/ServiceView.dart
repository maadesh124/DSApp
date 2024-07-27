import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/Overviews.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/CourseView.dart';
import 'package:fp3/DrivingSchool/CreateService.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Service.dart';
import 'package:fp3/main.dart';

class ServiceView extends StatefulWidget {

  Service service;
  ServiceView({ required this.service,super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {

bool gotData=false;
Instructor? instructor;

Future<void> initialize()async
{
  instructor=await widget.service.getInstructor();
  setState(() {
    gotData=true;
  });
}

@override
  void initState()
  {
    gotData=false;
    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return SingleChildScrollView(child: Container(decoration: PageConstants.PAGEBACKGROUND,
    child:Column(children: [
      SizedBox(height: 40,),
      Top(),
      SizedBox(height: 20,),
      Container(width: 0.95*sw,decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(10)),padding: EdgeInsets.all(10),
      child: Column(mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(alignment: Alignment.topCenter, child:Image.asset('assets/images/img.png')),
        Text('Service Name: ${widget.service.name}'),
        Text('Service Fee: ${widget.service.fee}'),
        Text(widget.service.description),
      ]),),
      SizedBox(height: 20,),
      gotData?InstructorOverview(instructor: instructor!):CircularProgressIndicator(),
      SizedBox(height: 20,),
      DocumentList(reqDocs: widget.service.requiredDocuments,editable: false,),
      SizedBox(height: 20,),
      Forms(applicationIds: widget.service.applicationObjectIds, learnerIds: widget.service.studentObjectIds)

      
    ],),),);
  }
}