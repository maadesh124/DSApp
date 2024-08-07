import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/DocumentList.dart';
import 'package:fp4/CustomWidgets/Overviews.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/DrivingSchool/CourseView.dart';
import 'package:fp4/DrivingSchool/CreateService.dart';
import 'package:fp4/Models/Application.dart';
import 'package:fp4/Models/Instructor.dart';
import 'package:fp4/Models/Learner.dart';
import 'package:fp4/Models/Service.dart';
import 'package:fp4/main.dart';

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
    print('init completed');
  }


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(child: Container(decoration: PageConstants.PAGEBACKGROUND,
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
        DocumentListWidget(docList: widget.service.requiredDocuments,editable: false,onDocClicked: (_)=>null,),
        SizedBox(height: 20,),
        Forms(applicationIds: widget.service.applicationObjectIds, learnerIds: widget.service.studentObjectIds)
        ,SizedBox(height: 20,),
        ReviewWidget(reviewId: widget.service.reviewObjectId)
        
      ],),),),
    );
  }
}