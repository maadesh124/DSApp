import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Enquiry.dart';
import 'package:fp4/Models/Examples.dart';
import 'package:fp4/Models/Model.dart';


class EnquiryView extends StatefulWidget {
  Enquiry temp;

  EnquiryView({super.key,required this.temp});

  @override
  State<EnquiryView> createState() => _EnquiryViewState();
}

class _EnquiryViewState extends State<EnquiryView> {

bool gotData=false;
  Enquiry enquiry=Enquiry();
   String enquiryObjectId='';

void initialize() async
{

  
  FirebaseFirestore.instance.collection(Model.ENQUIRY).
  doc(widget.temp.getDocId()).snapshots().listen((snapshot) {
    setState(() {
      enquiry.fromSnapShot(snapshot);
      gotData=true;
    });
  });


}


@override
void initState()
{
  initialize();
  super.initState();
}

void sendMessage(String message)
{
  enquiry.addMessage(Message(dateTime: DateTime.now(),message:message,
  sender:Model.DRIVINGSCHOOL ),enquiryObjectId);
}


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    final sh=MediaQuery.of(context).size.height;
    return Scaffold(body: ClipRRect(borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10)
    ),
      child: Container(decoration: PageConstants.PAGEBACKGROUND,child: 
      Column(children: [
        SizedBox(height: 40,),
        Top(),
        SizedBox(height: 20,),
              ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
              child: Container(width: sw*0.95,height: 40,color: PageConstants.DARKGREEN,child: 
              Column(children: [
                Text(widget.temp.learnerName,style: TextStyle(color: Colors.white),),
                Text(widget.temp.enquiryNo,style: TextStyle(color: Colors.white),)
              ],),)),
            
       !gotData?Center(child:CircularProgressIndicator()): Container(width: 0.95*sw,height:sh-160,
       decoration: BoxDecoration(
          color: Colors.white,borderRadius: BorderRadius.circular(10),
        ),child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
            ),
              child: Center(child: MessageView(messages: enquiry!.messages))),
            ClipRRect(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
             child: ClipRRect( borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10),
             bottomRight: Radius.circular(10)),
               child: MessageBar(sendButtonColor: PageConstants.DARKGREEN,
               onSend: (p0) => sendMessage(p0),),
             ))
          ],
        ),)
      ],),),
    ),);
  }
}


class MessageView extends StatefulWidget {

  List<Message> messages;
 MessageView({required this.messages,super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
   final sw= MediaQuery.of(context).size.width;
   final sh=MediaQuery.of(context).size.height;
   
    return Container(//width:sw*0.95 ,//height: sh-130-40-64,
    color: Colors.white,child: ListView.builder(itemCount: widget.messages.length,
    itemBuilder: (context, index) {
      bool isSchool=widget.messages[index].sender==Model.DRIVINGSCHOOL;
    return  Column(
      children: [
        BubbleSpecialThree(text: widget.messages[index].message,
          color: isSchool?PageConstants.LIGHTGREEN:PageConstants.BLACK20,
          tail:widget.messages.length-1==index,
          isSender: isSchool),
          SizedBox(height:widget.messages.length-1==index?60:0 ,)
      ],
    );
    },),);
  }
}