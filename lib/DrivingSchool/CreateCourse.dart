
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/User.dart';

class CreateCourse extends StatefulWidget {
  CreateCourse({super.key});

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  
  List<Progress> progList=[];
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TextEditingController name=TextEditingController();
  TextEditingController id=TextEditingController();
  TextEditingController duration=TextEditingController();
  TextEditingController fee=TextEditingController();
  TextEditingController totalSeats=TextEditingController();
  TextEditingController insId=TextEditingController();
  TextEditingController vehId=TextEditingController();
  TextEditingController des=TextEditingController();

 Future<DateTime?> pickDate() async
 {
final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate:  DateTime(2000),
      lastDate: DateTime(2100),
    );
    return picked;
 }

 Future <TimeOfDay?> pickTime()async
 {
  final TimeOfDay? picked= await showTimePicker(context: context, initialTime: TimeOfDay.now()) ;
  return picked;
 }

  Future<void> onCreateClicked() async
  {
    DrivingSchool ds=User.getDS();
    Course course=Course(dsObjectId: User.docId,
    dsName: ds.schoolName,
    name: name.text,
    courseId: id.text,
    startDate: startDate,
    endDate: endDate,
    courseDuration: duration.text,
    courseFee: double.parse(fee.text),
    startTime: startTime,
    endTime: endTime,
    totalSeats: int.parse(totalSeats.text),
    courseDescription: des.text,
    instructorId: insId.text,
    progress: progList,
    );

    print(progList);
    Course.create(course, vehId.text);
  }


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return SingleChildScrollView(child:Container(decoration: PageConstants.PAGEBACKGROUND,
    child: Column(children: [
      SizedBox(height: 40,),
      Top(),
      SizedBox(height: 20,),
      Container(width: 0.95*sw,height: 420,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
      child: Stack(children: [
        Align(alignment: Alignment.topCenter, 
         child: Text('Create Course',style: TextStyle(
          fontSize: 20,fontWeight: FontWeight.w500
        ),)),
        Positioned(top: 40,right: 30,  child: Column(children: [
          Icon(Icons.add,size: 30,),
          Text('Add Image',style: TextStyle(fontWeight: FontWeight.w900),)
        ],)),
        Positioned(left: 10,top: 50,child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputBox(width: 150, height: 30,textEditingController: name,text: 'Course Name',),
            InputBox(width: 150, height: 30,textEditingController:id,text: 'Course id',),
            Row( mainAxisAlignment: MainAxisAlignment.start, children: [
              Text((startDate.toString()=='null')?'Select Start Date':startDate.toString().split(' ')[0]),
             
              IconButton(onPressed:()async
              {
                DateTime? picked= await pickDate();
                setState(() {
                  startDate=picked;
                });
                print(picked.toString());
              }, icon: Icon(Icons.calendar_month_rounded,size: 25,)),

              SizedBox(width: 30,),
                Text((endDate.toString()=='null')?'Select End Date':endDate.toString().split(' ')[0]),
             
              IconButton(onPressed:()async
              {
                DateTime? picked= await pickDate();
                setState(() {
                  endDate=picked;
                });
                print(picked.toString());
              }, icon: Icon(Icons.calendar_month_rounded,size: 25,))
            ],),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Text((startTime.toString()=='null')?'Select Start Time':startTime.toString()),
             
              IconButton(onPressed:()async
              {
                TimeOfDay? picked= await pickTime();
                setState(() {
                  startTime=picked;
                });
                print(picked.toString());
              }, icon: Icon(Icons.access_time,size: 25,)),

              SizedBox(width: 30,),
                Text((endTime.toString()=='null')?'Select EndTime':endTime.toString()),
             
              IconButton(onPressed:()async
              {
                TimeOfDay? picked= await pickTime();
                setState(() {
                  endTime=picked;
                });
                print(picked.toString());
              }, icon: Icon(Icons.access_time,size: 25,))
            ],),
            InputBox(width: 150, height: 30,text: 'Course Duration',textEditingController: duration,),
            InputBox(width: 150, height: 30,text: 'Course Fee',textEditingController: fee,),
            InputBox(width: 150, height: 30,text: 'Total Seats',textEditingController: totalSeats,),
            InputBox(width: 150, height: 30,text: 'Course Duration',textEditingController: duration,),
            InputBox(width: 150, height: 30,text: 'Instructor Id',textEditingController: insId,),
            InputBox(width: 150, height: 30,text: 'Vehicle Id',textEditingController: vehId,),
            InputBox(width: 0.8*sw, height: 30,text: 'Course Description',textEditingController: des,),
          
        ],),)
      ]),),
      SizedBox(height: 20,),
      ProgressView(list: progList,),
      SizedBox(height: 30,),

      Container(width: 0.8*sw,height: 40, decoration: BoxDecoration(
        color: Colors.white,borderRadius: BorderRadius.circular(10)
      ),child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.add,size: 30,),
        Text('Upload materials'),
      ],) ,),
      SizedBox(height: 30,),
      InkWell(onTap: onCreateClicked,child: Container(width: 70,height: 25,alignment: Alignment.center, 
        decoration: BoxDecoration(color: PageConstants.DARKGREEN,
      borderRadius: BorderRadius.circular(5),),child: Text(
        'Create',style: TextStyle(color: Colors.white),
      ),),),
      SizedBox(height: 30,)
    ],),));
  }
}