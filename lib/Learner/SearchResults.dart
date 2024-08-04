import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/Overviews.dart' as DS;
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Learner/OverViews.dart';
import 'package:fp3/Models/Course.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/Models/Service.dart';
import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/main.dart';

class SearchResultsView extends StatefulWidget {

List<String> schoolIds;
List<String> courseIds;
List<String> instructorIds;
List<String> serviceIds;
SearchResultsView({super.key,required this.instructorIds,required this.schoolIds,required this.courseIds,
required this.serviceIds});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  @override
  Widget build(BuildContext context) {
    final sh=MediaQuery.of(context).size.width;
    return Container(decoration: PageConstants.LEARNER_BG,
      child: Column(
        children: [SizedBox(height: 40,),
        CSearchBar(),
        SizedBox(height: 20,),
          DefaultTabController(length: 4, child: Expanded(
            child: Column(
              children: [
                TabBar(tabs: [Tab(child: Text('Driving Schools'),),
                Tab(child: Text('Courses'),),
                Tab(child: Text('Services'),),
                Tab(child: Text('Instructors'),),
                ],),
              
               Expanded( child: TabBarView(children: [
               SingleTab(ids: widget.schoolIds, type: Model.DRIVINGSCHOOL),
               SingleTab(ids:widget.courseIds, type: Model.COURSE),
               SingleTab(ids: widget.serviceIds, type: Model.SERVICE),
               SingleTab(ids:widget.instructorIds, type:Model.INSTRUCTOR)
               ]))
              ],
            ),
          )),
        ],
      ),
    );
  }
}


class SingleTab extends StatefulWidget {

  List<String> ids;
  String type;
  SingleTab({super.key,required this.ids,required this.type});

  @override
  State<SingleTab> createState() => _SingleTabState();
}

class _SingleTabState extends State<SingleTab> {
List<Model> models=[];
bool gotData=false;
Model generate(String type)
{
  switch (type) {
    case Model.COURSE:
     return Course(); 
    case Model.DRIVINGSCHOOL:
      return DrivingSchool();
    case Model.SERVICE:
      return Service();
    case Model.INSTRUCTOR:
      return Instructor();
    case Model.VEHICLE:
      return Vehicle();
    default:
      return Course();
  }
}

Widget getOverView({required dynamic model,required String type,})
{
  switch (type) {
    case Model.COURSE:
     return CourseOverView(course:model!,); 
    case Model.SERVICE:
      return ServiceOverview(service: model!,);
    case Model.INSTRUCTOR:
      return InstructorOverView(instructor: model!,);
    case Model.VEHICLE:
      return VehicleOverview(vehicle: model!,);
    case Model.DRIVINGSCHOOL:
      return DrivingSchoolOverView(drivingSchool: model!);
    default:
      return CourseOverView(course:model!,);
  }
}


Future<void> initialize()async
{
  models=List.generate(widget.ids.length, (index) => generate(widget.type));
  await Model.getAllModels(widget.ids,models);
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
    return 
     !gotData?Center(child: CircularProgressIndicator()):ListView.builder(itemCount:models.length ,
     itemBuilder: (context, index) {
      return Column(
        children: [
          SizedBox(height: 10,),
          getOverView(type: widget.type,model: models[index]),
          
        ],
      );
     },)
       ;
  }
}