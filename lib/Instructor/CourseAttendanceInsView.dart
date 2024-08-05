//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/CourseAttendance.dart';
import 'package:fp4/Models/Learner.dart';
import 'package:fp4/Models/Model.dart';

class CourseAttendanceView extends StatefulWidget {

  bool editable;
  CourseAttendance courseAttendance=CourseAttendance();
  Course course;
  
  CourseAttendanceView({super.key,required this.course,required this.editable});

  @override
  State<CourseAttendanceView> createState() => _CourseAttendanceViewState();
}

class _CourseAttendanceViewState extends State<CourseAttendanceView> {

bool gotData=false;
DateTime date=DateTime.now();
List<Learner> learners=[];
bool gotLearnes=false;
List<SingleAttendance> oneDayAttendance=[];
Future<DateTime?> pickDate() async
 {
final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate:  DateTime(2000),
      lastDate: DateTime(2100),
    );
    setState(() {
      date=picked!;
    });
   await initialize();
    
 }

Future<void> initialize()async
{
  if(!gotLearnes){
 widget.courseAttendance=await widget.course.getAttendance();
 learners=List.generate(widget.course.learnerObjectIds.length, (index) => Learner());
 await Model.getAllModels(widget.course.learnerObjectIds,learners);
 gotLearnes=true;
  }


 oneDayAttendance=widget.courseAttendance.attendance[formatDateTime(date)]??[];
setState(() {
 
  oneDayAttendance=oneDayAttendance.length==learners.length?
widget.courseAttendance.attendance[formatDateTime(date)]!:List.generate(learners.length,
 (index) => SingleAttendance(
  id: learners[index].getDocId(),name: learners[index].name,status: false
));
oneDayAttendance.forEach((element) {print(element.toMap());});
});

print('initialize completed');
}

 void initState()
 {
  initialize();
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    bool hasData=oneDayAttendance.isNotEmpty;
    final double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(decoration: PageConstants.INSTRUCTOR_BACKGROUND,
      width:screenWidth ,
      child:Column(children: <Widget>[   
        SizedBox(height: 20,),
        Top(),
        SizedBox(height: 20,),
        CSearchBar(),
        SizedBox(height: 20,),
        ClipRRect(borderRadius: BorderRadius.circular(5),
          child: 
              Column(children: [
              Container(width: 0.95*screenWidth,
              height: 40,color: const Color.fromARGB(255, 199, 119, 0),
              child: Stack(
                children: [
                  Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center ,children: [Text(formatDateTime(date),
                    style: TextStyle(color: Colors.white,fontSize: 14),),
                    Text("${widget.courseAttendance.courseName} ",
                    style: TextStyle(color: Colors.white,fontSize: 14))]),
                  ),
                  Align(alignment: Alignment.centerRight,  
                  child: IconButton(onPressed: pickDate, icon: Icon(Icons.calendar_month_rounded,color: Colors.white,)))
                ],
              ),
              ),
              Container(
              width: 0.95 * screenWidth,
              height: 10, 
              color: Colors.white, 
                    ),
           hasData? AttendanceView(attlist: oneDayAttendance,
             editable: true):CircularProgressIndicator(),

             SizedBox(height: 20,),
               InkWell(onTap: ()
        {
            oneDayAttendance.forEach((element) {print(element.toMap());});
            widget.courseAttendance.attendance[formatDateTime(date)]=oneDayAttendance;
            widget.courseAttendance.setToDB();
        }, child:Container(child: Text('Submit',style: TextStyle(color: Colors.white),),
        padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: PageConstants.INS_DARK,borderRadius:
           BorderRadius.circular(10)),)),
              
                    ]),
             )
        
      
      ]) ,
      ),
    );
  }
}



class AttendanceView extends StatefulWidget {

  bool editable;
  List<SingleAttendance> attlist=[];

  AttendanceView({required this.attlist,required this.editable})
  {
    print(attlist.length);
  }

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  List<SingleAttendanceView> attendance=[];


void initState()
{
super.initState();

}

  @override
  Widget build(BuildContext context) {
    attendance=List.generate(widget.attlist.length, (index) => SingleAttendanceView(
  singleAttendance: widget.attlist[index]
  , editable: widget.editable));
    print('attlist${widget.attlist.first.toMap()}');
  print('atten${attendance.first.singleAttendance.toMap()}');
//print('Attendance built${widget.attlist.first.toMap()}');
    double screenWidth=MediaQuery.of(context).size.width;
    return Container(width: 0.95*screenWidth,
    color: Colors.white,
    height: attendance.length*45,
    child: ListView.builder(itemCount: attendance.length,itemBuilder: (context, index) => 
    Column(children:<Widget> [attendance[index],SizedBox(height: 10,),],),),
    );
  }
}



class SingleAttendanceView extends StatefulWidget
{
    bool editable;
    SingleAttendance singleAttendance;

    SingleAttendanceView({Key? key,required this.singleAttendance,required this.editable}) : super(key: key);


    @override
    State<SingleAttendanceView> createState() =>_SingleAttendanceViewState();
}

class _SingleAttendanceViewState extends State<SingleAttendanceView>
{

  bool? present;
  Color bgColor=PageConstants.INSCOLOR;
  


    @override
    void initState() {
    super.initState();


  }

  void onChanged(bool? value)
  {
    setState(() {
      this.present=value;
      widget.singleAttendance.status=value!;
      bgColor = present == true ? PageConstants.INSCOLOR : PageConstants.BLACK20;
    });
  }


    @override 
    Widget build(BuildContext context)
    {
      double screenWidth=MediaQuery.of(context).size.width;
    present=widget.singleAttendance.status;
    bgColor=PageConstants.BLACK20;
    if(present==true)
    bgColor=PageConstants.INSCOLOR;
      return Container( width:0.95*screenWidth,height: 35,
      child:Stack(children: <Widget>[
        Positioned(left: 10,
          child:Container(width: 0.75*screenWidth,height: 35,
          decoration: BoxDecoration(color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(5)) ),
          child:Stack(children: <Widget>[
            Positioned(left: 10,top: 0,bottom: 0, child:Align(alignment: Alignment.center,
              child:Text(widget.singleAttendance.name+" | "+widget.singleAttendance.id,
            style: TextStyle(color: Colors.black,fontSize: 16,),))),

            Positioned(top: 0,bottom: 0, right: 8.5,child: Align(alignment: Alignment.center,
            child: Icon(Icons.arrow_forward_ios_rounded,size: 20,)
            ,),)

          ],),
          )),


        Positioned(right: 10,
          child: Checkbox(value: present, onChanged:widget.editable?onChanged:null,
          activeColor: PageConstants.INSCOLOR,))
      ],)
      
       );
    }
}

String formatDateTime(DateTime dateTime)
{
  return '${dateTime.day}|${dateTime.month}|${dateTime.year}';
}