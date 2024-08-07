
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fp4/Others/Location.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Location extends StatefulWidget {
//   // const Location({super.key});

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {

// String loc='not set';
// Future<void> getLocationPermission1()async
// {
//   if(Platform.isAndroid)
//   {

//      LocationPermission permission=   await Geolocator.requestPermission();
//     final address= await getcurrentLocation();
//     final pos=await Geolocator.getCurrentPosition();
//    final g= await FirebaseFirestore.instance.collection('Test').
//    doc('l2').set({'loca':GeoPoint(pos.latitude,pos.longitude)});
//      setState(() {
//        loc=address.toString();
//      });

//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Column(children: [
//       SizedBox(height: 100,),
//       TextButton(onPressed: getLocationPermission1, child: Text('get Permission')),
//       Text(loc)
//     ],),);
//   }
// }



