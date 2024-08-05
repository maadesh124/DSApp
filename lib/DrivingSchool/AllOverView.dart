import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/Overviews.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/DrivingSchool/CreateCourse.dart';
import 'package:fp4/DrivingSchool/CreateInstructor.dart';
import 'package:fp4/DrivingSchool/CreateService.dart';
import 'package:fp4/DrivingSchool/CreateVehicle.dart';
import 'package:fp4/DrivingSchool/ServiceView.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Examples.dart';
import 'package:fp4/Models/Instructor.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/Models/Service.dart';
import 'package:fp4/Models/Vehicle.dart';
import 'package:fp4/main.dart';




class AllOverView extends StatefulWidget {

  DrivingSchool drivingSchool;
  AllOverView({required this.drivingSchool,super.key});

  @override
  State<AllOverView> createState() => _AllOverViewState();
}

class _AllOverViewState extends State<AllOverView> {

void goto(int i)
{
  Widget widget;
  switch (i) {
    case 0:
    widget=CreateCourse();  
    break;
    case 1:
    widget=CreateService();
    break;
    case 2:
    widget=CreateInstructor();
    break;
    case 3:
    widget=CreateVehicle();
    break;
    default:
    widget=SizedBox();
    print('wrong index $i');

  }

  Navigator.push(context,
MaterialPageRoute(builder: (context) =>widget));
}

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    final sh=MediaQuery.of(context).size.height;
    return MaterialApp(theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // Make the scaffold transparent
      ),home: Container(decoration: PageConstants.PAGEBACKGROUND,child: DefaultTabController(
      length: 5,child: Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, title: 
      Top(),bottom: TabBar(//isScrollable: true,
     // tabAlignment: TabAlignment.center,
     
      indicatorColor: PageConstants.DARKGREEN,
      labelColor: PageConstants.DARKGREEN,
         tabs: [
        Tab(text: 'Courses',),
        Tab(text: 'Services',),
        Tab(text: 'Instructors',),
        Tab(text: 'Vehicles',),
        Tab(text: 'Reviews',),
      ]),),body: 
      TabBarView(children: [
    (widget.drivingSchool.courseIds.length!=0)?CourseListView(courseIds: widget.drivingSchool.courseIds):Center(child: Text('Nothing to Show'),),
    (widget.drivingSchool.serviceIds.length!=0)?ServiceListView(serviceIds: widget.drivingSchool.serviceIds):Center(child: Text('Nothing to Show'),),
    (widget.drivingSchool.instructorIds.length!=0)?InstructorListView(instructorIds: widget.drivingSchool.instructorIds):Center(child: Text('Nothing to Show'),),
     (widget.drivingSchool.vehicleIds.length!=0)? VehicleListView(vehicleIds: widget.drivingSchool.vehicleIds):Center(child: Text('Nothing to Show'),),
     ReviewWidget(reviewId: widget.drivingSchool.reviewId)
      ]),
      floatingActionButton: Builder(
              builder: (BuildContext context) {
                return FloatingActionButton(
                  foregroundColor: Colors.white,
                  backgroundColor: PageConstants.DARKGREEN,
                  splashColor: Colors.black.withOpacity(0.3),
                  onPressed: () {
                    final tabController = DefaultTabController.of(context);
                    if (tabController != null) {
                      goto(tabController.index);
                    } else {
                      print('No TabController found in context');
                    }
                  },
                  child: Row(children: [Icon(Icons.add), Text('Add')],),
                );
              },
            ),),
    ),));
  }
}





class CourseListView extends StatefulWidget {

  List<String> courseIds;
 CourseListView({super.key,required this.courseIds});

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {

bool gotData=false;
List<Course> courses=[];
Future<void> initialize()async
  {
    courses=List.generate(widget.courseIds.length,(_)=>Course());
    await Model.getAllModels(widget.courseIds,courses);
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
    return gotData? ListView.builder(itemCount: courses.length,itemBuilder: (context, index) {
      print(courses[index].toMap());
      return Column(children: [
         SizedBox(height: 10,),
         CourseOverview(course: courses[index]),
     ]);
    },):Container(width: 50,height: 50,child:
     FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
    )
    ;
  }
}


class ServiceListView extends StatefulWidget {

  List<String> serviceIds;
 ServiceListView({super.key,required this.serviceIds});

  @override
  State<ServiceListView> createState() => _ServiceListViewState();
}

class _ServiceListViewState extends State<ServiceListView> {

bool gotData=false;
List<Service> services=[];
Future<void> initialize()async
  {
    services=List.generate(widget.serviceIds.length,(_)=>Service());
    await Model.getAllModels(widget.serviceIds,services);
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
    return gotData? ListView.builder(itemCount: services.length,itemBuilder: (context, index) {
      return Column(children: [
         SizedBox(height: 10,),
         ServiceOverview(service: services[index]),
     ]);
    },):Container(width: 50,height: 50,child:
     FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
    )
    ;
  }
}

class InstructorListView extends StatefulWidget {

  List<String> instructorIds;
 InstructorListView({required this.instructorIds,super.key});

  @override
  State<InstructorListView> createState() => _InstructorListViewState();
}

class _InstructorListViewState extends State<InstructorListView> {

  List<Instructor> instructors=[];
  bool gotData=false;
Future<void> initialize()async
  {
    instructors=List.generate(widget.instructorIds.length,(_)=>Instructor());
    await Model.getAllModels(widget.instructorIds,instructors);
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
    return gotData? ListView.builder(itemCount: instructors.length,itemBuilder: (context, index) {
      return Column(children: [
         SizedBox(height: 10,),
         InstructorOverview(instructor: instructors[index]),
     ]);
    },):Container(width: 50,height: 50,child:
     FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
    )
    ;
  }
}

class VehicleListView extends StatefulWidget {

  List<String> vehicleIds;
  VehicleListView({super.key,required this.vehicleIds});

  @override
  State<VehicleListView> createState() => _VehicleListViewState();
}

class _VehicleListViewState extends State<VehicleListView> {
  List<Vehicle> vehicles=[];
  bool gotData=false;


Future<void> initialize()async
  {
    vehicles=List.generate(widget.vehicleIds.length,(_)=>Vehicle());
    await Model.getAllModels(widget.vehicleIds,vehicles);
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
    return gotData? ListView.builder(itemCount: vehicles.length,itemBuilder: (context, index) {
      return Column(children: [
         SizedBox(height: 10,),
         VehicleOverview(vehicle:vehicles[index]),
     ]);
    },):Container(width: 50,height: 50,child:
     FittedBox(fit: BoxFit.cover,child: CircularProgressIndicator(),)
    )
    ;
  }

}