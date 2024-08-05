
import 'package:flutter/material.dart';
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
    );

    print(progList);
    Course.create(course);
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
              InputBox(width: 150, height: 30,text: 'Instructor Id',textEditingController: insId,),
              InputBox(width: 150, height: 30,text: 'Vehicle Number',textEditingController: vehNum,),
              InputBox(width: 0.8*sw, height: 30,text: 'Course Description',textEditingController: des,),
            
          ],),)
        ]),),
        SizedBox(height: 20,),
        ProgressView(list: progList,editable: true,height: 150,),
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
      ],),)),
    );
  }


Future<bool> isValid()async
{
  String schoolId=User.getDS().getDocId();
  bool ans1= await Course.alreadyExists(courseId: id.text, dsObjectId: schoolId);
  bool ans2=await Instructor.alreadyExists(insId: insId.text, schoolId: schoolId);
  bool ans3=await Vehicle.alreadyExists(vehicleNumber: vehNum.text, schoolId: schoolId);
  bool ans4=isNumber(fee.text);
  bool ans5=isNumber(totalSeats.text);

  return (ans1&&ans2&&ans3&&ans4&&ans5);
  
}
}






class DaysOfWeekCheckboxes extends StatefulWidget {
  final List<String> days=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
List<String> controller=[];
  DaysOfWeekCheckboxes();

  List<String> getController()=>controller;

  @override
  _DaysOfWeekCheckboxesState createState() => _DaysOfWeekCheckboxesState();
}

class _DaysOfWeekCheckboxesState extends State<DaysOfWeekCheckboxes> {
  late Map<String, bool> _checkedDays;

  @override
  void initState() {
    super.initState();
    // Initialize all checkboxes as true
    _checkedDays = {for (var day in widget.days) day: true};
  }

  List<String> get _selectedDays {
    // return _checkedDays.entries.where((entry) => entry.value).map((entry) => entry.key).toList();
    return widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.days.map((day) {
          return CheckboxListTile(
            title: Text(day),
            value: _checkedDays[day],
            onChanged: (bool? value) {
              setState(() {
                _checkedDays[day] = value ?? false;
            widget.controller= _checkedDays.entries.where((entry) => entry.value).map((entry) => entry.key).toList();
              });
            },
          );
        }).toList(),
        ElevatedButton(
          onPressed: () {
            // Print the list of selected days to the console
            print('Selected Days: ${widget.controller}');
          },
          child: Text('Show Selected Days'),
        ),
      ],
    );
  }
}