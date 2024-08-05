import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: LinearGradient(end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
          colors:
         [PageConstants.LIGHTGREEN,Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Welcome to Name",
              style: TextStyle(
              fontSize: 40,
            
            ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/dswelcome.png', // Replace with your image asset path
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '   Unlock New Growth Potential \n '
                        '       for Your Driving School',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    width: 10,
                  ),
                  const Card(
                    color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Get Started',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}