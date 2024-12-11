import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdks/views/worker/worker_controller_page.dart';

class ShiftService {

 Stream<DocumentSnapshot> getShift(String userId) {
    final DocumentReference userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId);

    return userDoc.snapshots();
  }

  static Future<void> checkQRCode(BuildContext context, String scannedData, bool enabled) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('sifre');
    DocumentSnapshot doc = await ref.doc('qrCode').get();

    if (doc.exists) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        String firestoreData = data['value'] ?? '';
        if (scannedData == firestoreData) {
          enabled
              ? await addMesai(context, user!)
              : await updateMesaiExitTime(context, user!);
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WorkerControlPage()),
            );
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('İşlem başarısız')),
            );
          }
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Belirtilen doküman boş.')),
          );
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Belirtilen doküman bulunamadı.')),
        );
      }
    }
  }

  static Future<void> addMesai(BuildContext context, User user) async {
    try {
      String userId = user.uid;

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("Mesai");

      DocumentReference userDoc =
          FirebaseFirestore.instance.collection("Users").doc(userId);
      DateTime currentDate = DateTime.now();
      String currentDateString =
          "${currentDate.day} - ${currentDate.month} - ${currentDate.year}";
      String time = "${currentDate.hour}:${currentDate.minute}";
      Map<String, dynamic> task = {
        "tarih": currentDateString,
        "giris_saati": time,
        "bitis_saati": "",
        "toplam_calisma_suresi": ""
      };
      await userDoc.update({
        "Mesai": FieldValue.arrayUnion([task])
      });
    } catch (e) {
      debugPrint("Beklenmedik bir hata oluştu. Lütfen tekrar deneyin.");
    }
  }

  static Future<void> updateMesaiExitTime(BuildContext context, User user) async {
    try {
      String userId = user.uid;

      CollectionReference userCollection = FirebaseFirestore.instance
          .collection("Users");

      DocumentReference userDoc = userCollection.doc(userId);

      DocumentSnapshot userSnapshot = await userDoc.get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      List<dynamic> mesaiList = userData['Mesai'];

      DateTime now = DateTime.now();
      String currentDate = "${now.day} - ${now.month} - ${now.year}";
      String exitTime = "${now.hour}:${now.minute}";

      List<dynamic> updatedMesaiList = mesaiList.map((mesai) {
        if (mesai['tarih'] == currentDate) {
          mesai['bitis_saati'] = exitTime;
          
          // Çalışma süresini hesaplama
          final entryTime = DateTime(
            now.year, now.month, now.day, 
            int.parse(mesai['giris_saati'].split(":")[0]), 
            int.parse(mesai['giris_saati'].split(":")[1])
          );
          final duration = now.difference(entryTime);
          final totalHours = duration.inHours;
          final totalMinutes = duration.inMinutes % 60;
          final totalDuration = "$totalHours saat, $totalMinutes dakika";

          mesai['toplam_calisma_suresi'] = totalDuration;
        }
        return mesai;
      }).toList();

      await userDoc.update({
        "Mesai": updatedMesaiList,
      });
    } catch (e) {
      debugPrint("Beklenmedik bir hata oluştu. Hata: $e");
    }
  }
   Future<Map<String, double>> getMonthlyWorkHours() async {
    final usersSnapshot = await FirebaseFirestore.instance.collection('Users').get();
    final currentDate = DateTime.now();
    final startOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final endOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

    Map<String, double> workHours = {};

    for (var doc in usersSnapshot.docs) {
      
      final userData = doc.data();
      final mesaiList = userData['Mesai'] as List<dynamic>;

      double totalHours = 0.0;

      for (var mesai in mesaiList) {
        final tarihParts = (mesai['tarih'] as String).split(' - ');
        final tarih = DateTime(
          int.parse(tarihParts[2]),
          int.parse(tarihParts[1]),
          int.parse(tarihParts[0]),
        );

        if (tarih.isAfter(startOfMonth) && tarih.isBefore(endOfMonth)) {
          final calismaSuresiParts = (mesai['toplam_calisma_suresi'] as String).split(' ');
          final hours = double.parse(calismaSuresiParts[0]);
          final minutes = double.parse(calismaSuresiParts[2]);

          totalHours += hours + (minutes / 60.0);
        }
      }

      final userName = userData['Ad_Soyad'] as String;
      workHours[userName] = totalHours;
    }

    return workHours;
  }
}
