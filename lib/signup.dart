import 'package:book_house/database.dart';
import 'package:book_house/verify.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  List reads=[];
  List favList=[];String result="Connected";
  String _email="",_password="",_username="";
  var phone;
  bool emailVerified=false,phoneVerified=false,verify=false;
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
                  Text("Register Yourself", style: TextStyle(color: Colors.white, fontSize: 40),),
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
                              decoration: InputDecoration(
                                  hintText: "Email Id",
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
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: "Phone number",
                                  prefixIcon: Icon(Icons.phone_android,
                                    color: Colors.black,),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                              onChanged: (value){
                                setState((){
                                  phone=value.trim();
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
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  prefixIcon: Icon(Icons.face,
                                    color: Colors.black,),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                              onChanged: (value){
                                setState((){
                                  _username=value.trim();
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
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.orange[900]
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange.shade900, // background
                            ),
                            onPressed: () async{
                              if(_email=="" || _password==""|| _username==""||phone==""||phone.toString().length<10||phone.toString().length>10){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Invalid Input"),
                                duration: Duration(seconds: 3),));
                              }
                              else{
                                _signup(_email,_password);
                              }
                            },
                            child: Text("Register Yourself", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
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
  _signup(String _email,String _password) async{
    try{
      await auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password);
      User? updateUser=FirebaseAuth.instance.currentUser;
      updateUser!.updateDisplayName(_username);
      Database(uid: updateUser.uid).updateUserData(_email,_username,phone,emailVerified,phoneVerified,reads,favList);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Verify()));
    }
    on FirebaseAuthException catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${error.message}"),duration: Duration(seconds: 3),));
    }
  }
}