import 'package:flutter/material.dart';

class CourseView1 extends StatefulWidget {
  const CourseView1({super.key});

  @override
  State<CourseView1> createState() => _CourseView1State();
}

class _CourseView1State extends State<CourseView1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor : Color(0xff7AF5AB),
        appBar: AppBar(
          backgroundColor: Color(0xff7AF5AB),
          title: Center(
              child: Text(
              "Driving School Name",
              style: TextStyle(fontWeight: FontWeight.w100,)
          )
          ),
          actions: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white
              ),
              child: Center(child: Text("N",style: TextStyle(fontSize: 20,color: Color(0xff15733A)),)),

            ),
            SizedBox(width: 20,)
          ],
        ),
        body :Container(//for background mixed color
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xff7AF5AB),
                        Color(0xffB5F8CF),
                        Color(0xffBDFFD7),
                      ],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd)
              ),
          child: Column(
              children: [
                    SearchBar(),
              ],
           ),
          ),
         bottomNavigationBar: BottomNav(),
        ),
      );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override

  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(5))
    );
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
                  height: 60,
                  width: 100,
                  child: TextField(
            style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                disabledBorder: border,
                filled: true,
                fillColor: Color(0xffFFFFFF),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                    borderRadius : BorderRadius.horizontal(left: Radius.circular(15),),
                ),
                hintText: "Search for ‘Lisence apply’",
                hintStyle: TextStyle(fontSize: 15),
                suffixIcon: Icon(Icons.search, size: 30,),
                suffixIconColor: Color(0xff7AF5AB),
                )
              ),
            ),
          ),
          Container(height: 58,width: 1,color: Color(0xff15733A),),
          Container(
            height: 58,
            width: 55,
           child: Icon(Icons.mic,color: const Color(0xff7AF5AB),size: 30,),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(15),),
              color: Colors.white)
            ),
         ],
      ),
    );
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
    currentIndex: 1,
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
