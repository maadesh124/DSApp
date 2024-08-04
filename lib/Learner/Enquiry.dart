import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';
import 'package:fp3/Models/DrivingSchool.dart';
import 'package:fp3/Models/Enquiry.dart';
import 'package:fp3/Models/Learner.dart';
import 'package:fp3/Models/Model.dart';
import 'package:fp3/User.dart';


class EnquiryViewLearner extends StatefulWidget {
  // Enquiry temp;
  DrivingSchool ds;
  Learner learner;
  EnquiryViewLearner({super.key,required this.ds,required this.learner});

  @override
  State<EnquiryViewLearner> createState() => _EnquiryViewLearnerState();
}

class _EnquiryViewLearnerState extends State<EnquiryViewLearner> {

bool gotData=false;
  Enquiry enquiry=Enquiry();
   String enquiryObjectId='';

void initialize() async
{
  if(widget.learner.enquiries.keys.toList().contains(widget.ds.getDocId()))
{
  enquiry.setDocId(widget.learner.enquiries[widget.ds.getDocId()]);
  await enquiry.getFromDB();
}
else
{
 enquiry= await Enquiry.create(widget.ds,widget.learner) ;
}
  
  FirebaseFirestore.instance.collection(Model.ENQUIRY).
  doc(enquiry.getDocId()).snapshots().listen((snapshot) {
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
  sender:Model.LEARNER ),enquiryObjectId);
}


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    final sh=MediaQuery.of(context).size.height;
    return Scaffold(body: ClipRRect(borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10)
    ),
      child: Container(decoration: PageConstants.LEARNER_BG,child: 
      Column(children: [
        SizedBox(height: 40,),
        CSearchBar(),
        SizedBox(height: 20,),
              ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
              child: Container(width: sw*0.95,height: 40,color: PageConstants.LEARNER_DARK,child: 
              Column(children: [
                Text(widget.ds.schoolName,style: TextStyle(color: Colors.white),),
               // Text(enquiry.enquiryNo,style: TextStyle(color: Colors.white),)
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
              child: Center(child: MessageView(messages: enquiry.messages))),
            ClipRRect(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
             child: ClipRRect( borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10),
             bottomRight: Radius.circular(10)),
               child: MessageBar(sendButtonColor: PageConstants.LEARNER_DARK,
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
      bool isLearner=widget.messages[index].sender==Model.LEARNER;
    return  Column(
      children: [
        BubbleSpecialThree(text: widget.messages[index].message,
          color: isLearner?PageConstants.LEARNER_LIGHT:PageConstants.BLACK20,
          tail:widget.messages.length-1==index,
          isSender: isLearner),
          SizedBox(height:widget.messages.length-1==index?60:0 ,)
      ],
    );
    },),);
  }
}