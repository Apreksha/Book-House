import 'package:book_house/database.dart';
import 'package:book_house/forgotpassword.dart';
import 'package:book_house/homepage.dart';
import 'package:book_house/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _email="",_password="";
  var f=0;String result="";
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
                    Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                    SizedBox(height: 10,),
                    Text("Welcome", style: TextStyle(color: Colors.white, fontSize: 18),),
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
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10)
                                )]
                            ),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: "Email ID",
                                        prefixIcon: Icon(Icons.email,
                                          color: Colors.black,),
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    onChanged: (value){
                                      setState(() {
                                        _email=value.trim();
                                      });
                                    },
                                  ),
                                ),
                            ),
                      Container(
                        margin: EdgeInsets.only(top:10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(
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
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        prefixIcon: Icon(Icons.lock,
                                          color: Colors.black,),
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    onChanged: (value){
                                      setState((){
                                        _password=value.trim();
                                      });
                                    },
                                  ),
                                ),
                      ),
                          SizedBox(height: 40,),
                          TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                              },
                              child: Text("Forgot Password?",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),)
                          ),
                          SizedBox(height: 10,),
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
                                if(_email=="" || _password==""){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Invalid Input"),duration: Duration(seconds: 3),));
                                }
                                else{
                                _login(_email,_password);
                              }
                              },
                              child: Text("Start Reading", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),),
                        SizedBox(height: 10,),
                          Text("Don't have an account?",style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          ),),
                          TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                              },
                              child: Text("Sign Up Now",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),)
                          ),
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
  _login(String _email,String _password) async {
    User? updateUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    bool verified = false;
    try {
      await auth.signInWithEmailAndPassword(
          email: _email,
          password: _password);
      firestoreInstance.collection("Users").doc(firebaseUser!.uid).get().then((
          value) async {
        verified = value.data()!["emailVerified"];
        if (verified == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('remember', true);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        }
        else if (verified == false) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("You are not verified. Register again."),
            duration: Duration(seconds: 3),));
          Database(uid: updateUser!.uid).UserDataDelete(updateUser.uid);
          updateUser.delete();
        }
      });
    }
    on FirebaseAuthException catch (error) {
      print(error.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${error.message}"), duration: Duration(seconds: 3),));
    }
  }
}