
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Application.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/Learner.dart';
import 'package:fp4/Models/Service.dart';

class ApplicationViewLearner extends StatefulWidget {

  Course? course;
  Service? service;
  Learner learner;
 ApplicationViewLearner({this.service,this.course,required this.learner,super.key,});

  @override
  State<ApplicationViewLearner> createState() => _ApplicationViewLearnerState();
}

class _ApplicationViewLearnerState extends State<ApplicationViewLearner> {
Application application=Application();
bool gotData=false;

Future<void> initialize()async
{
  if (widget.service==null) {
  if(widget.learner.applications.keys.toList().contains(widget.course!.getDocId()))
  {
  application.setDocId(widget.learner.applications[widget.course!.getDocId()]);
  await application.getFromDB();
  }
  else
  {
   application= await Application.createCourse(course: widget.course!,learner: widget.learner) ;
  }
}
else{
if(widget.learner.applications.keys.toList().contains(widget.service!.getDocId()))
  {
  application.setDocId(widget.learner.applications[widget.service!.getDocId()]);
  await application.getFromDB();
  }
  else
  {
   application= await Application.createService(widget.service!,widget.learner) ;
  }
}

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
    return Scaffold(body: Container(
      decoration: PageConstants.LEARNER_BG,
      child:Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 20,),
        CSearchBar(),
        SizedBox(height: 20,),
       !gotData?SizedBox(): Container(width: sw*0.95,padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
        child: 
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Align(alignment: Alignment.topCenter,  
          child: Icon(Icons.person,color: PageConstants.LEARNER_LIGHT,size: 100,)),
          Text('Name: ${widget.learner.name}'),
          Text('Service or Course Name: ${(widget.service==null)?widget.course!.name:widget.service!.name}'),
          (widget.service==null)?Text('Course Id: ${widget.course!.courseId}'):SizedBox(),
          Text('School Name: ${(widget.service==null)?widget.course!.dsName:widget.service!.schoolName}'),
          Text('Age: ${widget.learner.age}'),
          Text('Gender: ${widget.learner.gender}'),
          Text('Date Applied: ${application.dateApplied}'),
          Text('Application Nuber:${application.applicationNumber}'),
          Text('Email id: ${widget.learner.email}'),
          Text('Mobile Number: ${widget.learner.mobileNumber}'),
         // Text('Date of Birth: ${learner!.mobileNumber}'),
          SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ],)

        ],),)
      ],) ,
    ),);
  }
}