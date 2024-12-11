import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PermissionService { 
  Stream<DocumentSnapshot> getPermission(String userId) {
    final DocumentReference userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId);

    return userDoc.snapshots();
  }

  Future<void> addPermission(BuildContext context, String userId, String permissionType, String startingDate, String endDate, String reason, String address) async {
    try {
      // Generate a unique permission ID
      final permissionId = FirebaseFirestore.instance.collection('Permissions').doc().id;

      // Fetch the user's full name
      final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
      final userData = userDoc.data() as Map<String, dynamic>;
      final userFullName = userData['Ad_Soyad'] ?? '';

      final permission = {
        "permissionId": permissionId,
        "userId": userId,
        "Ad_Soyad": userFullName, // Add the full name to the permission record
        "İzin Tipi": permissionType,
        "İzin Başlangıç": startingDate,
        "İzin Bitiş": endDate,
        "İzin Sebebi": reason,
        "İzin Adres": address,
        "İzin Durumu": "Beklemede",
      };

      // Update the user's document with the new permission
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update({
        "İzinler": FieldValue.arrayUnion([permission])
      });

      // Add the permission to the general Permissions collection
      await FirebaseFirestore.instance
          .collection('Permissions')
          .doc(permissionId)
          .set(permission);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("İzin Talebi Gönderildi")),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hata: $e")),
        );
      }
    }
  }

  Future<void> updatePermissionStatus(BuildContext context, String permissionId, String userId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('Permissions')
          .doc(permissionId)
          .update({"İzin Durumu": newStatus});

      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      final userData = userDoc.data() as Map<String, dynamic>;
      final permissions = List<Map<String, dynamic>>.from(userData["İzinler"]);

      for (var permission in permissions) {
        if (permission["permissionId"] == permissionId) {
          permission["İzin Durumu"] = newStatus;
        }
      }

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update({"İzinler": permissions});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("İzin durumu güncellendi")),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hata: $e")),
        );
      }
    }
  } 
  
}


