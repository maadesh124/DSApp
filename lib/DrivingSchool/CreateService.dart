
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/DocumentList.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Models/Examples.dart';
import 'package:fp4/Models/Instructor.dart';
import 'package:fp4/Models/Service.dart';
import 'package:fp4/Others/Functions.dart';
import 'package:fp4/User.dart';

class CreateService extends StatefulWidget {
  CreateService({super.key});

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  TextEditingController serviceController=TextEditingController();

  TextEditingController instructorIdController=TextEditingController();

  TextEditingController serviceFeeController=TextEditingController();

  TextEditingController descriptionController=TextEditingController();

  List<String> requiredDocuments=[];

  //String dsId='w42tQh0oLjlD0LsEGxPs';
void onSubmit() async
{

bool res1=await Instructor.alreadyExists(
  insId: instructorIdController.text, schoolId: User.getDS().getDocId());
bool res2=isNumber(serviceFeeController.text);
if(!(res1 && res2))
{
  ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.white,
                content: Text('Invalid Credentials',style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 3), // Duration for how long the Snackbar will be visible
              ),
            );
            return;
}


  Service service=Service(name: serviceController.text, 
  fee: double.parse(serviceFeeController.text),
   description: descriptionController.text, 
   instructorId: instructorIdController.text,
   requiredDocuments: requiredDocuments,
   schoolObjectId: User.getDS().getDocId(),
   schoolName: User.getDS().schoolName);

  await Service.createService(service); 
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.white,
                content: Text('Service created Successfully',style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 3), // Duration for how long the Snackbar will be visible
              ),
            );
}

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return 
    
     Scaffold(
       body: SingleChildScrollView(child:
       Container(decoration: PageConstants.PAGEBACKGROUND,
           child: Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 20,),
        Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
          width:0.95*screenWidth ,
        height: 230,
        child: Stack(children: [
          Positioned(top: 10,left: 0,right: 0, child:Center(child: Text("New Service",style:
           TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),),
       
          Positioned(left: 20,bottom: 20,  child:Form(child: Column( crossAxisAlignment: CrossAxisAlignment.start,  children: [
          InputBox(width: 150, height: 30, text: "Service Name",textEditingController: serviceController,
          ),
          InputBox(width: 150, height: 30, text: "Instructor id",textEditingController: instructorIdController,
         ),
          InputBox(width: 150, height: 30, text: "Service Fee",textEditingController: serviceFeeController,
          ),
          InputBox(width: 400, height: 30, text: "Service Description",textEditingController: descriptionController,),
          //InputBox(width: 400, height: 30, text: "")
        ],)),),
       
        Positioned(right: 40,top:50,  child:Align(alignment: Alignment.center, child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          Icon(Icons.add,size: 40,color: Colors.black,),
          Text("Add Image",style: TextStyle(fontWeight: FontWeight.w900),)
        ],)))
       
       
        ]),
        ),
       
        SizedBox(height: 30,),
        DocumentListWidget(docList: requiredDocuments,editable: true,onDocClicked: (_)=>null,),
        SizedBox(height: 40,),
       InkWell(onTap: onSubmit,
         splashColor: Colors.black,
         child: Container(
           decoration: BoxDecoration(
        color: PageConstants.DARKGREEN,
        borderRadius: BorderRadius.circular(5),
           ),
           width: 100,
           height: 40,
           child: Center(
        child: Text(
          "Create",
          style: TextStyle(color: Colors.white),
        ),
           ),
         ),
       ),SizedBox(height: 20,)
       
           ],),
           )),
     );
  }
}




