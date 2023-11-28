// ignore_for_file: non_constant_identifier_names, unused_import, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServer extends ChangeNotifier {
//instance of auth

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// instance of firestore

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //sign user in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

          //add new user document
           _fireStore.collection('users').doc(userCredential.user!.uid).set(
        {
          "uid":userCredential.user!.uid,
          "email":email,
        },
        SetOptions(merge: true)
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//create account

  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      //after creating na new user ,create a document for new user

      _fireStore.collection('users').doc(userCredential.user!.uid).set(
        {
          "uid":userCredential.user!.uid,
          "email":email,
        }
      );

      return userCredential;
      //catch error
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign user out

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

//create account
}
