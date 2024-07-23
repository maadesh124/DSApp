// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';

class CreateInstructor extends StatelessWidget {
  const CreateInstructor({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return Container(color: PageConstants.LIGHTGREEN,
    width: screenWidth,
    child: Center(child:
    Container(width:250 ,
    height:300 ,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: 20,), 
    Text("Create Instructor",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
    SizedBox(height: 20,),      
      
      Container(width:180,
    height: 30,
     child:TextField(cursorColor: Colors.black,
    // cursorHeight: 16,
  decoration: InputDecoration(
    hintText: 'Instructor id',
    hintStyle: TextStyle(fontSize: 16),
    contentPadding: EdgeInsets.symmetric(vertical: 10),
   
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    //cursorColor: Colors.black,
  ),
)
    ,),
    SizedBox(height: 10,), 
    Container(width:180,
    height: 30,
     child:TextField(cursorColor: Colors.black,
    // cursorHeight: 16,
  decoration: InputDecoration(
    hintText: 'Password',
    hintStyle: TextStyle(fontSize: 16),
    contentPadding: EdgeInsets.symmetric(vertical: 10),
   
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    //cursorColor: Colors.black,
  ),
)
    ),
    SizedBox(height: 10,), 
        Container(width:180,
    height: 30,
     child:TextField(cursorColor: Colors.black,
    // cursorHeight: 16,
  decoration: InputDecoration(
    hintText: 'Confirm Password',
    hintStyle: TextStyle(fontSize: 16),
    contentPadding: EdgeInsets.symmetric(vertical: 10),
   
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    //cursorColor: Colors.black,
  ),
)
    ),
    SizedBox(height: 50,), 
    Container(width: 100,height: 30,decoration: BoxDecoration(
      color: PageConstants.DARKGREEN,
      borderRadius: BorderRadius.circular(10)
    ),child:Center(child:Text("Create",style: TextStyle(color: Colors.white)),),)
    
    ],),))

    ,);
  }
}