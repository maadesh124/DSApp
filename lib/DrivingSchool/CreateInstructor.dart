// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Instructor.dart';
import 'package:fp4/Others/Functions.dart';
import 'package:fp4/User.dart';

class CreateInstructor extends StatefulWidget {
 CreateInstructor({super.key});

  @override
  State<CreateInstructor> createState() => _CreateInstructorState();
}

class _CreateInstructorState extends State<CreateInstructor> {
  TextEditingController insIdCont=TextEditingController();

  TextEditingController pwdCont=TextEditingController();

  TextEditingController cnfPwdCont=TextEditingController();

  Future<void> createClicked()async
  {
    bool exists=await Instructor.alreadyExists(insId: insIdCont.text, schoolId: User.getDS().getDocId());
      if(pwdCont.text!=cnfPwdCont.text || exists || pwdCont.text.isEmpty)
      {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.white,
                content: Text('Invalid Credentials',style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 3), // Duration for how long the Snackbar will be visible
              ),
            );
      }
      else
      {
        Instructor.createInstructor(id: insIdCont.text, pwd: pwdCont.text);
                      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.white,
                content:  Text('Created Successfully',style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 3), // Duration for how long the Snackbar will be visible
              ),
            );
      }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(color: PageConstants.LIGHTGREEN,
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
       child:TextField( controller: insIdCont,  cursorColor: Colors.black,
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
       child:TextField( controller: pwdCont,  cursorColor: Colors.black,
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
       child:TextField(controller: cnfPwdCont,  cursorColor: Colors.black,
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
       InkWell(onTap: createClicked,  child:  Container(width: 100,height: 30,decoration: BoxDecoration(
        color: PageConstants.DARKGREEN,
        borderRadius: BorderRadius.circular(10)
      ),child:Center(child:Text("Create",style: TextStyle(color: Colors.white)),),))
      
      ],),))
      
      ,),
    );
  }
}