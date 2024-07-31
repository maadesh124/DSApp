// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fp3/CustomWidgets/Overviews.dart';
// import 'package:fp3/CustomWidgets/PageWidgets.dart';
// import 'package:fp3/DrivingSchool/CreateCourse.dart';
// import 'package:fp3/DrivingSchool/CreateInstructor.dart';
// import 'package:fp3/DrivingSchool/CreateService.dart';
// import 'package:fp3/DrivingSchool/CreateVehicle.dart';
// import 'package:fp3/DrivingSchool/ServiceView.dart';
// import 'package:fp3/Models/Course.dart';
// import 'package:fp3/Models/DrivingSchool.dart';
// import 'package:fp3/Models/Examples.dart';
// import 'package:fp3/Models/Instructor.dart';
// import 'package:fp3/Models/Service.dart';
// import 'package:fp3/Models/Vehicle.dart';
// import 'package:fp3/main.dart';



// class AllOverView extends StatefulWidget {

//   DrivingSchool drivingSchool;
//   AllOverView({required this.drivingSchool,super.key});

//   @override
//   State<AllOverView> createState() => _AllOverViewState();
// }

// class _AllOverViewState extends State<AllOverView> {

// void goto(int i)
// {
//   Widget widget;
//   switch (i) {
//     case 0:
//     widget=CreateCourse();  
//     break;
//     case 1:
//     widget=CreateService();
//     break;
//     case 2:
//     widget=CreateInstructor();
//     break;
//     case 3:
//     widget=CreateVehicle();
//     break;
//     default:
//     widget=SizedBox();
//     print('wrong index $i');

//   }

//   Navigator.push(context,
// MaterialPageRoute(builder: (context) =>widget));
// }

//   @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     final sh=MediaQuery.of(context).size.height;
//     return MaterialApp(theme: ThemeData(
//         scaffoldBackgroundColor: Colors.transparent, // Make the scaffold transparent
//       ),home: Container(decoration: PageConstants.PAGEBACKGROUND,child: DefaultTabController(
//       length: 4,child: Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, title: 
//       Top(),bottom: TabBar(//isScrollable: true,
//      // tabAlignment: TabAlignment.center,
     
//       indicatorColor: PageConstants.DARKGREEN,
//       labelColor: PageConstants.DARKGREEN,
//          tabs: [
//         Tab(text: 'Courses',),
//         Tab(text: 'Services',),
//         Tab(text: 'Instructors',),
//         Tab(text: 'Vehicles',)
//       ]),),body: 
//       TabBarView(children: [
//         CourseListView(courseIds: widget.drivingSchool.courseIds),
//         ServiceListView(serviceIds: widget.drivingSchool.serviceIds),
//         InstructorListView(instructorIds: widget.drivingSchool.instructorIds),
//         VehicleListView(vehicleIds: widget.drivingSchool.vehicleIds),
//       ]),
//       floatingActionButton: Builder(
//               builder: (BuildContext context) {
//                 return FloatingActionButton(
//                   foregroundColor: Colors.white,
//                   backgroundColor: PageConstants.DARKGREEN,
//                   splashColor: Colors.black.withOpacity(0.3),
//                   onPressed: () {
//                     final tabController = DefaultTabController.of(context);
//                     if (tabController != null) {
//                       goto(tabController.index);
//                     } else {
//                       print('No TabController found in context');
//                     }
//                   },
//                   child: Row(children: [Icon(Icons.add), Text('Add')],),
//                 );
//               },
//             ),),
//     ),));
//   }
// }





// class CourseListView extends StatefulWidget {

//   List<String> courseIds;
//  CourseListView({super.key,required this.courseIds});

//   @override
//   State<CourseListView> createState() => _CourseListViewState();
// }

// class _CourseListViewState extends State<CourseListView> {

// bool gotData=false;
// List<Course> courses=[];
// Future<void> initialize()async
//   {
//     final comaps=  await DataBase.getAllDocuments(widget.courseIds,DataBase.COURSE_COLLECTION);
//     comaps.forEach((element)=>courses.add(Course.fromMap(element)));
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


//   @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     final sh=MediaQuery.of(context).size.height;
//     return gotData? ListView.builder(itemCount: courses.length,itemBuilder: (context, index) {
//       return Column(children: [
//          SizedBox(height: 10,),
//          CourseOverview(course: courses[index]),
//      ]);
//     },):Container(width: 50,height: 50,child:
//      FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
//     )
//     ;
//   }
// }


// class ServiceListView extends StatefulWidget {

//   List<String> serviceIds;
//  ServiceListView({super.key,required this.serviceIds});

//   @override
//   State<ServiceListView> createState() => _ServiceListViewState();
// }

// class _ServiceListViewState extends State<ServiceListView> {

// bool gotData=false;
// List<Service> services=[];
// Future<void> initialize()async
//   {
//     final comaps=  await DataBase.getAllDocuments(widget.serviceIds,DataBase.SERVICE_COLLECTION);
//     comaps.forEach((element)=>services.add(Service.fromMap(element)));
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


//   @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     final sh=MediaQuery.of(context).size.height;
//     return gotData? ListView.builder(itemCount: services.length,itemBuilder: (context, index) {
//       return Column(children: [
//          SizedBox(height: 10,),
//          ServiceOverview(service: services[index]),
//      ]);
//     },):Container(width: 50,height: 50,child:
//      FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
//     )
//     ;
//   }
// }

// class InstructorListView extends StatefulWidget {

//   List<String> instructorIds;
//  InstructorListView({required this.instructorIds,super.key});

//   @override
//   State<InstructorListView> createState() => _InstructorListViewState();
// }

// class _InstructorListViewState extends State<InstructorListView> {

//   List<Instructor> instructors=[];
//   bool gotData=false;
// Future<void> initialize()async
//   {
//     final comaps=  await DataBase.getAllDocuments(widget.instructorIds,DataBase.INSTRUCTOR_COLLECTION);
//     comaps.forEach((element)=>instructors.add(Instructor.fromMap(element)));
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
//    @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     final sh=MediaQuery.of(context).size.height;
//     return gotData? ListView.builder(itemCount: instructors.length,itemBuilder: (context, index) {
//       return Column(children: [
//          SizedBox(height: 10,),
//          InstructorOverview(instructor: instructors[index]),
//      ]);
//     },):Container(width: 50,height: 50,child:
//      FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
//     )
//     ;
//   }
// }

// class VehicleListView extends StatefulWidget {

//   List<String> vehicleIds;
//   VehicleListView({super.key,required this.vehicleIds});

//   @override
//   State<VehicleListView> createState() => _VehicleListViewState();
// }

// class _VehicleListViewState extends State<VehicleListView> {
//   List<Vehicle> vehicles=[];
//   bool gotData=false;


// Future<void> initialize()async
//   {
//     final comaps=  await DataBase.getAllDocuments(widget.vehicleIds,DataBase.VEHICLE_COLLECTION);
//     comaps.forEach((element)=>vehicles.add(Vehicle.fromMap(element)));
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
//     return gotData? ListView.builder(itemCount: vehicles.length,itemBuilder: (context, index) {
//       return Column(children: [
//          SizedBox(height: 10,),
//          VehicleOverview(vehicle:vehicles[index]),
//      ]);
//     },):Container(width: 50,height: 50,child:
//      FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
//     )
//     ;
//   }

// }