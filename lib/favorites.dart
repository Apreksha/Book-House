import 'package:book_house/detail.dart';
import 'package:book_house/loadingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser=FirebaseAuth.instance.currentUser;
  List authorRomance = [],authorAdventure = [],authorThriller = [],authorScienceFiction =[],authorFantasy=[],authorYAF=[],authorCrime=[],authorSelfHelp=[];
  List imageRomance = [],imageScienceFiction = [],imageAdventure = [],imageThriller = [],imageFantasy=[],imageYAF=[],imageCrime=[],imageSelfHelp=[];
  List nameRomance = [],nameAdventure = [],nameThriller = [],nameScienceFiction =[],nameFantasy=[],nameYAF=[],nameCrime=[],nameSelfHelp=[];
  List downloadRomance = [],downloadAdventure = [],downloadThriller = [],downloadScienceFiction =[],downloadFantasy=[],downloadYAF=[],downloadCrime=[],downloadSelfHelp=[];
  List fav =[];bool favs=true;String result="Connected";

  bool loading=true;

  @override
  Widget build(BuildContext context) {
   _checkInternetConnectivity();
    firestoreInstance.collection("Users").doc(firebaseUser!.uid).get().then((value){
      setState(() {
        fav = value.data()!["Fav"];});
      favs = (value.data()!["Fav"].isEmpty) ? false : true;
      if(value.data()!["Fav"]!=null){
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
   firestoreInstance.collection("Books").doc("Self Help").get().then((value){
     setState(() {
       imageSelfHelp = value.data()!["Image"];
       nameSelfHelp = value.data()!["Name"];
       authorSelfHelp = value.data()!["Author"];
       downloadSelfHelp = value.data()!["Url"];
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
    firestoreInstance.collection("Books").doc("Crime").get().then((value){
      setState(() {
        imageCrime = value.data()!["Image"];
        nameCrime= value.data()!["Name"];
        authorCrime = value.data()!["Author"];
        downloadCrime= value.data()!["Url"];
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
    firestoreInstance.collection("Books").doc("Science Fiction").get().then((value){
      setState(() {
        imageScienceFiction = value.data()!["Image"];
        nameScienceFiction = value.data()!["Name"];
        authorScienceFiction = value.data()!["Author"];
        downloadScienceFiction = value.data()!["Url"];
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
          title: Text("Favorites"),
          backgroundColor: Colors.orange.shade400,
        ),
        body: favs?Container(
          height: height,
          width: width,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: fav.length,
            itemBuilder: (context, index) {
              late String img="",download,genre,author="";
              if(nameRomance.contains(fav[index])){
                int i=nameRomance.indexOf(fav[index]);
                img=imageRomance[i];
                genre="Romance";
                author=authorRomance[i];
                download=downloadRomance[i];}
              else if(nameAdventure.contains(fav[index])){
                int i=nameAdventure.indexOf(fav[index]);
                img=imageAdventure[i];
                genre="Adventure";
                author=authorAdventure[i];
                download=downloadAdventure[i];}
             else if(nameThriller.contains(fav[index])){
                int i=nameThriller.indexOf(fav[index]);
                img=imageThriller[i];
                genre="Thriller";
                author=authorThriller[i];
                download=downloadThriller[i];}
              else if(nameScienceFiction.contains(fav[index])){
                int i=nameScienceFiction.indexOf(fav[index]);
                img=imageScienceFiction[i];
                genre="Science Fiction";
                author=authorScienceFiction[i];
                download=downloadScienceFiction[i];}
              else if(nameFantasy.contains(fav[index])){
                int i=nameFantasy.indexOf(fav[index]);
                img=imageFantasy[i];
                genre="Fantasy";
                author=authorFantasy[i];
                download=downloadFantasy[i];}
              else if(nameYAF.contains(fav[index])){
                int i=nameYAF.indexOf(fav[index]);
                img=imageYAF[i];
                genre="Young Adult Fiction";
                author=authorYAF[i];
                download=downloadYAF[i];}
              else if(nameCrime.contains(fav[index])){
                int i=nameCrime.indexOf(fav[index]);
                img=imageCrime[i];
                genre="Crime";
                author=authorCrime[i];
                download=downloadCrime[i];}
              else if(nameSelfHelp.contains(fav[index])){
                int i=nameSelfHelp.indexOf(fav[index]);
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
                              child: Text('${fav[index]}',textAlign: TextAlign.left,)),
                          Container(
                              width: width*0.5,
                              child: Text(author,textAlign: TextAlign.left,)),
                        ],
                      )
                    ],
                  ),
                  onTap: (){
                    String value=fav[index];
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
                      image: AssetImage("assets/favoriteEmpty.png")
                  )
              ),
            ),
            Text("You have no favorites",style: TextStyle(
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
    fav;imageAdventure;authorRomance;
    favs;nameThriller;authorScienceFiction;
    imageRomance;nameScienceFiction;authorThriller;
    imageScienceFiction;nameAdventure;authorAdventure;
    imageThriller;nameRomance;
    downloadRomance;downloadScienceFiction;
    downloadThriller;downloadAdventure;
  }
}