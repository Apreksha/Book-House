import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_house/database.dart';
import 'package:book_house/login.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth=FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState(){
    user=auth.currentUser!;
    user.sendEmailVerification();
    timer=Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange.shade900,
                  Colors.orange.shade800,
                  Colors.orange.shade400
                ]
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 90,
            child: Image.asset("assets/tick.png"),
          ),
          Text("A verification link has been sent to ${user.email}.",
          textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
          child: Text("\nPlease click on the link sent to your email account"
            "to verify your email and continue the registration process.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          )
          ),
        ],
          )
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async{
    user=auth.currentUser!;
    User? updateUser=FirebaseAuth.instance.currentUser;
    await user.reload();
    if(user.emailVerified){
      Database(uid: updateUser!.uid).updateVerified(true);
      timer.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
    }
  }
}
