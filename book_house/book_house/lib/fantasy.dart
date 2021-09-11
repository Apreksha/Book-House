import 'package:book_house/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Fantasy extends StatefulWidget {
  const Fantasy({Key? key}) : super(key: key);

  @override
  _FantasyState createState() => _FantasyState();
}

class _FantasyState extends State<Fantasy> {
  final firestoreInstance = FirebaseFirestore.instance;
  List image = [],author=[],download=[],name =[],shortInfo=[];
  String result="Connected";

  @override
  Widget build(BuildContext context) {
  _checkInternetConnectivity();
  firestoreInstance.collection("Books").doc("Fantasy").get().then((value){
      setState(() {
        image = value.data()!["Image"];
        name = value.data()!["Name"];
        shortInfo=value.data()!["Information"];
        author = value.data()!["Author"];
        download = value.data()!["Url"];
      });
    });
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return internetCheck==false?Scaffold(
        appBar: AppBar(
          title: Text("Fantasy"),
          backgroundColor: Colors.orange.shade400,
        ),
        body: Container(
          height: height,
          width: width,
          child: ListView.builder(
            itemCount: image.length,
            itemBuilder: (context, index) {
              return Container(
                width: width,
                margin: EdgeInsets.only(left:10,top:4,bottom: 6),
                child: GestureDetector(
                  child: Row(
                    children: [
                      FadeInImage.assetNetwork(
                        width: 120,
                        height: 170,
                        placeholder: 'assets/placeholder.png',
                        image: image[index],
                        fit:BoxFit.cover,),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: [
                          Container(
                              width: width*0.5,
                              child: Text('${name[index]}',textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),)),
                          Container(
                              width: width*0.5,
                              margin: EdgeInsets.only(top: 5),
                              child: Text(author[index],textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 17
                                ),)),
                          Container(
                            width: width*0.5,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(shortInfo[index],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700
                              ),),
                          )
                        ],
                      )
                    ],
                  ),
                  onTap: (){
                    String value=name[index];
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Details(value:value,img: image[index],author:author[index],genre:"Fantasy",download: download[index],)));
                  },
                ),
              );
            },
          ),
        )
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