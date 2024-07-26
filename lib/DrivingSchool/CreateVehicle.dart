

import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Models/Vehicle.dart';
import 'package:fp3/User.dart';

class CreateVehicle extends StatelessWidget {
  CreateVehicle({super.key});

  TextEditingController name=TextEditingController();
  TextEditingController id=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController des=TextEditingController();

void createClicked()
{
  Vehicle vehicle=Vehicle( schoolId: User.docId ,vehicleNumber: number.text,
   name: name.text, vehicleId: id.text, description: des.text);
   Vehicle.create(vehicle);
}


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    return MaterialApp(home: Scaffold(body: Container(
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
            InputBox(width: 200, height: 30,text: 'Vehicle id',
            textEditingController: id,),
            InputBox(width: 200, height: 30,text: 'Number',
            textEditingController: number,),
            InputBox(width: 200, height: 30,text: 'Description',
            textEditingController: des,)
           ],)),
          const Align(alignment: Alignment.centerRight,
           child: Column( mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(Icons.add,size: 40,color: Colors.black,),
            Text('Add image',style: TextStyle(fontWeight: FontWeight.w900),)
           ],),)
        ]),),
      const  SizedBox(height: 40,),
      Container(width: 0.95*sw,height: 40,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
      child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.add,size: 30,color: Colors.black,),
          Text('Upload Documents')
        ],),),
        SizedBox(height: 50,),
        InkWell(onTap: createClicked,child: Container(width: 100,height: 35,
        decoration: BoxDecoration(color: PageConstants.DARKGREEN,borderRadius: BorderRadius.circular(5)),
        child:Center(child:Text('Create',style: TextStyle(color: Colors.white),),))
        ,)
      ],),
    )),);
  }
}