import 'package:book_house/detail.dart';
import 'package:book_house/loadingScreen.dart';
import 'package:book_house/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser=FirebaseAuth.instance.currentUser;
  List authorRomance = [],authorAdventure = [],authorThriller = [],authorScienceFiction =[],authorFantasy=[],authorYAF=[],authorCrime=[],authorSelfHelp=[];
  List imageRomance = [],imageScienceFiction = [],imageAdventure = [],imageThriller = [],imageFantasy=[],imageYAF=[],imageCrime=[],imageSelfHelp=[];
  List nameRomance = [],nameAdventure = [],nameThriller = [],nameScienceFiction =[],nameFantasy=[],nameYAF=[],nameCrime=[],nameSelfHelp=[];
  List downloadRomance = [],downloadAdventure = [],downloadThriller = [],downloadScienceFiction =[],downloadFantasy=[],downloadYAF=[],downloadCrime=[],downloadSelfHelp=[];
  List reads =[];bool read=true; String result="Connected";
  bool loading=true;

  @override
  Widget build(BuildContext context) {
    _checkInternetConnectivity();
    firestoreInstance.collection("Users").doc(firebaseUser!.uid).get().then((value){
      setState(() {
        reads = value.data()!["Reads"];});
      read = (value.data()!["Reads"].isEmpty) ? false : true;
      if(value.data()!["Reads"]!=null){
        loading = false;}
    });
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    firestoreInstance.collection("Books").doc("Romance").get().then((value){
      setState(() {
        imageRomance = value.data()!["Image"];
        nameRomance = value.data()!["Name"];
        authorRomance = value.data()!["Author"];
        downloadRomance = value.data()!["Url"];
      });
    });
    firestoreInstance.collection("Books").doc("Young Adult Fiction").get().then((value){
      setState(() {
        imageYAF = value.data()!["Image"];
        nameYAF = value.data()!["Name"];
        authorYAF = value.data()!["Author"];
        downloadYAF = value.data()!["Url"];
      });
    });
    firestoreInstance.collection("Books").doc("Crime").get().then((value){
      setState(() {
        imageCrime = value.data()!["Image"];
        nameCrime= value.data()!["Name"];
        authorCrime = value.data()!["Author"];
        downloadCrime= value.data()!["Url"];
      });
    });
    firestoreInstance.collection("Books").doc("Adventure").get().then((value){
      setState(() {
        imageAdventure = value.data()!["Image"];
        nameAdventure = value.data()!["Name"];
        authorAdventure = value.data()!["Author"];
        downloadAdventure = value.data()!["Url"];
      });
    });
    firestoreInstance.collection("Books").doc("Self Help").get().then((value){
      setState(() {
        imageSelfHelp = value.data()!["Image"];
        nameSelfHelp = value.data()!["Name"];
        authorSelfHelp = value.data()!["Author"];
        downloadSelfHelp = value.data()!["Url"];
      });
    });
    firestoreInstance.collection("Books").doc("Fantasy").get().then((value){
      setState(() {
        imageFantasy = value.data()!["Image"];
        nameFantasy = value.data()!["Name"];
        authorFantasy = value.data()!["Author"];
        downloadFantasy = value.data()!["Url"];
      });
    });
    firestoreInstance.collection("Books").doc("Science Fiction").get().then((value){
      setState(() {
        imageScienceFiction = value.data()!["Image"];
        nameScienceFiction = value.data()!["Name"];
        authorScienceFiction = value.data()!["Author"];
        downloadScienceFiction = value.data()!["Url"];
      });
    });

    firestoreInstance.collection("Books").doc("Thriller").get().then((value){
      setState(() {
        imageThriller = value.data()!["Image"];
        nameThriller = value.data()!["Name"];
        authorThriller = value.data()!["Author"];
        downloadThriller = value.data()!["Url"];
      });
    });
    return internetCheck==false?loading==false?Scaffold(
        appBar: AppBar(
          title: Text("Library"),
          backgroundColor: Colors.orange.shade400,
        ),
        body: read?Container(
          height: height,
          width: width,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: reads.length,
            itemBuilder: (context, index) {
              late String img="",download,genre,author="";
              if(nameRomance.contains(reads[index])){
                int i=nameRomance.indexOf(reads[index]);
                img=imageRomance[i];
                genre="Romance";
                author=authorRomance[i];
                download=downloadRomance[i];}
              else if(nameAdventure.contains(reads[index])){
                int i=nameAdventure.indexOf(reads[index]);
                img=imageAdventure[i];
                genre="Adventure";
                author=authorAdventure[i];
                download=downloadAdventure[i];}
              else if(nameThriller.contains(reads[index])){
                int i=nameThriller.indexOf(reads[index]);
                img=imageThriller[i];
                genre="Thriller";
                author=authorThriller[i];
                download=downloadThriller[i];}
              if(nameScienceFiction.contains(reads[index])){
                int i=nameScienceFiction.indexOf(reads[index]);
                img=imageScienceFiction[i];
                genre="Science Fiction";
                author=authorScienceFiction[i];
                download=downloadScienceFiction[i];}
              else if(nameFantasy.contains(reads[index])){
                int i=nameFantasy.indexOf(reads[index]);
                img=imageFantasy[i];
                genre="Fantasy";
                author=authorFantasy[i];
                download=downloadFantasy[i];}
              else if(nameYAF.contains(reads[index])){
                int i=nameYAF.indexOf(reads[index]);
                img=imageYAF[i];
                genre="Young Adult Fiction";
                author=authorYAF[i];
                download=downloadYAF[i];}
              else if(nameCrime.contains(reads[index])){
                int i=nameCrime.indexOf(reads[index]);
                img=imageCrime[i];
                genre="Crime";
                author=authorCrime[i];
                download=downloadCrime[i];}
              else if(nameSelfHelp.contains(reads[index])){
                int i=nameSelfHelp.indexOf(reads[index]);
                img=imageSelfHelp[i];
                genre="Self Help";
                author=authorSelfHelp[i];
                download=downloadSelfHelp[i];}
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
                        image: img,
                        fit:BoxFit.cover,),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: [
                          Container(
                              width: width*0.5,
                              child: Text('${reads[index]}',textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 19
                                ),)),
                          Container(
                              width: width*0.5,
                            margin: EdgeInsets.only(top: 5),
                              child: Text(author,textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 17
                                ),)),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 5),
                            height: 33,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                              border: Border(left: BorderSide(color: Colors.black),right: BorderSide(color: Colors.black),top: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black), )
                            ),
                            child: Text(genre,textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.blue,
                                  fontSize: 16
                              ),),
                          )
                        ],
                      )
                    ],
                  ),
                  onTap: (){
                    String value=reads[index];
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Details(value:value,img: img,author:author,genre:genre,download: download,)));
                  },
                ),
              );
            },
          ),
        ):Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/libraryEmpty.png")
                )
              ),
            ),
            Text("Create your library now",style: TextStyle(
              fontSize: 20,
            ),),
          ],
        )
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
  @override
  void dispose() {
    super.dispose();
    reads;imageAdventure;authorRomance;
    read;nameThriller;authorScienceFiction;
    imageRomance;nameScienceFiction;authorThriller;
    imageScienceFiction;nameAdventure;authorAdventure;
    imageThriller;nameRomance;
    downloadRomance;downloadScienceFiction;
    downloadThriller;downloadAdventure;
  }
}
