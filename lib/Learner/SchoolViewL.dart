import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Learner/Enquiry.dart';
import 'package:fp4/Learner/SchoolTabs.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Enquiry.dart';
import 'package:fp4/Models/Instructor.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/User.dart';

class SchoolViewL extends StatefulWidget {
  DrivingSchool drivingSchool;
  SchoolViewL({super.key,required this.drivingSchool});

  @override
  State<SchoolViewL> createState() => _SchoolViewLState();
}

class _SchoolViewLState extends State<SchoolViewL> {


Future<void> enquiryClicked()async
{
Navigator.push(context,
MaterialPageRoute(builder: (context) =>EnquiryViewLearner(ds: widget.drivingSchool, learner: User.getLearner())),);
}


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(decoration: PageConstants.LEARNER_BG,height: 800,
        child: 
        Column(children: [
          SizedBox(height: 40,),
          CSearchBar(),
          SizedBox(height: 20,),
          Container(width: sw*0.95,
            child: Row(children: [
              Text(widget.drivingSchool.schoolName,style: 
              TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
              Spacer(flex: 1,),
              RatingWidget(rating: 4.5, size: 20)],),
          ),
          Container(width:0.95*sw ,padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Align(alignment: Alignment.topCenter, child: Image.asset('assets/images/img.png')),
            Text(widget.drivingSchool.mobileNumber.toString()),
            Text(widget.drivingSchool.email),
            Text(widget.drivingSchool.location),
            Text(widget.drivingSchool.description),
            Align(alignment: Alignment.bottomCenter,child: 
            ElevatedButton(onPressed:enquiryClicked , child:Text('enquire') ),)
          ],),),
          SizedBox(height: 20,),
          DefaultTabController(length: 5, child: Expanded(
              child: Column(
                children: [
                  TabBar(tabs: [Tab(child: Text('Courses'),),
                  Tab(child: Text('Services'),),
                  Tab(child: Text('Instructors'),),
                  Tab(child: Text('Vehicles'),),
                  Tab(child: Text('Reviews'),)
                  
                  ],),
                  
                
                 Expanded(
                   child: TabBarView(children: [
                   SingleTab(ids: widget.drivingSchool.courseIds, type: Model.COURSE),
                   SingleTab(ids: widget.drivingSchool.serviceIds, type: Model.SERVICE),
                   SingleTab(ids: widget.drivingSchool.instructorIds, type: Model.INSTRUCTOR),
                   SingleTab(ids: widget.drivingSchool.vehicleIds, type:Model.VEHICLE),
                   ReviewWidget(reviewId: widget.drivingSchool.reviewId,)
                   ]),
                 )
                ],
              ),
            )),
        ],),),
      ),
    );
  }


}