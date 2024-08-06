import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';



//Use below to call in learner page 
// DocumentListWidget(docList: st,editable: false,onDocClicked: (String name)=>pickAndUpload('t1/t2',name: name),),
//Use below code to call in drivingSchool and instructor pages
//List<String> st=[];
//DocumentListWidget(docList: st,editable: true,onDocClicked: (String name)=>null,),
//st has the list of document names given by DrivingSchool or Instructor

class DocumentListWidget extends StatefulWidget {

  List<String> docList;
  bool editable=false;
  Function onDocClicked; //this function is called when a document is clicked
  DocumentListWidget ({super.key,required this.docList,required this.editable,required this.onDocClicked});

  @override
  State<DocumentListWidget > createState() => _DocumentListWidgetState();
}

class _DocumentListWidgetState extends State<DocumentListWidget > {

List<Widget> docs=[];
TextEditingController textEditingController=TextEditingController();

void initState()
{
  super.initState();
  widget.docList.forEach((doc)=>docs.add(Document(name: doc,onPressed:widget.onDocClicked)));
}

void onPressed(String _) async
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
        widget.docList.add(textEditingController.text);
        print(widget.docList);
        setState(() {

          docs.add(Document(name: textEditingController.text,onPressed:widget.onDocClicked,));
          
        });
        textEditingController.clear();
        Navigator.of(context).pop();

      }, child: Text("OK",style: TextStyle(color: Colors.black),))],);
    } );
    
  }




  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    Widget textButton=InkWell(onTap: null,child: Document(name: 'Add Document',onPressed:onPressed ,),);
    List<Widget> elements=[Container(width: 0.95*sw,height: 30, alignment: Alignment.centerLeft,
    child: Text('Required Documents'),)];
    elements.addAll(docs);
    widget.editable?elements.add(textButton):null;
    return Container(width: 0.95*sw,decoration:
     BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
    child: 
    Column(children: elements,),);
  }
}






class Document extends StatelessWidget {
  String name;
  Function onPressed;
   Document({super.key,required this.name,required this.onPressed});
 
  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return 
      InkWell(onTap: ()=>onPressed(name),
        child: Container(width: 0.95*screenWidth,height: 35,//color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,  children: [
          Container(width: 0.9*screenWidth,height: 28,
          decoration: BoxDecoration(color: PageConstants.BLACK20,
          borderRadius: BorderRadius.circular(5)),
          child:Center(child: Text(name)),)
          ,SizedBox(height: 7,)
        ],),),
      )
    ;
  }
}