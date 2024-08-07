

import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/Models/Vehicle.dart';
import 'package:fp4/Others/MyFiles.dart';
import 'package:fp4/User.dart';

class CreateVehicle extends StatefulWidget {
  CreateVehicle({super.key});

  @override
  State<CreateVehicle> createState() => _CreateVehicleState();
}

class _CreateVehicleState extends State<CreateVehicle> {
  TextEditingController name=TextEditingController();

  TextEditingController number=TextEditingController();

  TextEditingController des=TextEditingController();
  Vehicle vehicle=Vehicle();

void createClicked()async
{

bool exists=await Vehicle.alreadyExists(vehicleNumber: number.text, schoolId: User.getDS().getDocId());

  if(exists)
  {
    ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.white,
                content: Text('Invalid Credentials',style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 3), // Duration for how long the Snackbar will be visible
              ),
            );
    return;
  }

  // Vehicle vehicle=Vehicle( schoolId: User.getDS().getDocId() ,vehicleNumber: number.text,
  //  name: name.text, description: des.text);
  vehicle.schoolId=User.getDS().getDocId();
  vehicle.vehicleNumber=number.text;
  vehicle.name=name.text;
   Vehicle.create(vehicle);

       ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.white,
                content: Text('Created Successfully',style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 3), // Duration for how long the Snackbar will be visible
              ),
            );
}

Future<void> addImage()async
{
await vehicle.autoDocId();
await pickAndUpload('${Model.VEHICLE}/${vehicle.getDocId()}/images');
}

Future<void> uploadDocs()async
{
  await vehicle.autoDocId();
  await pickAndUpload('${Model.VEHICLE}/${vehicle.getDocId()}/pdfs');

}



  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return Scaffold(body: Container(
      decoration: PageConstants.PAGEBACKGROUND,
      width: sw,child: 
      Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 30,),
        Container(width: sw*0.95,height: 200,padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        ),child: Stack(
          children: [
          Positioned(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center
           ,  children: [
            InputBox(width: 200, height:30,text: 'Vehicle Name',
            textEditingController: name,),
            // InputBox(width: 200, height: 30,text: 'Vehicle id',
            // textEditingController: id,),
            InputBox(width: 200, height: 30,text: 'Number',
            textEditingController: number,),
            InputBox(width: 200, height: 30,text: 'Description',
            textEditingController: des,)
           ],)),
          Align(alignment: Alignment.centerRight,
           child: Column( mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center, children: [
            IconButton(icon:Icon(Icons.add,size: 40,color: Colors.black,),onPressed: addImage,),
            Text('Add image',style: TextStyle(fontWeight: FontWeight.w900),)
           ],),)
        ]),),
      const  SizedBox(height: 40,),
      Container(width: 0.95*sw,height: 40,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
      child:
        InkWell(onTap: uploadDocs,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.add,size: 30,color: Colors.black,),
            Text('Upload Documents')
          ],),
        ),),
        SizedBox(height: 50,),
        InkWell(onTap: createClicked,child: Container(width: 100,height: 35,
        decoration: BoxDecoration(color: PageConstants.DARKGREEN,borderRadius: BorderRadius.circular(5)),
        child:Center(child:Text('Create',style: TextStyle(color: Colors.white),),))
        ,)
      ],),
    ));
  }
}