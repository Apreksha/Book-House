import 'package:book_house/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser=FirebaseAuth.instance.currentUser;
List authorRomance = [],authorAdventure = [],authorThriller = [],authorScienceFiction =[],authorFantasy=[],authorYAF=[],authorCrime=[],authorSelfHelp=[];
List imageRomance = [],imageScienceFiction = [],imageAdventure = [],imageThriller = [],imageFantasy=[],imageYAF=[],imageCrime=[],imageSelfHelp=[];
List nameRomance = [],nameAdventure = [],nameThriller = [],nameScienceFiction =[],nameFantasy=[],nameYAF=[],nameCrime=[],nameSelfHelp=[];
List downloadRomance = [],downloadAdventure = [],downloadThriller = [],downloadScienceFiction =[],downloadFantasy=[],downloadYAF=[],downloadCrime=[],downloadSelfHelp=[];
List search =[],books=[],recent=[];
  late String bookName="";

class DataSearch extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query="";
      Navigator.of(context).pop();
    })];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon:AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ), onPressed: (){
      close(context,"");
    });
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    firestoreInstance.collection("Books").doc("Romance").get().then((value){
      imageRomance = value.data()!["Image"];
      nameRomance = value.data()!["Name"];
      authorRomance = value.data()!["Author"];
      downloadRomance = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Crime").get().then((value){
        imageCrime = value.data()!["Image"];
        nameCrime= value.data()!["Name"];
        authorCrime = value.data()!["Author"];
        downloadCrime= value.data()!["Url"];
      });
    firestoreInstance.collection("Books").doc("Young Adult Fiction").get().then((value){
        imageYAF = value.data()!["Image"];
        nameYAF = value.data()!["Name"];
        authorYAF = value.data()!["Author"];
        downloadYAF = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Adventure").get().then((value){
        imageAdventure = value.data()!["Image"];
        nameAdventure = value.data()!["Name"];
        authorAdventure = value.data()!["Author"];
        downloadAdventure = value.data()!["Url"];
      });
    firestoreInstance.collection("Books").doc("Fantasy").get().then((value){
        imageFantasy = value.data()!["Image"];
        nameFantasy = value.data()!["Name"];
        authorFantasy = value.data()!["Author"];
        downloadFantasy = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Science Fiction").get().then((value){
        imageScienceFiction = value.data()!["Image"];
        nameScienceFiction = value.data()!["Name"];
        authorScienceFiction = value.data()!["Author"];
        downloadScienceFiction = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Self Help").get().then((value){
      imageSelfHelp = value.data()!["Image"];
      nameSelfHelp = value.data()!["Name"];
      authorSelfHelp = value.data()!["Author"];
      downloadSelfHelp = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Thriller").get().then((value){
        imageThriller = value.data()!["Image"];
        nameThriller = value.data()!["Name"];
        authorThriller = value.data()!["Author"];
        downloadThriller = value.data()!["Url"];
    });
    books=nameRomance+nameAdventure+nameThriller+nameScienceFiction+nameYAF+nameFantasy+nameCrime+nameSelfHelp;
    final suggestionList=query.isEmpty
        ?recent
        :books.where((p) =>
        p.contains(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index)=>ListTile(
          onTap: (){
            bookName=suggestionList[index];
            showResults(context);
            if(nameRomance.contains(bookName)){
              int i=nameRomance.indexOf(bookName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(value:bookName,img: imageRomance[i],author:authorRomance[i],genre:"Romance",download: downloadRomance[i],)));
            }
            else if(nameAdventure.contains(bookName)){
              int i=nameAdventure.indexOf(bookName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(value:bookName,img: imageAdventure[i],author:authorAdventure[i],genre:"Adventure",download: downloadAdventure[i],)));
            }
            else if(nameScienceFiction.contains(bookName)){
              int i=nameScienceFiction.indexOf(bookName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(value:bookName,img: imageScienceFiction[i],author:authorScienceFiction[i],genre:"Science Fiction",download: downloadScienceFiction[i],)));
            }
            else if(nameThriller.contains(bookName)){
              int i=nameThriller.indexOf(bookName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(value:bookName,img: imageThriller[i],author:authorThriller[i],genre:"Thriller",download: downloadThriller[i],)));
            }
            else if(nameFantasy.contains(bookName)){
              int i=nameFantasy.indexOf(bookName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(value:bookName,img: imageFantasy[i],author:authorFantasy[i],genre:"Fantasy",download: downloadFantasy[i],)));
            }
            else if(nameYAF.contains(bookName)){
              int i=nameYAF.indexOf(bookName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(value:bookName,img: imageYAF[i],author:authorYAF[i],genre:"Young Adult Fiction",download: downloadYAF[i],)));
            }
            else if(nameCrime.contains(bookName)){
              int i=nameCrime.indexOf(bookName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(value:bookName,img: imageCrime[i],author:authorCrime[i],genre:"Crime",download: downloadCrime[i],)));
            }
            else if(nameSelfHelp.contains(bookName)){
              int i=nameSelfHelp.indexOf(bookName);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(value:bookName,img: imageSelfHelp[i],author:authorSelfHelp[i],genre:"Self Help",download: downloadSelfHelp[i],)));
            }
          },
          leading: Icon(Icons.library_books),
          title: RichText(
            text:TextSpan(
                text:suggestionList[index].substring(0,query.length),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey)
                  )
                ]
            ),
          )
      ),
      itemCount: suggestionList.length,
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    firestoreInstance.collection("Books").doc("Romance").get().then((value){
      imageRomance = value.data()!["Image"];
      nameRomance = value.data()!["Name"];
      authorRomance = value.data()!["Author"];
      downloadRomance = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Young Adult Fiction").get().then((value){
        imageYAF = value.data()!["Image"];
        nameYAF = value.data()!["Name"];
        authorYAF = value.data()!["Author"];
        downloadYAF = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Adventure").get().then((value){
      imageAdventure = value.data()!["Image"];
      nameAdventure = value.data()!["Name"];
      authorAdventure = value.data()!["Author"];
      downloadAdventure = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Crime").get().then((value){
      imageCrime = value.data()!["Image"];
      nameCrime= value.data()!["Name"];
      authorCrime = value.data()!["Author"];
      downloadCrime= value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Science Fiction").get().then((value){
      imageScienceFiction = value.data()!["Image"];
      nameScienceFiction = value.data()!["Name"];
      authorScienceFiction = value.data()!["Author"];
      downloadScienceFiction = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Self Help").get().then((value){
      imageSelfHelp = value.data()!["Image"];
      nameSelfHelp = value.data()!["Name"];
      authorSelfHelp = value.data()!["Author"];
      downloadSelfHelp = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Fantasy").get().then((value){
        imageFantasy = value.data()!["Image"];
        nameFantasy = value.data()!["Name"];
        authorFantasy = value.data()!["Author"];
        downloadFantasy = value.data()!["Url"];
    });
    firestoreInstance.collection("Books").doc("Thriller").get().then((value){
      imageThriller = value.data()!["Image"];
      nameThriller = value.data()!["Name"];
      authorThriller = value.data()!["Author"];
      downloadThriller = value.data()!["Url"];
    });
    books=nameRomance+nameAdventure+nameThriller+nameScienceFiction+nameFantasy+nameYAF+nameCrime+nameSelfHelp;

    final suggestionList=query.isEmpty
        ?recent
        :books.where((p) =>
        p.contains(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index)=>ListTile(
          onTap: (){
            bookName=suggestionList[index];
            showResults(context);
          },
          leading: Icon(Icons.library_books),
          title: RichText(
            text:TextSpan(
                text:suggestionList[index].substring(0,query.length),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey)
                  )
                ]
            ),
          )
      ),
      itemCount: suggestionList.length,
    );
    throw UnimplementedError();
  }
}