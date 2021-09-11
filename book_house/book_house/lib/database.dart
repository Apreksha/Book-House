import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  final String uid;
  Database({required this.uid});
  final CollectionReference users=FirebaseFirestore.instance.collection("Users");
  Future updateUserData(String email,String userName,var phone,bool emailVerified,bool phoneVerified,List reads,List favList) async{
    return await users.doc(uid).set({
      'Email': email,
      'Username': userName,
      'emailVerified':emailVerified,
      'Phone':phone,
      'phoneVerified':phoneVerified,
      'Reads':reads,
      'Fav':favList,
    });
  }
  Future UserDataDelete(uid) async{
  return await users.doc(uid).delete();
  }
  Future getBookUrl(String bookName) async {
    return await users.doc(uid).get().then((value) {
      value.data();
    });
  }
  Future updateVerified(bool verify) async{
    return await users.doc(uid).update({
      'emailVerified':verify,
    });
  }
}