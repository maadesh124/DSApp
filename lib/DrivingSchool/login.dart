import 'package:flutter/material.dart';
import 'package:fp4/CustomWidgets/PageWidgets.dart';




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // You can add your own authentication logic here
    // For simplicity, let's just print the username and password
    print('Username: $username');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InputBox(width: 200, height: 60,label: "Username",
                textEditingController: _usernameController,),
                //SizedBox(height: 20.0),
            InputBox(width: 200, height: 100,label: "Password",obscureText: true,
            textEditingController:_passwordController,),
             SizedBox(height: 10,),
                 Align(alignment: Alignment.bottomCenter, child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: ()
                    {
                      print("button pressed");
                    },
                    splashColor: PageConstants.BLACK20,
                    child: Container(decoration: BoxDecoration(color: PageConstants.DARKGREEN.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5)),
                    width: 100,height: 40,child: Center(
                      child: Text("Login",style: TextStyle(color: Colors.white),),),),
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}