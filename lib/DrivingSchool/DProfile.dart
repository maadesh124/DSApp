
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';
import 'package:fp4/Models/DrivingSchool.dart';
import 'package:fp4/Others/Functions.dart';
import 'package:fp4/Others/Location.dart';
import 'package:fp4/Others/MyFiles.dart';
import 'package:fp4/Others/Test.dart';
import 'package:fp4/User.dart';

class Dprofile extends StatefulWidget {
  const Dprofile({super.key});

  @override
  State<Dprofile> createState() => _DprofileState();
}

class _DprofileState extends State<Dprofile> {
TextEditingController name=TextEditingController();
TextEditingController mobNo=TextEditingController();
TextEditingController email=TextEditingController();
TextEditingController ownerName=TextEditingController();
String address='not picked';
TextEditingController des=TextEditingController();
DrivingSchool ds=DrivingSchool();
List<dynamic> loc=[];


@override
void initState()
{
  ds=User.getDS();
  super.initState();
  

}

Future<void> pickLocation()async
{
  cprint('prss');
loc=await getcurrentLocation();
 setState(() {
address=loc[0];
 });
 cprint(loc[1].latitude.toString());
}

Future<void> uploadFile()async
{
  pickAndUpload('${ds.collectionType}/${ds.getDocId()}/Documents', ext: ['pdf']);
}

void submitClicked()async
{
  ds.schoolName=name.text;
  ds.mobileNumber=int.parse(mobNo.text);
  ds.email=email.text;
  ds.ownerName=ownerName.text;
  ds.location=GeoPoint(loc[1].latitude,loc[1].longitude);
  ds.description=des.text;
  await ds.setToDB();

}

  @override
  Widget build(BuildContext context) {
    final sw=MediaQuery.of(context).size.width;
    final sh=MediaQuery.of(context).size.height;
    return Scaffold(body: SingleChildScrollView(
      child: Container(height: sh*1.2,
        decoration: PageConstants.PAGEBACKGROUND,
        child: Center(
          child: Container(width: sw*0.8,height: sh*0.9,
            decoration: BoxDecoration(color: Colors.white,borderRadius: 
          BorderRadius.circular(15)),child: Column(children: [
            SizedBox(height: 20,),
            CircularAvatar(letter:ds.schoolName[0], size: 100, letterColor: PageConstants.DARKGREEN),
            SizedBox(height: 30,),
            Container(width: 0.6*sw,height: 30,
              child: TextFormField(decoration: InputDecoration( label: Text('School Name',),
              border: OutlineInputBorder(),),controller:name ,),),
              Spacer(flex: 1,),
               Container(width: 0.6*sw,height: 30,
              child: TextFormField(decoration: InputDecoration( label: Text('Mobile No.',),
              border: OutlineInputBorder(),),controller:mobNo ,),),
              Spacer(flex: 1,),
               Container(width: 0.6*sw,height: 30,
              child: TextFormField(decoration: InputDecoration( label: Text('Email',),
              border: OutlineInputBorder(),),controller:email ,),),
              Spacer(flex: 1,),
                Container(width: 0.6*sw,height: 30,
              child: TextFormField(decoration: InputDecoration( label: Text('Owner Name',),
              border: OutlineInputBorder(),),controller:ownerName ,),),
              Spacer(flex: 1,),
                  Container(//padding: EdgeInsets.all(40),
                   child: Row(
                     children: [
                      Text(address,style: TextStyle(fontSize: 10),),
                    
                      Positioned(right: 0,bottom: 0,
                        child: IconButton(icon:  Icon(Icons.location_on_rounded,color: PageConstants.DARKGREEN,),
                        onPressed:pickLocation,)),
                     ],
                   ),
                 ),
              Spacer(flex: 1,),
                 Container(width: 0.6*sw,height: 30,
              child: TextFormField(decoration: InputDecoration( label: Text('School Description',),
              border: OutlineInputBorder(),),controller:des ,),),
              Spacer(flex: 1,),
              InkWell(onTap: uploadFile,
                child: Container(width:100,height: 30,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: PageConstants.DARKGREEN),child: Center(child: Text('Upload Files',style: 
                TextStyle(color: Colors.white),),),),
              ),
              Spacer(flex: 1,),
              InkWell(onTap: submitClicked,
                child: Container(width:100,height: 30,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: PageConstants.DARKGREEN),child: Center(child: Text('Save',style: 
                TextStyle(color: Colors.white),),),),
              ),
              SizedBox(height: 20,)
              
          ],),),
        ),
      ),
    ),);
  }
}