
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/DocumentList.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Instructor.dart';
import 'package:fp4/Models/Vehicle.dart';
import 'package:fp4/Others/Functions.dart';
import 'package:fp4/User.dart';

class CreateCourse extends StatefulWidget {
  CreateCourse({super.key});

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  List<String> selectedDays=[];
  List<Progress> progList=[];
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<String> reqDOcs=[];
  TextEditingController name=TextEditingController();
  TextEditingController id=TextEditingController();
  TextEditingController duration=TextEditingController();
  TextEditingController fee=TextEditingController();
  TextEditingController totalSeats=TextEditingController();
  TextEditingController insId=TextEditingController();
  TextEditingController vehNum=TextEditingController();
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

    bool isVal=await isValid();
    if(!isVal)
    {
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.white,
                content:  Text('Invalid Credentials',style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 3), // Duration for how long the Snackbar will be visible
              ),
            );
      return;
    }




    DrivingSchool ds=User.getDS();
    Course course=Course(dsObjectId: User.getDS().getDocId(),
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
    vehicleNumber: vehNum.text,
    courseDescription: des.text,
    instructorId: insId.text,
    progress: progList,
    reqDOcs: reqDOcs
    );

  
   await Course.create(course,selectedDays);
         ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.white,
                content: Text('Created Successfully',style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 3), // Duration for how long the Snackbar will be visible
              ),
            );
  }


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SingleChildScrollView(child:Container(decoration: PageConstants.PAGEBACKGROUND,
      child: Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 20,),
        Container(width: 0.95*sw,height: 600,
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
              SizedBox(height: 30,),
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
              Row(
                children: [
                  Container(height: 300,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        InputBox(width: 150, height: 30,text: 'Course Duration',textEditingController: duration,),
                        Spacer(flex: 1,),
                        Spacer(flex: 1,),
                        InputBox(width: 150, height: 30,text: 'Course Fee',textEditingController: fee,),
                        Spacer(flex: 1,),
                        InputBox(width: 150, height: 30,text: 'Total Seats',textEditingController: totalSeats,),
                        Spacer(flex: 1,),
                        InputBox(width: 150, height: 30,text: 'Instructor Id',textEditingController: insId,),
                        Spacer(flex: 1,),
                        InputBox(width: 150, height: 30,text: 'Vehicle Number',textEditingController: vehNum,),
                        Spacer(flex: 1,),// SizedBox(height:100),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                 Container(width: 200,
                  child: DaySelectionWidget(onSelectedDaysChanged:(days)
                  {
                    selectedDays=days;
                    //print(selectedDays);
                  } ))
                ],
              ),
             
            InputBox(width: 0.8*sw, height: 30,text: 'Course Description',textEditingController: des,),
          ],),)
        ]),),
        SizedBox(height: 20,),
        ProgressView(list: progList,editable: true,height: 150,),
        SizedBox(height: 30,),
  
        // SizedBox(height: 30,),
        DocumentListWidget(docList:reqDOcs, editable:true, onDocClicked: (_)=>null),
        SizedBox(height: 30,),
        InkWell(onTap: onCreateClicked,child: Container(width: 70,height: 25,alignment: Alignment.center, 
          decoration: BoxDecoration(color: PageConstants.DARKGREEN,
        borderRadius: BorderRadius.circular(5),),child: Text(
          'Create',style: TextStyle(color: Colors.white),
        ),),),
        SizedBox(height: 30,)
      ],),)),
    );
  }


Future<bool> isValid()async
{
  String schoolId=User.getDS().getDocId();
  bool ans1=! await Course.alreadyExists(courseId: id.text, dsObjectId: schoolId);
  bool ans2=await Instructor.alreadyExists(insId: insId.text, schoolId: schoolId);
  bool ans3=await Vehicle.alreadyExists(vehicleNumber: vehNum.text, schoolId: schoolId);
  bool ans4=isNumber(fee.text);
  bool ans5=isNumber(totalSeats.text);

  return (ans1&&ans2&&ans3&&ans4&&ans5);
  
}
}






class DaySelectionWidget extends StatefulWidget {
  final List<String> days = const ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final ValueChanged<List<String>> onSelectedDaysChanged;

  const DaySelectionWidget({
    Key? key,
    required this.onSelectedDaysChanged,
  }) : super(key: key);

  @override
  _DaySelectionWidgetState createState() => _DaySelectionWidgetState();
}

class _DaySelectionWidgetState extends State<DaySelectionWidget> {
  late List<bool> _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = List.filled(widget.days.length, true);
  }

  List<String> get selectedDays =>
      widget.days.where((day) => _selectedDays[widget.days.indexOf(day)]).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.days.asMap().entries.map((entry) {
        final index = entry.key;
        final day = entry.value;
        return CheckboxListTile(
          visualDensity: VisualDensity(vertical: -4),
          title: Text(day),
          value: _selectedDays[index],
          onChanged: (value) {
            setState(() {
              _selectedDays[index] = value!;
              widget.onSelectedDaysChanged(selectedDays);
            });
          },
        );
      }).toList(),
    );
  }
}