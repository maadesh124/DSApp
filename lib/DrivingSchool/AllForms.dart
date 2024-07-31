// import 'package:flutter/material.dart';
// import 'package:fp3/CustomWidgets/Overviews.dart';
// import 'package:fp3/CustomWidgets/PageWidgets.dart';
// import 'package:fp3/Models/Application.dart';
// import 'package:fp3/Models/DrivingSchool.dart';
// import 'package:fp3/Models/Enquiry.dart';
// import 'package:fp3/Models/Examples.dart';
// import 'package:fp3/Models/Learner.dart';
// import 'package:fp3/Models/Service.dart';
// import 'package:fp3/User.dart';


// class AllFormsView extends StatefulWidget {

//   DrivingSchool drivingSchool;
//  AllFormsView({required this.drivingSchool,super.key});

//   @override
//   State<AllFormsView> createState() => _AllFormsViewState();
// }

// class _AllFormsViewState extends State<AllFormsView> {

//   bool gotData=false;
//   List<String> applicationIds=[];
//   List<String> learnerIds=[];

//   Future<void> initialize()async
//   {
//   applicationIds=  await User.getDS().getAllApplicationIds();
//   learnerIds=await User.getDS().getAllLearnerIds();
//   print(learnerIds);
//   setState(() {
//     gotData=true;
//   });
//   }

// void initState()
// {
//   initialize();
//   super.initState();
// }

//   @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     final sh=MediaQuery.of(context).size.height;
//     return MaterialApp(theme: ThemeData(
//         scaffoldBackgroundColor: Colors.transparent, // Make the scaffold transparent
//       ),home:!gotData?CircularProgressIndicator(): Container(decoration: PageConstants.PAGEBACKGROUND,child: DefaultTabController(
//       length: 3,child: Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, title: 
//       Top(),bottom: TabBar(//isScrollable: true,
//      // tabAlignment: TabAlignment.center,
     
//       indicatorColor: PageConstants.DARKGREEN,
//       labelColor: PageConstants.DARKGREEN,
//          tabs: [
//         Tab(text: 'Applications',),
//         Tab(text: 'Registrations',),
//         Tab(text: 'Enquiries',),
        

//       ]),),body: 
//       TabBarView(children: [
//          ApplicationListView(applicationIds: applicationIds),
//          RegistrationsListView(learnerIds: learnerIds),
//          EnquiryListView(enquiryIds: widget.drivingSchool.enquiryIds),
//       ]),
//     ),
//     ),));
//   }
// }




// class ApplicationListView extends StatefulWidget {

//   List<String> applicationIds;
//   ApplicationListView({required this.applicationIds,super.key});

//   @override
//   State<ApplicationListView> createState() => _ApplicationListViewState();
// }

// class _ApplicationListViewState extends State<ApplicationListView> {

// bool gotData=false;
// List<Application> applications=[];

// Future<void> initialize()async
//   {
//     final comaps=  await DataBase.getAllDocuments(widget.applicationIds,DataBase.APPLICATION_COLLECTION);
//     comaps.forEach((element)=>applications.add(Application.fromMap(element)));
//     setState(() {
//       gotData=true;
//     });
//   }


// @override
// void initState()
// {
//   initialize();
//   super.initState();
// }



//  @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     final sh=MediaQuery.of(context).size.height;


//     return gotData? ListView.builder(itemCount: applications.length,itemBuilder: (context, index) {
//       return Column(children: [
//          SizedBox(height: 10,),
//          ApplicationOverview(application: applications[index]),
//      ]);
//     },):Container(width: 50,height: 50,child:
//      FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
//     )
//     ;
//   }
// }

// class RegistrationsListView extends StatefulWidget {

//   List<String> learnerIds=[];
//  RegistrationsListView({super.key,required this.learnerIds});

//   @override
//   State<RegistrationsListView> createState() => _RegistrationsListViewState();
// }

// class _RegistrationsListViewState extends State<RegistrationsListView> {

// bool gotData=false;
// List<Learner> learners=[];

// Future<void> initialize()async
//   {
//     final comaps=  await DataBase.getAllDocuments(widget.learnerIds,DataBase.LEARNER_COLLECTION);
//     comaps.forEach((element)=>learners.add(Learner.fromMap(element)));
//     setState(() {
//       gotData=true;
//     });
//   }


// @override
// void initState()
// {
//   initialize();
//   super.initState();
// }



//  @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     final sh=MediaQuery.of(context).size.height;


//     return gotData? ListView.builder(itemCount: learners.length,itemBuilder: (context, index) {
//       return Column(children: [
//          SizedBox(height: 10,),
//          LearnerOverview(learner: learners[index]),
//      ]);
//     },):Container(width: 50,height: 50,child:
//      FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
//     )
//     ;
//   }
// }

// class EnquiryListView extends StatefulWidget {
//   List<String> enquiryIds=[];
//   EnquiryListView({super.key,required this.enquiryIds});

//   @override
//   State<EnquiryListView> createState() => _EnquiryListViewState();
// }

// class _EnquiryListViewState extends State<EnquiryListView> {
// bool gotData=false;
// List<Enquiry> enquiries=[];

// Future<void> initialize()async
//   {
//     final comaps=  await DataBase.getAllDocuments(widget.enquiryIds,DataBase.ENQUIRY_COLLECTION);
//     comaps.forEach((element)=>enquiries.add(Enquiry.fromMap(element)));
//     setState(() {
//       gotData=true;
//     });
//   }


// @override
// void initState()
// {
//   initialize();
//   super.initState();
// }



//  @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     final sh=MediaQuery.of(context).size.height;


//     return gotData? ListView.builder(itemCount: enquiries.length,itemBuilder: (context, index) {
//       return Column(children: [
//          SizedBox(height: 10,),
//          EnquiryOverview(enquiry: enquiries[index]),
//      ]);
//     },):Container(width: 50,height: 50,child:
//      FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
//     )
//     ;
//   }
// }