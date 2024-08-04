
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/CourseAttendance.dart';
import 'package:fp3/DrivingSchool/InstructorView.dart';
import 'package:fp3/DrivingSchool/VehicleView.dart';
import 'package:fp3/Learner/ApplicationView.dart';
import 'package:fp3/Learner/OverViews.dart';
import 'package:fp3/Learner/SchoolViewL.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/User.dart';







class CourseViewLearner extends StatefulWidget {
  Course course;
  CourseViewLearner({required this.course, super.key});

  @override
  State<CourseViewLearner> createState() => _CourseViewLearnerState();
}

class _CourseViewLearnerState extends State<CourseViewLearner> {

bool gotData=false;
Instructor? instructor;
Vehicle? vehicle;
DrivingSchool? drivingSchool;

Future<void> initialize()async
{
instructor=  await widget.course.getInstructor();

vehicle=  await widget.course.getVehicle();

drivingSchool=await widget.course.getDrivingSchool();

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

void goToIns(Instructor ins)
{
Navigator.push(context,
MaterialPageRoute(builder: (context) => InstructorView(instructor:ins ,)));
}

void goToVeh(Vehicle vehicle)
{
  Navigator.push(context,
MaterialPageRoute(builder: (context) => VehicleView(vehicle: vehicle,type: Model.DRIVINGSCHOOL,)));
}

void gotToDS(DrivingSchool ds)async
{
  final att=await widget.course.getAttendance();
    Navigator.push(context,
MaterialPageRoute(builder: (context) => SchoolViewL(drivingSchool: ds)));
}

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(child:Container(decoration: PageConstants.LEARNER_BG ,child: 
      Column(children: [
        SizedBox(height: 40,),
        CSearchBar(),
        SizedBox(height: 20,),
        Row(children: [
          SizedBox(width: 0.025*sw,),
          Text(widget.course.name,style: TextStyle(fontSize: 20),),
          Spacer(flex: 1,),
          RatingWidget(rating: widget.course.currentRating, size: 20),
          SizedBox(width: 0.025*sw,),
        ],),
        Container(width: sw*0.95,//height: 400,
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
           children: [
          Align(alignment: Alignment.topCenter, child:Image.asset('assets/images/img.png')),
          Text('Start and End Date: ${widget.course.startDate.toString()} to ${widget.course.endDate}'),
          Text('Course Duration :${widget.course.courseDuration}'),
          Text('Start and End Time: ${formatTimeOfDay(widget.course.startTime)} - ${formatTimeOfDay(widget.course.endTime)}'),
          Text('${widget.course.availableSeats}/${widget.course.totalSeats} seats available'),
          Text(widget.course.courseDescription),
          SizedBox(height: 20,),
          Align(alignment: Alignment.bottomCenter,
            child: InkWell(onTap: (){
                          Navigator.push(context,
MaterialPageRoute(builder: (context) =>ApplicationViewLearner(course: widget.course, learner: User.getLearner())),);
            },child: Container(decoration: BoxDecoration(color: PageConstants.DARKGREEN,
              borderRadius: BorderRadius.circular(5)),
              child: Text('Apply',style: TextStyle(color: Colors.white),),padding: 
              EdgeInsets.fromLTRB(20,10,20,10),
            ),),
          )
      
        ],)),
        SizedBox(height: 30,),

        gotData?InkWell(child: DrivingSchoolOverView(drivingSchool: drivingSchool!,),
        onTap:()=>gotToDS(drivingSchool!),):Center(child: CircularProgressIndicator()),
        SizedBox(height: 20,),
        gotData?InkWell(child: InstructorOverView(instructor: instructor!),
        onTap:null,):Center(child: CircularProgressIndicator()),
        SizedBox(height: 20,),
        gotData?InkWell(child: VehicleOverview(vehicle: vehicle!),
        onTap: null,):Center(child: CircularProgressIndicator()),
        SizedBox(height: 20,),
        // ProgressView(list:widget.course.progress, editable: false,height: 200,),
        // SizedBox(height: 20,),
        // Forms(applicationIds: widget.course.applicationObjectIds, learnerIds: widget.course.learnerObjectIds),
        // SizedBox(height: 20,),
      
      ],),)),
    );
  }
}









// class Forms extends StatefulWidget {

//   List<String> applicationIds=[];
//  List<String>  learnerIds=[];
//   Forms({super.key,required this.applicationIds,required this.learnerIds});

//   @override
//   State<Forms> createState() => _FormsState();
// }

// class _FormsState extends State<Forms> {

// List<Application> applications=[];
// List<Learner> learners=[];
// int current=1;
// bool  isInitialized=false;
// int itemCount=0;



// Future<void> initialize()async
// {

//   current=1;

// applications=List.generate(widget.applicationIds.length,(_)=>Application());
// await Model.getAllModels(widget.applicationIds,applications);
// applications.forEach((element) =>print(element.toMap()));


// learners=List.generate(widget.learnerIds.length,(_)=>Learner());
// await Model.getAllModels(widget.learnerIds,learners);
// learners.forEach((element) => print(element.toMap()),);


//   setState(() {
//     isInitialized=true;
//   });
//   itemCount=applications.length;

// }

// void showApplictions()
// {
// setState(() {
//   current=2;
// });
// }

// void showLearners()
// {
//   setState(() {
//     current=1;
//   });
// }


// @override
// void initState() 
// {
//   super.initState();
  
//   initialize();
// }

//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     return Container(width: sw*0.95,height: 290,
//     //decoration: BoxDecoration(color: Colors.white,),
//    // borderRadius: BorderRadius.circular(15)
//     child:Column(children: [
//       Container(width: sw*0.8,height: 30,
//       child: Row(children: [
//         InkWell(onTap: showLearners,child: Text('Registrations',
//         style: TextStyle(fontWeight: (current==1)?FontWeight.w900:FontWeight.normal),),),
//         Spacer(flex: 1,),
//         InkWell(onTap: showApplictions,child: Text('Applications',
//         style:TextStyle(fontWeight: (current==2)?FontWeight.w900:FontWeight.normal)),)
//       ],),),
//       SizedBox(height: 10,),
//      !isInitialized? CircularProgressIndicator():Container(height: 250,width: sw*0.95,
//      child: ListView.builder(itemCount: (current==1)?learners.length:applications.length,
//      itemBuilder: (context, index) {
//        Widget widget=(current==1)?LearnerOverview(learner: learners[index]):
//        ApplicationOverview(application: applications[index]);
//        return Column(children: [widget,SizedBox(height: 5,)],);
//      },))
//     ],) );
//   }
// }