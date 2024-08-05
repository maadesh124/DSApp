// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fp4/Models/Course.dart';
import 'package:fp4/Models/Reviews.dart';

class Top extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    double screenWidth=MediaQuery.of(context).size.width;
    return Container(height: 30,width:screenWidth,
      child:Stack( children: <Widget>[
   Align(alignment: Alignment.topCenter,child: Text("Driving School Name",
   style: TextStyle(color: Colors.black,fontSize: 18,),),),
   Positioned(right: 20, child: 
   Container(width: 30,height: 30,
   decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
   child:const Align(alignment: Alignment.center, child:Text( "N",
   style: TextStyle(color: Color.fromARGB(255, 21, 115, 59),fontSize: 18))
   )),)
   //SizedBox(width: 30,)

],));
  }
}


// ignore_for_file: prefer_const_constructors

class CSearchBar extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    double width=MediaQuery.of(context).size.width;
    return Container(height:35,width:width,child:Center(child: 
    Container(
      height: 45,
      width:0.8*width,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(children:
       <Widget>[Positioned(top: 0,bottom: 0,left: 10, child:Align(alignment: Alignment.center, 
       child: Text("Search for 'License apply'",style: TextStyle(fontSize: 16,
       color: Color.fromARGB(128, 0, 0, 0)),)))
       ,Positioned(right:10,top: 0,bottom: 0,child: Align(alignment: Alignment.center,
        child: Container(width :60,height: 30,
        child: Row(children:<Widget>[
          Icon(Icons.search,color: Color.fromARGB(128,0,0,0),size: 25,),
          Spacer(flex: 1,),
          Container(width: 2,height: 17.5,alignment: Alignment.center,color: const Color.fromARGB(128,0,0,0),),
          Spacer(flex: 1,),
          Icon(Icons.mic,size: 25,color: const Color.fromARGB(128,0,0,0),)
        ],),),
       ),)


       ],)
    )));
  }
}

class PageConstants 
{
   
   static const Color DARKGREEN=Color.fromARGB(255, 21, 115, 59);
   static const Color LIGHTGREEN=Color.fromARGB(255, 122, 245, 171);
   static const Color BLACK50=Color.fromARGB(128,0,0,0);
   static const Color BLACK20=Color.fromARGB(51,0,0,0);
   static const Color INS_DARK=Color.fromARGB(255,2550,199,1);
   static const BoxDecoration PAGEBACKGROUND=BoxDecoration(gradient: 
    LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,  
    colors:<Color>[PageConstants.LIGHTGREEN,Color.fromARGB(255, 196, 236, 212)]));
       static const BoxDecoration INSTRUCTOR_BACKGROUND=BoxDecoration(gradient: 
    LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,  
    colors:<Color>[Color.fromARGB(255, 247, 210, 65),Color.fromARGB(255, 255, 225, 116)]));
    static Color INSCOLOR=Color.fromARGB(255, 255, 224,116);

    static Color LEARNER_DARK=Color.fromARGB(255, 108, 88,227);
    static Color LEARNER_LIGHT=Color.fromARGB(255,206,201,244);
    static BoxDecoration LEARNER_BG=BoxDecoration(gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
      Color.fromARGB(255,204,198,244),
      Color.fromARGB(255,157,146,234),
        Color.fromARGB(255,206,201,244)
    ]));
}





class BottomNavigation extends StatelessWidget {

  int active;
  BottomNavigation({super.key,required this.active});

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      elevation: 30,
    unselectedItemColor: Colors.grey,
    currentIndex: active,
    fixedColor: Color(0xff15733A),
    items: const[
      BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_outlined)),
      BottomNavigationBarItem(label: "Review", icon: Icon(Icons.reviews_outlined)),
      BottomNavigationBarItem(label: "Application", icon: Icon(Icons.file_copy_outlined)),
      BottomNavigationBarItem(label: "Payment", icon: Icon(Icons.currency_rupee_outlined)),
    ],
    );
  }
}

class InputBox extends StatelessWidget {
  final double width,height;
  FormFieldValidator? validator;
  bool obscureText;
  BoxDecoration? decoration;
  String? text;
  String? label; 
  TextEditingController? textEditingController;
  InputBox({super.key,required this.width,required this.height,this.text,this.decoration,
  this.textEditingController,this.label,this.obscureText=false,this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(width:width,decoration: decoration,
    height: height,
     child:TextFormField(validator: validator,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
      controller: textEditingController,
      cursorColor: PageConstants.BLACK50,
      obscureText: obscureText,
    // cursorHeight: 16,
  decoration: InputDecoration(
    labelStyle: TextStyle(color: Colors.black),
    hintText: text,
    labelText:label,
    hintStyle: TextStyle(fontSize: 16,),
    contentPadding: EdgeInsets.symmetric(vertical: 10),
   
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    //cursorColor: Colors.black,
  ),
)
    );
  }
}


class RatingWidget extends StatelessWidget {
  final double rating;
  final double size;

  RatingWidget({required this.rating, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toString(),
          style: TextStyle(fontSize: size),
        ),
        SizedBox(width: 5),
        Row(
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return Icon(
                Icons.star,
                color: Colors.amber,
                size: size,
              );
            } else if (index < rating) {
              return Icon(
                Icons.star_half,
                color: Colors.amber,
                size: size,
              );
            } else {
              return Icon(
                Icons.star_border,
                color: Colors.amber,
                size: size,
              );
            }
          }),
        ),
      ],
    );
  }
}


