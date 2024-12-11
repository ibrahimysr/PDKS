import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdks/views/login.dart';
import 'package:pdks/views/manager/manager_home_page.dart';
import 'package:pdks/views/worker/worker_controller_page.dart';



class FlutterFireAuthService {
  final FirebaseAuth _firebaseauth;
  FlutterFireAuthService(this._firebaseauth);

  Stream<User?> get authStateChanges => _firebaseauth.idTokenChanges();

  Future<void> passwordReset(String email, BuildContext context) async {
    try {
      await _firebaseauth.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        showErrorDialog(context, "Bilgi", "Sıfırlama Linki Gönderildi. E-postanızı kontrol ediniz");
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showErrorDialog(context, "Hata", e.message.toString());
      }
    }
  }

  Future<String> signUp(
      String email,
      String password,
      String username,
      String phoneNumber,
      String unit,
      String task,
      BuildContext context) async {
    try {
      UserCredential userCredential = await _firebaseauth
          .createUserWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("Users").doc(userId).set({
        "Email": email,
        "Ad_Soyad": username,
        "Telefon Numarası": phoneNumber,
        "Birim": unit,
        "Görev": task,
        "İzinler": [],
        "Mesai": [],
        "Role": "Çalışan"
      });

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Bir hata oluştu";
    }
  }

   Future<String> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _firebaseauth.signInWithEmailAndPassword(
          email: email, password: password);
      String userId = userCredential.user!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("Users").doc(userId).get();

      String role = userDoc["Role"];

      if (context.mounted) {
        if (role == "Yönetici") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>const ManagerHomePage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkerControlPage(),
            ),
          );
        }
      }

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showErrorDialog(context, "Hata", "Kullanıcı adı veya şifre hatalı");
      }
      return e.message ?? "Bir hata oluştu";
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _firebaseauth.signOut();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
}



 void showErrorDialog(BuildContext context,String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
