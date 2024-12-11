import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdks/service/permission_service.dart';
import 'package:pdks/service/user_service.dart';
import 'package:pdks/style/color.dart';

import 'package:pdks/widgets/permissions_card.dart';
import 'package:provider/provider.dart';

class PermissionStreamBuilder extends StatelessWidget {
  const PermissionStreamBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PermissionService shiftService = PermissionService();
    final userProvider = Provider.of<UserService>(context);
    final currentUser = userProvider.currentUser;
    List<Map<String, dynamic>> permissions;

    return Scaffold(
      backgroundColor: appcolor,
      body: Container(
        decoration: BoxDecoration(color: appcolor),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                stream: shiftService.getPermission(currentUser!.uid.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Hata: ${snapshot.error}'));
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text("Bir Bilgi Bulunamadı"));
                  } else {
                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    permissions = List<Map<String, dynamic>>.from(
                        userData['İzinler'] ?? []);
        
                    if (permissions.isEmpty) {
                      return const Center(child: Text("Bir Bilgi Bulunamadı"));
                    }
        
                    return ListView.builder(
                      itemCount: permissions.length,
                      itemBuilder: (context, index) {
                        final permission = permissions[index];
                        return PermissionCard(permission: permission);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
