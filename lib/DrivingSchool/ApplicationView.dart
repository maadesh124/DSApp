
// import 'package:flutter/material.dart';
// import 'package:fp3/CustomWidgets/PageWidgets.dart';
// import 'package:fp3/Models/Application.dart';
// import 'package:fp3/Models/Learner.dart';

// class ApplicationView extends StatefulWidget {

//   Application application;
//  ApplicationView({required this.application,super.key});

//   @override
//   State<ApplicationView> createState() => _ApplicationViewState();
// }

// class _ApplicationViewState extends State<ApplicationView> {

// Learner? learner;
// bool gotData=false;

// Future<void> initialize()async
// {
// learner=await widget.application.getLearner();

//   setState(() {
//     gotData=true;
//   });
// }

// @override
// void initState()
// {
//   gotData=false;
//   initialize();
//   super.initState();

// }


// void rejectClicked()async
// {

// }


// void registerClicked()async
// {
//   widget.application.register();
// }

//   @override
//   Widget build(BuildContext context) {
//     final sw=MediaQuery.of(context).size.width;
//     return Scaffold(body: Container(
//       decoration: PageConstants.PAGEBACKGROUND,
//       child:Column(children: [
//         SizedBox(height: 40,),
//         Top(),
//         SizedBox(height: 20,),
//         CSearchBar(),
//         SizedBox(height: 20,),
//        !gotData?SizedBox(): Container(width: sw*0.95,padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
//         child: 
//         Column(crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           Align(alignment: Alignment.topCenter,  
//           child: Icon(Icons.person,color: PageConstants.LIGHTGREEN,size: 100,)),
//           Text('Name: ${widget.application.learnerName}'),
//           Text('Course Name: ${widget.application.courseName}'),
//           Text('Course Id: ${widget.application.courseId}'),
//           Text('Age: ${widget.application.learnerAge}'),
//           Text('Gender: ${widget.application.isMale?'Male':'Female'}'),
//           Text('Date Applied: ${widget.application.dateApplied}'),
//           Text('Application Nuber:${widget.application.applicationNumber}'),
//           Text('Email id: ${learner!.email}'),
//           Text('Mobile Number: ${learner!.mobileNumber}'),
//           Text('Date of Birth: ${learner!.mobileNumber}'),
//           SizedBox(height: 20,),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        
//                     InkWell(onTap: registerClicked, child: 
//             Container(padding: EdgeInsets.fromLTRB(10, 5, 10,5), child: Center(child: 
//             Text('Register',style: TextStyle(color: Colors.white),),),
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:PageConstants.DARKGREEN),),)
//           ],)

//         ],),)
//       ],) ,
//     ),);
//   }
// }