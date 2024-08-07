import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/Overviews.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Application.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Enquiry.dart';
import 'package:fp4/Models/Examples.dart';
import 'package:fp4/Models/Learner.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/Models/Service.dart';
import 'package:fp4/User.dart';


class AllFormsView extends StatefulWidget {

  DrivingSchool drivingSchool;
 AllFormsView({required this.drivingSchool,super.key});

  @override
  State<AllFormsView> createState() => _AllFormsViewState();
}

class _AllFormsViewState extends State<AllFormsView> {

  bool gotData=false;
  List<String> applicationIds=[];
  List<String> learnerIds=[];

  Future<void> initialize()async
  {
  applicationIds=  await User.getDS().getAllApplicationIds();
  learnerIds=await User.getDS().getAllLearnerIds();
  print(learnerIds);
  setState(() {
    gotData=true;
  });
  }

void initState()
{
  initialize();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    final sh=MediaQuery.of(context).size.height;
    return MaterialApp(theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // Make the scaffold transparent
      ),home:!gotData?CircularProgressIndicator(): Container(decoration: PageConstants.PAGEBACKGROUND,child: DefaultTabController(
      length: 3,child: Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, title: 
      Top(),bottom: TabBar(//isScrollable: true,
     // tabAlignment: TabAlignment.center,
     
      indicatorColor: PageConstants.DARKGREEN,
      labelColor: PageConstants.DARKGREEN,
         tabs: [
        Tab(text: 'Applications',),
        Tab(text: 'Registrations',),
        Tab(text: 'Enquiries',),
        

      ]),),body: 
      TabBarView(children: [
         ApplicationListView(applicationIds: applicationIds),
         RegistrationsListView(learnerIds: learnerIds),
         EnquiryListView(enquiryIds: widget.drivingSchool.enquiryIds),
      ]),
    ),
    ),));
  }
}




class ApplicationListView extends StatefulWidget {

  List<String> applicationIds;
  ApplicationListView({required this.applicationIds,super.key});

  @override
  State<ApplicationListView> createState() => _ApplicationListViewState();
}

class _ApplicationListViewState extends State<ApplicationListView> {

bool gotData=false;
List<Application> applications=[];

Future<void> initialize()async
  {
applications=List.generate(widget.applicationIds.length,(_)=>Application());
Model.getAllModels(widget.applicationIds,applications);
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
    final sh=MediaQuery.of(context).size.height;


    return gotData? ListView.builder(itemCount: applications.length,itemBuilder: (context, index) {
      return Column(children: [
         SizedBox(height: 10,),
         ApplicationOverview(application: applications[index]),
     ]);
    },):Container(width: 50,height: 50,child:
     FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
    )
    ;
  }
}

class RegistrationsListView extends StatefulWidget {

  List<String> learnerIds=[];
 RegistrationsListView({super.key,required this.learnerIds});

  @override
  State<RegistrationsListView> createState() => _RegistrationsListViewState();
}

class _RegistrationsListViewState extends State<RegistrationsListView> {

bool gotData=false;
List<Learner> learners=[];

Future<void> initialize()async
  {
      learners=List.generate(widget.learnerIds.length,(_)=>Learner());
      Model.getAllModels(widget.learnerIds,learners);
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
    final sh=MediaQuery.of(context).size.height;


    return gotData? ListView.builder(itemCount: learners.length,itemBuilder: (context, index) {
      return Column(children: [
         SizedBox(height: 10,),
         LearnerOverview(learner: learners[index]),
     ]);
    },):Container(width: 50,height: 50,child:
     FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
    )
    ;
  }
}

class EnquiryListView extends StatefulWidget {
  List<String> enquiryIds=[];
  EnquiryListView({super.key,required this.enquiryIds});

  @override
  State<EnquiryListView> createState() => _EnquiryListViewState();
}

class _EnquiryListViewState extends State<EnquiryListView> {
bool gotData=false;
List<Enquiry> enquiries=[];

Future<void> initialize()async
  {
enquiries=List.generate(widget.enquiryIds.length,(_)=>Enquiry());
Model.getAllModels(widget.enquiryIds,enquiries);
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
    final sh=MediaQuery.of(context).size.height;


    return gotData? ListView.builder(itemCount: enquiries.length,itemBuilder: (context, index) {
      return Column(children: [
         SizedBox(height: 10,),
         EnquiryOverview(enquiry: enquiries[index]),
     ]);
    },):Container(width: 50,height: 50,child:
     FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
    )
    ;
  }
}