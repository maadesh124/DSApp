import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Instructor/OverView.dart';
import 'package:fp3/Models/Instructor.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/Models/Service.dart';

class AllServiceView extends StatefulWidget {
Instructor instructor;
  AllServiceView({super.key,required this.instructor});

  @override
  State<AllServiceView> createState() => _AllServiceViewState();
}

class _AllServiceViewState extends State<AllServiceView> {

  bool gotData=false;
  List<Service> services=[];

Future<void> initialize()async
{
  services=List.generate(widget.instructor.serviceIds.length, (index) => Service());
  await Model.getAllModels(widget.instructor.serviceIds,services);
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
    Container(decoration: PageConstants.INSTRUCTOR_BACKGROUND,child: 
    Column(children: [
      SizedBox(height: 40,),
      Top(),
      SizedBox(height: 20,),
      Container(width: sw*0.95, child: Text('Services you handle'),),
      !gotData?Center(child: CircularProgressIndicator(),):
       Container(width: sw*0.95,height: sh-120,child: 
      ListView.builder(itemCount: services.length,
      itemBuilder: (context, index) => ServiceOverview(service: services[index]),),)
    ],),),);
  }
}