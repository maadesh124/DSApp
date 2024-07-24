// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Examples.dart';
import 'package:fp3/Models/Service.dart';
import 'package:fp3/User.dart';

class CreateService extends StatelessWidget {
  CreateService({super.key});
  TextEditingController serviceController=TextEditingController();
  TextEditingController instructorIdController=TextEditingController();
  TextEditingController serviceFeeController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  List<String> requiredDocuments=[];
  String dsId='w42tQh0oLjlD0LsEGxPs';

String? validateName(dynamic st)=> (st==null || st.isEmpty)? 'Enter a valid Service Name':null;

String? validateInsId(dynamic insId)=>
User.currentSchool.serviceIds.contains(insId)? null:'Invalid Id';

bool isNumeric(String str) {
  final numericRegex = RegExp(r'^[0-9]+$');
  return numericRegex.hasMatch(str);
}
String? validateFee(dynamic fee)=>(isNumeric(fee??'a'))?null:'Enter only digits';





void onSubmit() async
{

  Service service=Service(name: serviceController.text, 
  fee: double.parse(serviceFeeController.text),
   description: descriptionController.text, 
   instructorId: instructorIdController.text, requiredDocuments: requiredDocuments);

   await service.setIds();
   print(service.toMap());
   final doc= await FirebaseFirestore.instance.collection(DataBase.SERVICE_COLLECTION).add(service.toMap());
   final dsref=FirebaseFirestore.instance.collection(DataBase.DRIVINGSCHOOL_COLLECTION).doc(dsId);
   await dsref.get().then((snap)
   {
     DrivingSchool ds= DrivingSchool.fromMap(snap.data()!);
     ds.serviceIds.add(doc.id);
     dsref.set(ds.toMap());
   });

   print(User.currentSchool.toMap());

    
}


  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return 
    
     SingleChildScrollView(child:
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
        validator: validateName,),
        InputBox(width: 150, height: 30, text: "Instructor id",textEditingController: instructorIdController,
        validator: validateInsId,),
        InputBox(width: 150, height: 30, text: "Service Fee",textEditingController: serviceFeeController,
        validator: validateFee,),
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
      DocumentList(reqDocs: requiredDocuments,),
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
)

    ],),
    ));
  }
}






class DocumentList extends StatefulWidget {

  List<String> reqDocs;
  DocumentList({super.key,required this.reqDocs});

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {

  List<Document> documentList=[];
  TextEditingController textEditingController=TextEditingController();

   void onPressed() async
  {
    await Future.delayed(Duration(milliseconds: 100));
    showDialog(context: context, builder: (context) 
    {
      return AlertDialog(title: Text("Add Document"),content: InputBox(height: 30,width: 70,
      text: "Enter Document Name",
      textEditingController: textEditingController,)
      ,actions: [
        InkWell(splashColor: PageConstants.BLACK20,  onTap: ()
        {
          Navigator.of(context).pop();
        }, 
        child: Text("CANCEL",style: TextStyle(color: Colors.black),)),
      
        SizedBox(width: 10,),
        InkWell(
          onTap: ()
      {
        widget.reqDocs.add(textEditingController.text);
        print(widget.reqDocs);
        setState(() {
          documentList.add(Document(name: textEditingController.text));
          
        });
        textEditingController.clear();
        Navigator.of(context).pop();

      }, child: Text("OK",style: TextStyle(color: Colors.black),))],);
    } );
    
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(width: 0.95*screenWidth,
    height: 70+documentList.length*35,
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
    child: Column( crossAxisAlignment: CrossAxisAlignment.center, children: [

      Align(alignment:Alignment.topLeft ,child:Row(children: [SizedBox(width: 0.025*screenWidth,),
      Text("Required Documents")],)),
      SizedBox(height: 10,),
      Container( height: 35.0*documentList.length, width: screenWidth*0.9, 
      child: ListView.builder(physics: NeverScrollableScrollPhysics(), itemCount: documentList.length,
      itemBuilder: (context, index) => documentList[index],)),
      InkWell(splashColor: PageConstants.BLACK50,        onTap: onPressed, child: Container(width: screenWidth*0.9,height: 25,
       decoration: BoxDecoration(borderRadius: 
      BorderRadius.circular(5),color: PageConstants.BLACK20),
      
       child:Row(mainAxisAlignment: MainAxisAlignment.center,  children: [Icon(Icons.add,size: 20,color: Colors.black,),
      Text("Add Docuent")],),))
    ]),

    );
  }
}

class Document extends StatelessWidget {
  String name;
   Document({super.key,required this.name});
 
  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(width: 0.95*screenWidth,height: 35,color: Colors.white,
    child: Column(crossAxisAlignment: CrossAxisAlignment.center,  children: [
      Container(width: 0.9*screenWidth,height: 28,
      decoration: BoxDecoration(color: PageConstants.BLACK20,
      borderRadius: BorderRadius.circular(5)),
      child:Center(child: Text(name)),)
      ,SizedBox(height: 7,)
    ],),);
  }
}