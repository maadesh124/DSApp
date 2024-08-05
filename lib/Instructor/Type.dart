// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Type extends StatefulWidget
{
   Type({Key? key}) : super(key: key);

  @override
  State<Type> createState() => _TypeState();
}

class _TypeState extends State<Type>
{

  @override
  Widget build(BuildContext context)
  {
    return  Container(decoration:BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter,end: Alignment.topCenter,  
    colors:const <Color>[Color.fromRGBO(248, 222, 24, 0.612),Colors.white]))
    ,child: Center(child: Column(
     mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
      SizedBox(height: 50,),
      Text("Are you?!!!",textDirection: TextDirection.ltr,style: 
      TextStyle(color: Color.fromARGB(255, 255, 200, 1),fontSize: 25),)
      ,SizedBox(height: 150,),
      Container(width: 120,  padding: EdgeInsets.all(7.0),
      decoration:BoxDecoration(
        color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(7)),
        border: Border.all(width: 1,color: Colors.black)), // Adjust padding as needed
   // Background color
  child: Text(textAlign: TextAlign.center,
    'Learner',textDirection: TextDirection.ltr,
    style: TextStyle(fontSize: 16, color: Colors.black,), // Text color
  ),
),SizedBox(height: 30.0),
      Container(width: 120, padding: EdgeInsets.all(7.0),
      decoration:BoxDecoration(color: Color.fromARGB(255, 255, 200, 1),
      borderRadius: BorderRadius.all(Radius.circular(7))), // Adjust padding as needed
   // Background color
  child: Text(textAlign: TextAlign.center,
    'Instructor',textDirection: TextDirection.ltr,
    style: TextStyle(fontSize: 16, color: Colors.white), // Text color
  ),
),SizedBox(height: 30.0),
Container(width: 120, padding: EdgeInsets.all(7.0),
      decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(7)),
      border: Border.all(width: 1,color: Colors.black)), // Adjust padding as needed
   // Background color
  child: Text(textAlign: TextAlign.center,
    'Driving School',textDirection: TextDirection.ltr,
    style: TextStyle(fontSize: 16, color: Colors.black), // Text color
  ),
),SizedBox(height: 100,),
  Container(padding: EdgeInsets.all(8),width: 200, alignment: Alignment.center,
  decoration: BoxDecoration(color: Color.fromARGB(255, 255, 200, 1),
  borderRadius: BorderRadius.all(Radius.circular(10))),
  child:Text("Get Started",textDirection: TextDirection.ltr,
  style: TextStyle(color: Colors.white,fontSize: 18,),))
     ])),
    );
  }
}

//Color.fromRGBO(207, 195, 84, 0.612)