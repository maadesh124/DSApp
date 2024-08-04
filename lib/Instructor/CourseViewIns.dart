
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/Overviews.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Instructor/CourseAttendanceInsView.dart';
import 'package:fp3/Instructor/CourseMessage.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/User.dart';







class CourseViewIns extends StatefulWidget {
  Course course;
  CourseViewIns({required this.course, super.key});

  @override
  State<CourseViewIns> createState() => _CourseViewInsState();
}

class _CourseViewInsState extends State<CourseViewIns>  {

bool gotData=false;
Vehicle? vehicle;
List<Learner> learners=[];


Future<void> initialize()async
{

vehicle=  await widget.course.getVehicle();
learners=List.generate(widget.course.learnerObjectIds.length,(_)=>Learner());
await Model.getAllModels(widget.course.learnerObjectIds,learners);
print('Courseview ins calle');
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
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
  }


  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }


void goToVeh(Vehicle vehicle)
{
//   Navigator.push(context,
// MaterialPageRoute(builder: (context) => VehicleView(vehicle: vehicle)));
}

void gotToAtt()async
{
//   final att=await widget.course.getAttendance();
//     Navigator.push(context,
// MaterialPageRoute(builder: (context) => CourseAttendanceView(courseAttendance:att, editable:false)));
}

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SingleChildScrollView(child:Container(decoration: PageConstants.INSTRUCTOR_BACKGROUND ,child: 
      Column(children: [
        SizedBox(height: 40,),
        ElevatedButton(onPressed: ()=>widget.course.progress.forEach((element)
         {
          print(element.toMap());
          widget.course.setToDB();
          }), 
          child: Text('button')),
        Top(),
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
          Container(width: sw*0.95,padding: EdgeInsets.fromLTRB(20,20,20,20),
            child: Row(children: [
               InkWell(onTap: () {
              Navigator.push(context,
            MaterialPageRoute(builder: (context) =>CourseMessageView(course: widget.course,)),);
            },
              child: Container(width: 120,height: 30, padding: EdgeInsets.fromLTRB(7,3,7,3), decoration: BoxDecoration(
                color: PageConstants.INS_DARK,borderRadius: BorderRadius.circular(7)
              ),child: Row(children: [Text('Messages'),Spacer(flex: 1,),Icon(Icons.message_rounded)],),),
            ),
            Spacer(flex: 1,),           InkWell(onTap: () {
                    Navigator.push(context,
            MaterialPageRoute(builder: (context) =>CourseAttendanceView (course: widget.course,editable: true,)),);
            },
              child: Container(width: 120,height: 30, padding: EdgeInsets.fromLTRB(7,3,7,3), decoration: BoxDecoration(
                color: PageConstants.INS_DARK,borderRadius: BorderRadius.circular(7)
              ),child: Row(children: [Text('Attendance'),Spacer(flex: 1,),Icon(Icons.calendar_month_rounded)],),),
            )
            ],),
          )
      
        ],)),
        SizedBox(height: 30,),
      
        gotData==true?VehicleOverview(vehicle: vehicle!,type: Model.INSTRUCTOR,):CircularProgressIndicator(),
        SizedBox(height: 20,),
        ProgressView(list:widget.course.progress, editable: true,height: 200,),
        SizedBox(height: 20,),
      //   Container(width: 0.95*sw,height: 40,
      //   padding: EdgeInsets.all(10), decoration:
      //   BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),child: 
      //   Stack( 
      //     children: [InkWell(onTap: gotToAtt,
      //       child: Center(child: Text('Student Attendance Details'),)),
      //  // Spacer(flex: 1,),
      //  Align( alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios_rounded),),
      //   SizedBox(width: 20,)
      //   ],)),
        SizedBox(height: 20,),
        // Forms(applicationIds: widget.course.applicationObjectIds, learnerIds: widget.course.learnerObjectIds),
        SizedBox(height: 20,),
        Container(width: sw*0.95, child: Text('Registered Students')),
        Container(width: sw*0.95,height: 250,child: 
     !gotData?Center(child: CircularProgressIndicator(),): ListView.builder(itemCount: learners.length,itemBuilder:(context, index) {
        return Column(children: [
          LearnerOverview(learner: learners[index]),
          SizedBox(height: 10,)
        ],);
      },),)
      
      ],),)),
    );
  }
}


