

import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/Overviews.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/DrivingSchool/CreateService.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/Models/Service.dart';

class ServiceView extends StatefulWidget {

  Service service;
 ServiceView({super.key,required this.service});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {

List<Learner> learners=[];
bool gotData=false;

Future<void> initialize()async
{
  learners=List.generate(widget.service.studentObjectIds.length,(_)=>Learner());
  await Model.getAllModels(widget.service.studentObjectIds,learners);
  
  setState(() {
    gotData=true;
  });

}

void initState()
{
  initialize();
  super.initState();
}



  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    final sh=MediaQuery.of(context).size.height;

    print(gotData);
    return Scaffold(body: 
    SingleChildScrollView(
      child: Container(width: sw,decoration: PageConstants.INSTRUCTOR_BACKGROUND,
      child: Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 20,),
        Container(width: sw*0.95,padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,borderRadius: BorderRadius.circular(10)
        ),child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.service.name),
          Text(widget.service.fee.toString()),
          Text(widget.service.description)
        ],),),
        SizedBox(height: 20,),
       // Text(widget.service.requiredDocuments.toString()),
        DocumentList(reqDocs: widget.service.requiredDocuments,editable: false,),
        SizedBox(height: 20,),
        Container(width: sw*0.95,height: 25
        , child: Text('Registered Students')),
        !gotData?Center(child: CircularProgressIndicator(),):
        Container(width: sw*0.95,height: 250,
          child: ListView.builder(itemCount: learners.length,itemBuilder: (context, index) =>
           LearnerOverview(learner: learners[index]),),
        )
      
      
      ],),),
    ),);
  }
}




class DocumentList extends StatefulWidget {

  List<String> reqDocs;
  bool editable;
  DocumentList({super.key,required this.reqDocs,this.editable=false});

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {

  List<Document> documentList=[];
  TextEditingController textEditingController=TextEditingController();



  @override
  void initState()
  {
    documentList=List.generate(widget.reqDocs.length, (index) => Document(name: widget.reqDocs[index]));
    super.initState();
  }


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
    return
       Container(width: 0.95*screenWidth,
        height: 70+documentList.length*35,
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
        child: Column( crossAxisAlignment: CrossAxisAlignment.center, children: [
        
          Align(alignment:Alignment.topLeft ,child:Row(children: [SizedBox(width: 0.025*screenWidth,),
          Text("Required Documents")],)),
          SizedBox(height: 10,),
          Container( height: 35.0*documentList.length, width: screenWidth*0.9, 
          child: ListView.builder(physics: NeverScrollableScrollPhysics(), itemCount: documentList.length,
          itemBuilder: (context, index) => documentList[index],)),
         widget.editable?  InkWell(splashColor: PageConstants.BLACK50,        onTap: onPressed, child: Container(width: screenWidth*0.9,height: 25,
           decoration: BoxDecoration(borderRadius: 
          BorderRadius.circular(5),color: PageConstants.BLACK20),
          
           child:  Row(mainAxisAlignment: MainAxisAlignment.center,  children: [Icon(Icons.add,size: 20,color: Colors.black,),
          Text("Add Docuent")],),)):SizedBox()
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
    return 
      Container(width: 0.95*screenWidth,height: 35,color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,  children: [
        Container(width: 0.9*screenWidth,height: 28,
        decoration: BoxDecoration(color: PageConstants.BLACK20,
        borderRadius: BorderRadius.circular(5)),
        child:Center(child: Text(name)),)
        ,SizedBox(height: 7,)
      ],),)
    ;
  }
}