import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:dio/dio.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'loadingScreen.dart';

class Details extends StatefulWidget {
final String value,img,author,genre,download;
  const Details({Key? key,required this.value,required this.img,required this.author,required this.genre,required this.download}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState(value,img,author,genre,download);
}

class _DetailsState extends State<Details> {
  var particularBookName, img, author, genre, download;
  _DetailsState(this.particularBookName, this.img, this.author, this.genre,
      this.download);
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser=FirebaseAuth.instance.currentUser;
  List reads =[],fav=[];
  bool loading=true;
  String path = ""; String result="Connected";
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      path = await ExtStorage.getExternalStorageDirectory();
      return true;
    }
    else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        path = await ExtStorage.getExternalStorageDirectory();
        return true;}
      else {return false;}
    }
  }

  bool f = false,checkFav=false,checkRead=false;

  void _checkFavMarked(){
    if(fav.contains(particularBookName)){
      checkFav=true;}
  }
  void _checkReadMarked() {
    if (reads.contains(particularBookName)) {
      checkRead = true;
    }
  }

  void _getBool() async {
    if (await _requestPermission(Permission.storage)) {
      path = await ExtStorage.getExternalStorageDirectory();}
    String fullPath = "$path/Book House/$particularBookName.epub";
    if (await File(fullPath).exists()) {
      setState(() {
        print("Already downloaded");
        f = true;
      });
    }
    else {
      setState(() {
        print("not downloaded");
        f = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getBool();
    _checkInternetConnectivity();
    firestoreInstance.collection("Users").doc(firebaseUser!.uid).get().then((value){
      setState(() {
        reads = value.data()!["Reads"];
        fav = value.data()!["Fav"];});
      if(value.data()!["Reads"]!= null){
        loading = false;}
    });
    _checkFavMarked();
    _checkReadMarked();
    return internetCheck==false?loading==false?Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.of(context).pop();},),
        actions: [
          IconButton(icon: Icon(checkFav?Icons.favorite:Icons.favorite_border,color: checkFav?Colors.red:Colors.white,
          size: 25,),
            onPressed: () {favsbuilder();},),
          IconButton(padding: EdgeInsets.only(right: 20,left: 10),
            icon: Icon(checkRead?Icons.add_box:Icons.add,color: Colors.white,size: 25,), onPressed: () {readsbuilder();},),
        ],),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.50,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: img,
                    fit: BoxFit.fill,
                  ),),
                BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),),
                Container(
                  height: 200,
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035,
                      right: MediaQuery.of(context).size.height * 0.001,
                      top: MediaQuery.of(context).size.width * 0.3),
                child:FadeInImage.assetNetwork(
                  width: 120,
                  height: 170,
                  placeholder: 'assets/placeholder.png',
                  image: img,
                  fit:BoxFit.cover,),
                ),
                Container(
                  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.2,
                  left: MediaQuery.of(context).size.width*0.44,
                  right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: [
                      Container(
                      child:BorderedText(
                          strokeWidth: 4,
                          child:Text(particularBookName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        decorationColor: Colors.black,
                      ),)),),
                      Container(
                        margin: EdgeInsets.only(top:12),
                        child:BorderedText(
                            strokeWidth: 4,
                            child:Text(author,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                decorationColor: Colors.black,
                              ),)),),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 33,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black), )
                        ),
                        child: Text(genre,textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16
                          ),),
                      )
                    ],
                  ),
                )
              ]),
          SizedBox(height: 40,),
          Container(
            padding: EdgeInsets.all(5),
          child:ElevatedButton(onPressed: () async {
            f ?openBook(particularBookName, context, path): downloads(
                particularBookName, download, context, path);
          },
              child: Text(f?"Read":"Download",
                style: TextStyle(
                  fontSize: 19
                ),)))
        ],),
    ):LoadingScreen():Scaffold(
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

  downloads(String name, String download, BuildContext context, String path) async {
    try {
        var dio = Dio();
     // print("before downloads");
      if (await _requestPermission(Permission.storage)) {
        path = await ExtStorage.getExternalStorageDirectory();}
      String fullPath = "$path/Book House/$name.epub";
      if (f == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Downloading. Please Wait"),duration: Duration(seconds: 3),));
        await dio.download(
            download, fullPath,
            onReceiveProgress: (receivedBytes, totalBytes) {
              if (receivedBytes == totalBytes) {
                //print("downloaded");
                f=true;


                }
              else {//print("downloading");
                 }}
        );
        //print("after downloads");
      }
    }
    catch (e) {
      print("error is $e");
    }
  }

  openBook(String name, BuildContext context, String path) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        path = await ExtStorage.getExternalStorageDirectory();
      }
      String fullPath = "$path/Book House/$name.epub";
      if (f == true) {
        EpubViewer.setConfig(
            identifier: "androidBook",
            scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
            allowSharing: true,
            enableTts: false,
            nightMode: true);
        EpubViewer.open(fullPath);
      }
    }
    catch (e) {
      print("error is $e");
    }
  }

  readsbuilder() async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      var firebaseUser = FirebaseAuth.instance.currentUser;
      firestoreInstance.collection("Users").doc(firebaseUser!.uid).get().then((
          value) {
        print("uid: ${firebaseUser.uid}");
        if (value.data()!["Reads"].contains(particularBookName) == true) {
          firestoreInstance.collection("Users")
              .doc(firebaseUser.uid)
              .update({
            "Reads": FieldValue.arrayRemove(["$particularBookName"]),
          }).then((_) {
            setState(() {
              checkRead=false;
            });
           // print("success");
          });
        }
        else {
          firestoreInstance.collection("Users")
              .doc(firebaseUser.uid)
              .update({
            "Reads": FieldValue.arrayUnion(["$particularBookName"]),
          }).then((_) {
            setState(() {
              checkRead=true;
            });
          //  print("success");
          });
        }
      });
    }
    catch (e) {
      print("error is $e");
    }
  }

  favsbuilder() async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;
      var firebaseUser = FirebaseAuth.instance.currentUser;
      firestoreInstance.collection("Users").doc(firebaseUser!.uid).get().then((
          value) {
        print("uid: ${firebaseUser.uid}");
        if (value.data()!["Fav"].contains(particularBookName) == true) {
          firestoreInstance.collection("Users")
              .doc(firebaseUser.uid)
              .update({
            "Fav": FieldValue.arrayRemove(["$particularBookName"]),
          }).then((_) {
            setState(() {
              checkFav=false;
            });
          //  print("success");
          });
        }
        else {
          firestoreInstance.collection("Users")
              .doc(firebaseUser.uid)
              .update({
            "Fav": FieldValue.arrayUnion(["$particularBookName"]),
          }).then((_) {
            setState(() {
              checkFav=true;
            });
            //print("success");
          });
        }
      });
    }
    catch (e) {
      print("error is $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _getBool();
    f;
    checkRead;
    reads;
    fav;
    checkFav;
  }

}
