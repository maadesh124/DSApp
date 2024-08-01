import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/Overviews.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/CourseView.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';




class InstructorView extends StatefulWidget {
  
  Instructor instructor;
  InstructorView({super.key,required this.instructor});

  @override
  State<InstructorView> createState() => _InstructorViewState();
}

class _InstructorViewState extends State<InstructorView> {


List<Course> courses=[];
bool gotData=false;
  Future<void> initialize()async
  {
courses=List.generate(widget.instructor.courseIds.length,(_)=>Course());
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


Course? getCourse(String docId)
{
  print('docId is $docId');
  print(widget.instructor.courseIds);
 int index= widget.instructor.courseIds.indexOf(docId);
  print(index);
 if(index==-1)
 return null;
 if(gotData)
 return courses[index];
}




  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(child: 
      Container(decoration: PageConstants.PAGEBACKGROUND,child: Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 20,),
      Container( padding: EdgeInsets.all(10), width:0.95*sw ,decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(10)),child: Stack(children: [
        Align(alignment: Alignment.topRight,child:
         Icon(Icons.person,color:PageConstants.LIGHTGREEN,size: 120,),),
        Positioned(right: 10,top: 120,  child:Column(children: [ CircularPercentIndicator(radius: 45,
        percent: 0.95,progressColor: PageConstants.DARKGREEN,
        center: Text('95%',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),lineWidth: 7.5,),
        Text('Attendance',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)
        ])),
        Align(alignment: Alignment.topLeft,child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(widget.instructor.name),
          Text(widget.instructor.insId),
          Text(widget.instructor.mobileNumber),
          Text(widget.instructor.email),
          //Text(widget.instructor.address),
          Text(widget.instructor.joinDate.toString()),
          Text(widget.instructor.salary.toString()),
          Text(widget.instructor.dob.toString()),
          Text(widget.instructor.courseIds.length.toString()+' courses handling'),
          Text(widget.instructor.gender),
          Text(widget.instructor.specialization),
          SizedBox(height: 40,),    
                 ],),)
      ],),),
      SizedBox(height: 20,),
      TimeTable(timeTable: widget.instructor.timeTable,getC: getCourse,),
      SizedBox(height: 20,),
      Container(width: sw*0.95,height: 25,child: 
      Text('Courses Handling',style: TextStyle(fontWeight: FontWeight.w600),),),
         gotData? Container(width: sw*0.95,height: 250,child: 
      ListView.builder(itemCount: courses.length,itemBuilder:(context, index) {
        return Column(children: [
          CourseOverview(course: courses[index]),
          SizedBox(height: 10,)
        ],);
      },),):CircularProgressIndicator()
      ],),),),
    );
  }
}






class TimeTable extends StatefulWidget {

  Map<String,Map<String,String>> timeTable;
 static const List<String> days=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
 Function getC;
  TimeTable({super.key,required this.timeTable,required this.getC});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {

int current=2;
List<Widget> l=[];
Map<String,Map<TimeOfDay,String>> tt={};
void initState()
{
  
  for(int i=0;i<7;i++)
  l.add(getDay(i));
  super.initState();
  widget.timeTable.forEach((key, value) {
    tt[key]=sortTimeOfDayMap(toTime(widget.timeTable[key]!));
  });
  
}

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    Map<TimeOfDay,String> today=tt[TimeTable.days[current]]??{};
    List<TimeOfDay> keys=today.keys.toList();
    print('tod k len '+keys.length.toString());
    return Column(children: [
      Container(width: sw*0.95,height: 50,//color: Colors.red,
    child: ListView.builder(itemCount: 7,
    scrollDirection: Axis.horizontal,
      itemBuilder: (_,i)=>getDay(i)),),
      SizedBox(height: 10,),
     Container(width: 0.95*sw,height: today.length*55,child:  ListView.builder(itemCount: today.length,itemBuilder: (context, index) {
        print('${keys[index]}:${today[keys[index]]!}');
       return getOne(formatTimeOfDay(keys[index]), today[keys[index]]!);
      },),)
    ],);
  }

Widget getDay(int index)
{
  double height=40;
  Color color=current==index?Colors.white:Color.fromARGB(255, 207, 207,207);
  String char=TimeTable.days[index][0];


  return Row(children: [InkWell(onTap: ()
  {
    setState(() {
      current=index;
    });
  },
    child:Container(width: height,height: height,decoration: BoxDecoration(
    color: color,borderRadius: BorderRadius.circular(height/2)
  ),child:Center(child:Text(char,
  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),)),SizedBox(width: 30,)]);

}



Widget getOne(String key,String val)
{
 
  final sw=MediaQuery.of(context).size.width;
  return  InkWell(onTap: () async{
 final course= widget.getC(val.split('|')[1].trim());
 Navigator.push(context,
MaterialPageRoute(builder: (context) =>CourseView(course:course! )),);

  },
    child: Container(height: 55,width: sw*0.95,child: 
    Column(children: [
      Container(width:sw*0.95 ,height: 50,padding: EdgeInsets.fromLTRB(20,0,10,0), decoration: 
    BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),child:
     Stack(children: [ Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(val,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
    Text(key,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16))],),
    Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward_ios_rounded),)])),
    SizedBox(height: 0,),
    ],),),
  );
}

}


Map<TimeOfDay,String> toTime(Map<String,String> map)
{
  Map<TimeOfDay, String> m1 = {};
  map.forEach((key, val) {
    String st=key.split('-')[0];
    int h=int.parse(st.split(':')[0]);
    int m=int.parse(st.split(':')[1]);
    TimeOfDay t = TimeOfDay(hour:h,minute:m);
    print('h');

    m1[t] = val;
  });
  return m1;
}

Map<TimeOfDay, String> sortTimeOfDayMap(Map<TimeOfDay, String> timeMap) {
  // Convert the map entries to a list
  List<MapEntry<TimeOfDay, String>> entries = timeMap.entries.toList();

  // Sort the list based on the TimeOfDay keys
  entries.sort((a, b) {
    int hourComparison = a.key.hour.compareTo(b.key.hour);
    if (hourComparison != 0) {
      return hourComparison;
    } else {
      return a.key.minute.compareTo(b.key.minute);
    }
  });

  // Create a new map from the sorted entries
  return Map<TimeOfDay, String>.fromEntries(entries);
}