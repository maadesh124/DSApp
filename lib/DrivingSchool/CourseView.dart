
import 'package:flutter/material.dart';
import 'package:fp3/Models/Application.dart';
import 'package:fp3/Models/Enquiry.dart';
import 'package:fp3/Models/Learner.dart';

class Forms extends StatefulWidget {

  List<String> applicationIds=[];
 List<String>  learnerIds=[];
List<String>  enquiryIds=[];
  Forms({super.key,required this.applicationIds,required this.enquiryIds,required this.learnerIds});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {

List<Application> applications=[];
List<Enquiry> enquiries=[];
List<Learner> learners=[];
int current=1;

@override
void initState()
{
  super.initState();


}

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}