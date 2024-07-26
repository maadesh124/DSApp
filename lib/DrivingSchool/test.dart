import 'package:flutter/material.dart';
import 'package:fp3/CustomWidgets/PageWidgets.dart';

class MyWidget extends StatelessWidget {

  List<Text> list=[Text("name1"),Text("name2")];
  MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return Container(decoration: PageConstants.PAGEBACKGROUND,
    width:screenWidth ,
    child: ListView.builder( itemCount: list.length, 
     itemBuilder: (context,index)=>Container(color: Colors.red, width: 0.95*screenWidth,
     child: Column(children: <Widget>[list[index],
     SizedBox(height: 30,)],),),));
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 30,
    unselectedItemColor: Colors.grey,
    currentIndex: 2,
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

class SplashButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Button tapped!");
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.blue.withOpacity(0.3), // Splash color setup
          highlightColor: Colors.blue.withOpacity(0.1),
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Tap Me',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Check extends StatelessWidget {
  const Check({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(child: Container(width: 100,height: 30,
      child: Text('Button'),),onTap: () async{
            final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate:  DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null ) {
      print(picked.toString());
      }}),
    );
  }
}