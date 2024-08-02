
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Instructor/OverView.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Model.dart';

class AllCourseView extends StatefulWidget {

  Instructor instructor;
  AllCourseView({super.key,required this.instructor});

  @override
  State<AllCourseView> createState() => _AllCourseViewState();
}

class _AllCourseViewState extends State<AllCourseView> {

bool gotData=false;
List<Course> courses=[];

Future<void> initialize()async
{
  courses=List.generate(widget.instructor.courseIds.length, (index) =>Course());
 await Model.getAllModels(widget.instructor.courseIds,courses);
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
    return Scaffold(body: 
    Container(decoration: PageConstants.INSTRUCTOR_BACKGROUND,
    child: Column(children: [
      SizedBox(height: 40,),
      Top(),
      SizedBox(height: 20,),
      Container(width: sw*0.95,child: Text('Courses you handle'),),
       !gotData?Center(child: CircularProgressIndicator(),):
        Container(height:sh-120 ,
        child: ListView.builder(itemCount: courses.length,
        itemBuilder: (context, index) => Column(
          children: [
            CourseOverview(course: courses[index]),
            SizedBox(height: 10,)
          ],
        ),),
      )
    ],),));
  }
}