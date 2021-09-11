// @dart=2.9

import 'package:book_house/homepage.dart';
import 'package:book_house/login.dart';
import 'package:book_house/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
int initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences=await SharedPreferences.getInstance();
  initScreen=(await preferences.getInt('initScreen'));
  await preferences.setInt('initScreen', 1);
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isRememberMe = false;
  @override
  void initState(){
    //super.initState();
    getData();
  //  loadData();
  }

  /*@override
  void dispose() {
    super.dispose();
    loadData();
  }*/

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isRememberMe = prefs.getBool('remember');
    });
  }

 /* @override
  bool isRemember=false;
  Future<Timer> loadData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isRemember = prefs.getBool('remember')!;
    });
    return Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async{
    bool inside = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('inside') != null) {
      inside = prefs.getBool('inside')!;
    }
    isRemember == true ? Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage())) :
    //Navigator.of(context)
      //  .pushReplacement(MaterialPageRoute(builder: (context) => inside?Login():OnBoardingPage()));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen1()
      /*AnimatedSplash(
          imagePath: 'assets/splash.png',
          home: Login(),
          //customFunction: onDoneLoading(),
          duration: 1000,
            type: AnimatedSplashType.StaticDuration
        )*/
    );
  }
}

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState(){
    super.initState();
    loadData();
  }
  bool isRemember=false;
  Future<Timer> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isRemember = prefs.getBool('remember');
    });
    return Timer(Duration(seconds: 2),onDoneLoading);
  }
  onDoneLoading(){
    if(isRemember==true){
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
    else{
      print(initScreen);
      initScreen==0|| initScreen==null?
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => OnboardingScreen())):
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  void dispose() {
    super.dispose();
    loadData();
    onDoneLoading();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:Container(
        alignment: Alignment.center,
        height: height,
        color: Colors.orange.shade200,
        width: width,
        child: Container(
            child:Image.asset("assets/splash.png",),
            height: 150,
            width: 150,
          ),
      ),
    );
  }
}
