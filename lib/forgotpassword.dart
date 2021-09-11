import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:book_house/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email="";  String result="Connected";
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    _checkInternetConnectivity();
    return internetCheck==false?Scaffold(
      body: Container(
        width: double.infinity,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Reset Password", style: TextStyle(color: Colors.white, fontSize: 40),)
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                          Container(
                            margin: EdgeInsets.only(top:10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10)
                                )]
                            ),
                            child:Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Email ID",
                                    prefixIcon: Icon(Icons.email,
                                      color: Colors.black,),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                                onChanged: (value){
                                  setState((){
                                    _email=value.trim();
                                  });
                                },
                              ),
                            ),
                          ),
                        SizedBox(height: 40,),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.orange[900]
                      ),
                      child:ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange.shade900, // background
                            ),
                            onPressed: () async{
                              if(_email==""){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Invalid Input"),duration: Duration(seconds: 3),));
                              }
                              else{
                                auth.sendPasswordResetEmail(email: _email);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => Login()));
                              }
                            },
                            child: Text("Send Request", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ):Scaffold(
    backgroundColor: Colors.orange.shade100,
    body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Center(
    child: Container(
    margin: EdgeInsets.only(bottom: 10),
    height: 150,
    width: 200,
    child: Image.asset("assets/embarrassed.png")),
    ),
    Center(child: Text("Unable to connect to Internet",style: TextStyle(
    fontSize: 20,
    ),)),
    Center(child: Text("Try again!",style: TextStyle(
    fontSize: 20,
    ),)),
    ],
    ));
  }
  bool internetCheck = true;
  _checkInternetConnectivity()async{
    var result = await Connectivity().checkConnectivity();
    setState(() {
      if(result == ConnectivityResult.wifi|| result == ConnectivityResult.mobile){
        setState(() {
          internetCheck = false;
        });
      }else{
        internetCheck = true;
      }
    });
  }
  void ChangeValue(String resultValue){
    setState(() {
      result=resultValue;
    });
  }
}