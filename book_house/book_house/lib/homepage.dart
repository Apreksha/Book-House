import 'package:book_house/Crime.dart';
import 'package:book_house/adventure.dart';
import 'package:book_house/detail.dart';
import 'package:book_house/fantasy.dart';
import 'package:book_house/favorites.dart';
import 'package:book_house/library.dart';
import 'package:book_house/loadingScreen.dart';
import 'package:book_house/login.dart';
import 'package:book_house/romance.dart';
import 'package:book_house/science%20fiction.dart';
import 'package:book_house/search.dart';
import 'package:book_house/selfhelp.dart';
import 'package:book_house/thriller.dart';
import 'package:book_house/yaf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final firestoreInstance = FirebaseFirestore.instance;
  List mightLike = ["Pride and Prejudice","Alice in Wonderland","Origin","The Hunger Games"];
  int currentPage = 0;  List reads=[];String name=""; late bool read;
  List authorRomance = [],authorAdventure = [],authorThriller = [],authorScienceFiction =[],authorFantasy=[],authorYAF=[],authorCrime=[],authorSelfHelp=[];
  List imageRomance = [],imageScienceFiction = [],imageAdventure = [],imageThriller = [],imageFantasy=[],imageYAF=[],imageCrime=[],imageSelfHelp=[];
  List nameRomance = [],nameAdventure = [],nameThriller = [],nameScienceFiction =[],nameFantasy=[],nameYAF=[],nameCrime=[],nameSelfHelp=[];
  List downloadRomance = [],downloadAdventure = [],downloadThriller = [],downloadScienceFiction =[],downloadFantasy=[],downloadYAF=[],downloadCrime=[],downloadSelfHelp=[];
  final CollectionReference users = FirebaseFirestore.instance.collection(
      "Books");
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String result="Connected";
bool loading = true;
  @override
  Widget build(BuildContext context) {
    _checkInternetConnectivity();
    firestoreInstance.collection("Users").doc(firebaseUser!.uid).get().then((
        value) {
      setState(() {
        reads = value.data()!["Reads"];
        read = (value.data()!["Reads"].isEmpty) ? false : true;
      });
    });

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

    firestoreInstance.collection("Books").doc("Science Fiction").get().then((value){
      setState(() {
        imageScienceFiction = value.data()!["Image"];
        nameScienceFiction = value.data()!["Name"];
        authorScienceFiction = value.data()!["Author"];
        downloadScienceFiction = value.data()!["Url"];
      });
    });
    firestoreInstance.collection("Books").doc("Crime").get().then((value){
      setState(() {
        imageCrime = value.data()!["Image"];
        nameCrime = value.data()!["Name"];
        authorCrime = value.data()!["Author"];
        downloadCrime = value.data()!["Url"];
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
    firestoreInstance.collection("Books").doc("Young Adult Fiction").get().then((value){
      setState(() {
        imageYAF = value.data()!["Image"];
        nameYAF = value.data()!["Name"];
        authorYAF = value.data()!["Author"];
        downloadYAF = value.data()!["Url"];
        if(value.data()!["Image"] != null){
        loading = false;}
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
    return internetCheck==false?loading==false?Scaffold(
              appBar: AppBar(
                title: Text("Welcome"),
                backgroundColor: Colors.orange.shade400,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                  )
                ],),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentPage,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                      backgroundColor: Colors.orange.shade400),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.library_books),
                      label: "Library",
                      backgroundColor: Colors.orange.shade400),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: "Favorites",
                      backgroundColor: Colors.orange.shade400),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.logout),
                      label: "Logout",
                      backgroundColor: Colors.orange.shade400),
                ],
                onTap: (currentPage) async {
                  if (currentPage == 1) {
                    Navigator.of(context)
                        .push(
                        MaterialPageRoute(builder: (context) => Library()));
                  }
                  if (currentPage == 2) {
                    Navigator.of(context)
                        .push(
                        MaterialPageRoute(builder: (context) => Favorites()));
                  }
                  if (currentPage == 3) {
                    return showDialog(context: context,builder: (BuildContext context){
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 170,
                                child: Column(
                                  children: [
                                    SizedBox(height:70),
                                    Text("Do you want to logout?",
                                    style: TextStyle(
                                      fontSize: 20
                                    ),),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () async{
                                              final SharedPreferences sha = await SharedPreferences
                                                  .getInstance();
                                              sha.setBool('remember', false);
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(builder: (context) => Login()));
                                            },
                                            child: Text("Yes",
                                              style: TextStyle(
                                                  fontSize: 20
                                              ),)),
                                        TextButton(
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No",
                                              style: TextStyle(
                                                  fontSize: 20
                                              ),)),
                                      ],
                                    ),
                                  ],
                                )
                            ),
                            Positioned(
                              top: -60,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 60,
                                  child: Image.asset("assets/log out.png",height: 100,),
                                ))
                          ],
                        ),
                      );
                    });


                  }
                },
              ),
              //continue reading
              body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //Romance
                          Row(children: [Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Romance", textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.48,),
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  child: Text(
                                    "See All", textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) => Romance()));
                                  },)),
                          ]),
                          //_romance()
                          Container(
                            height: 190,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: GestureDetector(
                                    child: Container(
                                      child: FadeInImage.assetNetwork(
                                        width: 135,
                                        placeholder: 'assets/placeholder.png',
                                        image: imageRomance[index],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details(
                                                      value: nameRomance[index],
                                                      img: imageRomance[index],
                                                      author: authorRomance[index],
                                                      genre: "Romance",
                                                      download: downloadRomance[index])));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          //Adventure
                          Row(children: [Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Adventure", textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.45,),
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  child: Text(
                                    "See All", textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) => Adventure()));
                                  },)),
                          ]),
                          Container(
                            height: 190,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 150,
                                  child: GestureDetector(
                                    child: FadeInImage.assetNetwork(
                                      width: 135,
                                      placeholder: 'assets/placeholder.png',
                                      image: imageAdventure[index],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details(
                                                      value: nameAdventure[index],
                                                      img: imageAdventure[index],
                                                      author: authorAdventure[index],
                                                      genre: "Adventure",
                                                      download: downloadAdventure[index])));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          //Thriller
                          Row(children: [Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Thriller", textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.53,),
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  child: Text(
                                    "See All", textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) => Thriller()));
                                  },)),
                          ]),
                          Container(
                            height: 190,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 150,
                                  child: GestureDetector(
                                    child: FadeInImage.assetNetwork(
                                      width: 135,
                                      placeholder: 'assets/placeholder.png',
                                      image: imageThriller[index],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details(
                                                      value: nameThriller[index],
                                                      img: imageThriller[index],
                                                      author: authorThriller[index],
                                                      genre: "Thriller",
                                                      download: downloadThriller[index])));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          //Science Fiction
                          Row(children: [Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Science Fiction", textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.333,),
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  child: Text(
                                    "See All", textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                            Science_Fiction()));
                                  },)),
                          ]),
                          Container(
                            height: 190,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 150,
                                  child: GestureDetector(
                                    child: FadeInImage.assetNetwork(
                                      width: 135,
                                      placeholder: 'assets/placeholder.png',
                                      image: imageScienceFiction[index],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details(
                                                      value: nameScienceFiction[index],
                                                      img: imageScienceFiction[index],
                                                      author: authorScienceFiction[index],
                                                      genre: "Science Fiction",
                                                      download: downloadScienceFiction[index])));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          //fantasy
                          Row(children: [Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Fantasy", textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.51,),
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  child: Text(
                                    "See All", textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                            Fantasy()));
                                  },)),
                          ]),
                          Container(
                            height: 190,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 150,
                                  child: GestureDetector(
                                    child: FadeInImage.assetNetwork(
                                      width: 135,
                                      placeholder: 'assets/placeholder.png',
                                      image: imageFantasy[index],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details(
                                                      value: nameFantasy[index],
                                                      img: imageFantasy[index],
                                                      author: authorFantasy[index],
                                                      genre: "Fantasy",
                                                      download: downloadFantasy[index])));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          //young adult fiction
                          Row(children: [Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Young Adult Fiction", textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,),
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  child: Text(
                                    "See All", textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                            YAF()));
                                  },)),
                          ]),
                          Container(
                            height: 190,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 150,
                                  child: GestureDetector(
                                    child: FadeInImage.assetNetwork(
                                      width: 135,
                                      placeholder: 'assets/placeholder.png',
                                      image: imageYAF[index],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details(
                                                      value: nameYAF[index],
                                                      img: imageYAF[index],
                                                      author: authorYAF[index],
                                                      genre: "Young Adult Fiction",
                                                      download: downloadYAF[index])));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(children: [Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Crime", textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.56,),
                            Padding(
                              //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.0),
                                padding: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  child: Text(
                                    "See All", textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) => Crime()));
                                  },)),
                          ]),
                          //_romance()
                          Container(
                            height: 190,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: GestureDetector(
                                    child: Container(
                                      child: FadeInImage.assetNetwork(
                                        width: 135,
                                        placeholder: 'assets/placeholder.png',
                                        image: imageCrime[index],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details(
                                                      value: nameCrime[index],
                                                      img: imageCrime[index],
                                                      author: authorCrime[index],
                                                      genre: "Crime",
                                                      download: downloadCrime[index])));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(children: [Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Self Help", textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.48,),
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextButton(
                                  child: Text(
                                    "See All", textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) => SelfHelp()));
                                  },)),
                          ]),
                          //_romance()
                          Container(
                            height: 190,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: ListView.builder(
                              itemCount: 4,
                                scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: GestureDetector(
                                    child: Container(
                                      child: FadeInImage.assetNetwork(
                                        width: 135,
                                        placeholder: 'assets/placeholder.png',
                                        image: imageSelfHelp[index],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details(
                                                      value: nameSelfHelp[index],
                                                      img: imageSelfHelp[index],
                                                      author: authorSelfHelp[index],
                                                      genre: "Self Help",
                                                      download: downloadSelfHelp[index])));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                  )
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
  void ChangeValue(String resultValue) {
    setState(() {
      result=resultValue;
    });
  }
}
