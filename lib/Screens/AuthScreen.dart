import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final firebaseAuth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  String userName = "";
  final key = GlobalKey<FormState>();
  bool isSigin = false;
  fireTrigger() async {
    final state = key.currentState!.validate();
    if (state) {
      key.currentState!.save();
      try {
        if (!isSigin) {
          print('K');
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          Get.snackbar("Success", "Your account have been created Successfull",
              backgroundColor: Colors.greenAccent);
        } else {
          await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);
          Get.snackbar("Success", "You have been successfully logined",
              backgroundColor: Colors.greenAccent);
        }
      } on FirebaseException catch (e) {
        Get.snackbar("Error", e.message!, backgroundColor: Colors.redAccent);
      }
    }
  }

  Widget loginCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.greenAccent.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: key,
              child: Column(
                children: [
                  if (!isSigin)
                    TextFormField(
                      onSaved: (event) {
                        setState(() {
                          userName = event!;
                        });
                      },
                      validator: (event) {
                        if (event!.length < 5)
                          return "user Name is less than 5 characters";
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                  TextFormField(
                    onSaved: (event) {
                      setState(() {
                        email = event!;
                      });
                    },
                    validator: (event) {
                      if (event!.isEmpty) return "Enter a email";
                      if (!event.contains("@") || !event.contains(".com")) {
                        return "Not a valid email";
                      }
                    },
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextFormField(
                    onSaved: (event) {
                      setState(() {
                        password = event!;
                      });
                    },
                    validator: (event) {
                      if (event!.isEmpty) return "Enter a Password";
                      if (event.length < 6) {
                        return "Password must contains more than 6 characters";
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  TextButton(
                      onPressed: fireTrigger,
                      child: Text(isSigin ? "Sigin In" : "Sigin up")),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isSigin = !isSigin;
                        });
                        key.currentState!.reset();
                      },
                      child: Text(
                          isSigin ? "create an account" : "Already a user"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/login.jpg"),
                loginCard(),
                // TextField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