class ProgressView extends StatefulWidget {

List<Progress> list=[];
bool editable;
double height;

ProgressView({super.key,required this.list,required this.editable,required this.height});


  @override
  State<ProgressView> createState() => _ProgressViewState();
}



class _ProgressViewState extends State<ProgressView> {
List<Progress> progressList=[];
TextEditingController name=TextEditingController();
TextEditingController des=TextEditingController();
double height=150;

@override
void initState()
{
  super.initState();
  progressList=widget.list;
  height=widget.height;

}

void addLesson()
  {
    showDialog(context: context, builder: (context) 
    {
      return AlertDialog(title: Text("Add Lesson"),content:Container(
        height: 100, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        InputBox(height: 30,width: 200,
      text: "Lesson Name",
      textEditingController: name,),
      SizedBox(height: 10,),
      InputBox(height: 30,width: 200,
      text: "Lesson Description",
      textEditingController: des,)
      ])), 
      actions: [
        InkWell(splashColor: PageConstants.BLACK20,  onTap: ()
        {
          Navigator.of(context).pop();
        }, 
        child: Text("CANCEL",style: TextStyle(color: Colors.black),)),
      
        SizedBox(width: 10,),
        InkWell(
          onTap: ()
      {
        
        print(progressList);
        setState(() {
          progressList.add(Progress(lessonName: name.text, lessonDescription: des.text, isCompleted: 
          false));
          
        });
        name.clear();
        des.clear();
        Navigator.of(context).pop();

      }, child: Text("OK",style: TextStyle(color: Colors.black),))],);
    } );
    
  }

  @override
  Widget build(BuildContext context) {

    final sw=MediaQuery.of(context).size.width;
    int len=progressList.length<=3?progressList.length:3;
    return   Container(width: sw*0.95,height: height,
    decoration: BoxDecoration(color: Colors.white,
    borderRadius: BorderRadius.circular(15)),
    child: Column(children: [
      Row(children: [
        SizedBox(width: 0.025*sw,),
        Text('Lessons'),
      Spacer(flex: 1,),
      widget.editable?
      InkWell( onTap: addLesson, child: Container(child: Row(children: [
        Icon(Icons.add,size: 20,),
        Text('Add Lesson'),
        SizedBox(width: 0.025*sw,)
      ],),),):SizedBox(),
      ],),
      Container(width: sw*0.90,height:height-20,padding: EdgeInsets.all(0)
      ,   child: ListView.builder(itemCount: progressList.length,
      itemBuilder: (_,inex)=>SingleProgress(p: progressList[inex], index: inex+1),),)
      
    ],),);
  }
}


class SingleProgress extends StatefulWidget {

  Progress p;
  int index;
  SingleProgress({required this.p,required this.index ,super.key});

  @override
  State<SingleProgress> createState() => _SingleProgressState();
}

class _SingleProgressState extends State<SingleProgress> {
  Progress p=Progress(lessonName: '', lessonDescription: '', isCompleted: false);
  int index=0;
@override
  void initState()
{
  p=widget.p;
  index=widget.index;
  super.initState();
}


  @override
  Widget build(BuildContext context) {
     final sw=MediaQuery.of(context).size.width;
    return Column(children: [ Container(padding: EdgeInsets.all(10), width:0.95*sw ,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
    color: (widget.p.isCompleted)?PageConstants.INSCOLOR:PageConstants.BLACK20),
    child: Row(
      children: [
        Align(alignment: Alignment.centerRight,child: Checkbox(activeColor: PageConstants.BLACK20,
        focusColor: PageConstants.INSCOLOR,
          value: widget.p.isCompleted, onChanged: (val)
        {
            setState(() {
              p.isCompleted=val!;
             // print(widget.p.toMap());
            });
        },)),
        Text('${widget.index}.${widget.p.lessonName}:${widget.p.lessonDescription}',textAlign: TextAlign.left,
        softWrap: true,textDirection: TextDirection.ltr,),
      ],
    )),
    SizedBox(height: 5,)]);
  }
}