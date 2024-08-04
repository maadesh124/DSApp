
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/InstructorView.dart';
import 'package:fp3/Instructor/CourseOverViews.dart';
import 'package:fp3/Instructor/CourseViewIns.dart';
import 'package:fp3/Instructor/ServiceOverViews.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/User.dart';

class InsHome extends StatefulWidget {
  const InsHome({super.key});

  @override
  State<InsHome> createState() => _InsHomeState();
}

class _InsHomeState extends State<InsHome> {

Instructor instructor=Instructor();
List<Course> courses=[];
bool gotData=false;

  void goToCourseListView(){
            Navigator.push(context,
MaterialPageRoute(builder: (context) =>AllCourseView(instructor: instructor)),);
  }
  void goToServiceListView()
  {
            Navigator.push(context,
MaterialPageRoute(builder: (context) =>AllServiceView(instructor: instructor)),);
  }

void getCourse(String docId)
{

 Course? course;//= widget.getC(val.split('|')[1].trim());
  print('docId is $docId');
  print(instructor.courseIds);
 int index= instructor.courseIds.indexOf(docId);
  print(index);
 if(index==-1)
 course= null;
 if(gotData)
 course= courses[index];

  Navigator.push(context,
MaterialPageRoute(builder: (context) =>CourseViewIns(course:course! )),);
}


void initialize()async
{
  instructor=User.getIns();
  courses=List.generate(instructor.courseIds.length, (index) => Course());
  await Model.getAllModels(instructor.courseIds,courses);
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
    return Scaffold(body: Container(
      decoration: PageConstants.INSTRUCTOR_BACKGROUND,
      child: Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 20,),
        CSearchBar(),
        SizedBox(height: 20,),
        InkWell(onTap: goToCourseListView,
          child: Container(width: sw*0.95,height: 40,padding: EdgeInsets.all(10),decoration: 
          BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
          child: Stack(children: [
            Center(child: Text('Couses You handle',style: TextStyle(fontWeight: FontWeight.w600),),),
            Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward_ios_rounded),)
          ],),),
        ),
        SizedBox(height: 10,),
        InkWell(onTap: goToServiceListView,
          child: Container(width: sw*0.95,height: 40,padding: EdgeInsets.all(10),decoration: 
          BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
          child: Stack(children: [
            Center(child: Text('Services You handle',style: TextStyle(fontWeight: FontWeight.w600),),),
            Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward_ios_rounded),)
          ],),),
        ),
        SizedBox(height: 20,),
        TimeTable(timeTable: instructor.timeTable, getC: getCourse)
      ],),
    ),);
  }
}