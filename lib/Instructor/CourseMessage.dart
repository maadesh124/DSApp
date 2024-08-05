

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/CourseMessage.dart';
import 'package:fp4/Models/Model.dart';
import 'package:fp4/User.dart';

class CourseMessageView extends StatefulWidget {
  Course course;
 CourseMessageView({super.key,required this.course});

  @override
  State<CourseMessageView> createState() => _CourseMessageViewState();
}

class _CourseMessageViewState extends State<CourseMessageView> {
bool gotData=false;
ChatUser currentUser=ChatUser(id: User.getIns().getDocId(),firstName: User.getIns().name);
CourseMessage courseMessage=CourseMessage();
List<ChatMessage>chatMessages=[];

Future<void> initialize()async
{
final ref=await FirebaseFirestore.instance.collection(Model.COURSE_MESSAGE).doc(widget.course.getDocId()).
snapshots().listen((event) {

  courseMessage.fromSnapShot(event);
   courseMessage.messages= courseMessage.messages.reversed.toList();
  setState(() {
      chatMessages=List.generate(courseMessage.messages.length, 
   
  (index) => courseMessage.messages[index].toChatMessage());
  gotData=true;
  });
 });
}


void addMessage(ChatMessage chatMessage)
{
   courseMessage.messages.add(Message.fromChatMessage(chatMessage));
   courseMessage.setToDB(); 
}

  @override
  void initState()
  {
    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    final sh=MediaQuery.of(context).size.height;
    
    return Scaffold(body: 
    Container(decoration: PageConstants.INSTRUCTOR_BACKGROUND,
    child: Column(
      children: [
      SizedBox(height: 40,),
      Top(),
      SizedBox(height: 20,),
      Container(width: sw*0.95,height: 45,decoration: BoxDecoration(
        color: PageConstants.INS_DARK,borderRadius: 
        BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
      ),child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(widget.course.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
        Text(widget.course.dsName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)
      ],),),
      ClipRRect(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
        child: Container(height: sh-175,width:sw*0.95 ,
        color: Colors.white
        ,  child:!gotData?Center(child: CircularProgressIndicator()):
         DashChat(
          messageOptions: MessageOptions(//showOtherUsersAvatar: false,
        currentUserContainerColor: PageConstants.INSCOLOR),
          currentUser: currentUser, onSend: addMessage, messages: chatMessages)),
      )
    ],),),);
  }
}