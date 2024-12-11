import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _currentUser;

  UserService() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  User? get currentUser => _currentUser; 

   Stream<DocumentSnapshot> getUsers(String userId) {
    final DocumentReference userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId);

    return userDoc.snapshots();
  }
}