class DefaultImage extends StatelessWidget {
  final Color color;
  final double width,height;
  const DefaultImage({super.key,this.color=Colors.white,required this.width,required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth=MediaQuery.of(context).size.width;
    return Container(height: height,width: width,color: PageConstants.LIGHTGREEN, 
     child:  FittedBox(
                fit:BoxFit.cover ,
                child: Image.asset('D:/Flutter Projects/fp4/assets/images/img.png'),));
  }
}


class ProgressView extends StatefulWidget {

List<Progress> list=[];
bool editable;
double height;

ProgressView({super.key,required this.list,required this.editable,required this.height});


  @override
  State<ProgressView> createState() => _ProgressViewState();
}



class _ProgressViewState extends State<ProgressView> {
List<Progress> progressList=[];
TextEditingController name=TextEditingController();
TextEditingController des=TextEditingController();
double height=150;

@override
void initState()
{
  super.initState();
  progressList=widget.list;
  height=widget.height;

}

void addLesson()
  {
    showDialog(context: context, builder: (context) 
    {
      return AlertDialog(title: Text("Add Lesson"),content:Container(
        height: 100, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        InputBox(height: 30,width: 200,
      text: "Lesson Name",
      textEditingController: name,),
      SizedBox(height: 10,),
      InputBox(height: 30,width: 200,
      text: "Lesson Description",
      textEditingController: des,)
      ])), 
      actions: [
        InkWell(splashColor: PageConstants.BLACK20,  onTap: ()
        {
          Navigator.of(context).pop();
        }, 
        child: Text("CANCEL",style: TextStyle(color: Colors.black),)),
      
        SizedBox(width: 10,),
        InkWell(
          onTap: ()
      {
        
        print(progressList);
        setState(() {
          progressList.add(Progress(lessonName: name.text, lessonDescription: des.text, isCompleted: 
          false));
          
        });
        name.clear();
        des.clear();
        Navigator.of(context).pop();

      }, child: Text("OK",style: TextStyle(color: Colors.black),))],);
    } );
    
  }

  @override
  Widget build(BuildContext context) {

    final sw=MediaQuery.of(context).size.width;
    int len=progressList.length<=3?progressList.length:3;
    return   Container(width: sw*0.95,height: height,
    decoration: BoxDecoration(color: Colors.white,
    borderRadius: BorderRadius.circular(15)),
    child: Column(children: [
      Row(children: [
        SizedBox(width: 0.025*sw,),
        Text('Lessons'),
      Spacer(flex: 1,),
      widget.editable?
      InkWell( onTap: addLesson, child: Container(child: Row(children: [
        Icon(Icons.add,size: 20,),
        Text('Add Lesson'),
        SizedBox(width: 0.025*sw,)
      ],),),):SizedBox(),
      ],),
      Container(width: sw*0.90,height:height-20,padding: EdgeInsets.all(0)
      ,   child: ListView.builder(itemCount: progressList.length,
      itemBuilder: (_,inex)=>SingleProgress(p: progressList[inex], index: inex+1),),)
      
    ],),);
  }
}


class SingleProgress extends StatelessWidget {

  Progress p;
  int index;
  SingleProgress({required this.p,required this.index ,super.key});

  @override
  Widget build(BuildContext context) {
     final sw=MediaQuery.of(context).size.width;
    return Column(children: [ Container(padding: EdgeInsets.all(10), width:0.95*sw ,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
    color: (p.isCompleted)?PageConstants.LIGHTGREEN:PageConstants.BLACK20),
    child: Text('${index}.${p.lessonName}:${p.lessonDescription}',textAlign: TextAlign.left,
    softWrap: true,textDirection: TextDirection.ltr,)),
    SizedBox(height: 5,)]);
  }
}


class ReviewWidget extends StatefulWidget {

  String reviewId;
  ReviewWidget({super.key,required this.reviewId});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}




class _ReviewWidgetState extends State<ReviewWidget> {

Review review=Review();
bool gotData=false;
List<String> keys=[];
Future<void> initialize()async
{
  keys=review.reviews.keys.toList();
  review.setDocId(widget.reviewId);
  await review.getFromDB();
  keys=review.reviews.keys.toList();
  setState(() {
    gotData=true;
    print('set');
  });
  print(review.reviews);
  print('object');
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
    return !gotData?Center(child: CircularProgressIndicator(),):Container(width: sw*0.95,height: 300,decoration: BoxDecoration(
      color: Colors.white,borderRadius: BorderRadius.circular(15)
    ),padding: EdgeInsets.all(10),
    child:Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text('Reviews',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
      Expanded(child: ListView.builder(itemCount: keys.length,itemBuilder: (_,index)
      {
          return Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleReview(map: review.reviews[keys[index]]!),
              SizedBox(height: 10,)
            ],
          );
      },))
    ],) ,);
  }
}


class SingleReview extends StatelessWidget {
  Map<String,String> map;
  SingleReview({super.key,required this.map});

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,children: [
      Text(map['name']!,style: TextStyle(fontWeight: FontWeight.w100,color: Colors.black.withOpacity(0.4)),),
      Text(map['data']!,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.8)),)
      ],
    ),);
  }
}