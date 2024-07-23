//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Models/CourseAttendance.dart';

/*
CourseAttendanceView displays attendance of particular course on particular date
example:CourseAttendanceView(courseAttendance:Examples.COURSEATTENDANCE,date:"23|07|24",editable:"true")
this courseAttendance object id is a attrbute of Course class.
CourseAttendance object contains attendance of that course till today's date.
if editable is set true then viewer can edit Attendance,
See Examples.COURSEATTENDANCE for more details.
*/



class CourseAttendanceView extends StatelessWidget {

  String date;
  bool editable;
  CourseAttendance courseAttendance;
  CourseAttendanceView({super.key,required this.courseAttendance,required this.date,required this.editable});


  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(decoration: PageConstants.PAGEBACKGROUND,
    width:screenWidth ,
    child:Column(children: <Widget>[   
      SizedBox(height: 20,),
      Top(),
      SizedBox(height: 20,),
      CSearchBar(),
      SizedBox(height: 20,),
      ClipRRect(borderRadius: BorderRadius.circular(5),
        child: Column(children: [
        Container(width: 0.95*screenWidth,
        height: 40,color: PageConstants.DARKGREEN,
        child: Column(mainAxisAlignment: MainAxisAlignment.center ,children: [Text(date,
        style: TextStyle(color: Colors.white,fontSize: 14),),
        Text("${courseAttendance.courseName} | ${courseAttendance.courseId}",
        style: TextStyle(color: Colors.white,fontSize: 14))]),
        ),
        Container(
        width: 0.95 * screenWidth,
        height: 10, 
        color: Colors.white, 
      ),
        AttendanceView(singleDayAttendance: courseAttendance.attendance?['24|07|24'],editable: editable,),
        
        
      ]),)
      

    ]) ,
    );
  }
}





class AttendanceView extends StatelessWidget {

  bool editable;
  Map<String,bool>? singleDayAttendance;
  List<SingleAttendance> attendance=[];

  AttendanceView({required this.singleDayAttendance,required this.editable}) 
  {
    attendance= singleDayAttendance!.entries.map((entry) => SingleAttendance(
      defVal:entry.value, id:entry.key.split(',')[0], name:entry.key.split(',')[1], editable:this.editable)).toList();
  }
 

  @override
  Widget build(BuildContext context) {

    double screenWidth=MediaQuery.of(context).size.width;
    return Container(width: 0.95*screenWidth,
    color: Colors.white,
    height: attendance.length*45,
    child: ListView.builder(itemCount: attendance.length,itemBuilder: (context, index) => 
    Column(children:<Widget> [attendance[index],SizedBox(height: 10,),],),),
    );
  }
}


class SingleAttendance extends StatefulWidget
{
    bool editable;
    bool defVal;
    final String id;
    final String name;

    SingleAttendance({Key? key,required this.defVal,required this.id,
    required this.name,required this.editable}) : super(key: key);


    @override
    State<SingleAttendance> createState() =>_SingleAttendanceState();
}

class _SingleAttendanceState extends State<SingleAttendance>
{

  bool? present;
  Color bgColor=PageConstants.LIGHTGREEN;
  


    @override
    void initState() {
    super.initState();
    present=widget.defVal;
    bgColor=PageConstants.BLACK20;
    if(present==true)
    bgColor=PageConstants.LIGHTGREEN;
  }

  void onChanged(bool? value)
  {
    setState(() {
      this.present=value;
      bgColor = present == true ? PageConstants.LIGHTGREEN : PageConstants.BLACK20;
    });
  }


    @override 
    Widget build(BuildContext context)
    {
      double screenWidth=MediaQuery.of(context).size.width;

      return Container( width:0.95*screenWidth,height: 35,
      child:Stack(children: <Widget>[
        Positioned(left: 10,
          child:Container(width: 0.75*screenWidth,height: 35,
          decoration: BoxDecoration(color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(5)) ),
          child:Stack(children: <Widget>[
            Positioned(left: 10,top: 0,bottom: 0, child:Align(alignment: Alignment.center,
              child:Text(widget.name+" | "+widget.id,
            style: TextStyle(color: Colors.black,fontSize: 16,),))),

            Positioned(top: 0,bottom: 0, right: 8.5,child: Align(alignment: Alignment.center,
            child: Icon(Icons.arrow_forward_ios_rounded,size: 20,)
            ,),)

          ],),
          )),


        Positioned(right: 10,
          child: Checkbox(value: present, onChanged:widget.editable?onChanged:null,
          activeColor: PageConstants.LIGHTGREEN,))
      ],)
      
       );
    }
}