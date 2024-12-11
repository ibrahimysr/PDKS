import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/views/manager/public_permissions_detail_page.dart';


class PermissionsListPage extends StatelessWidget {
  const PermissionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
         
          backgroundColor:
              appcolor ,
        title: Text('Tüm İzinler',style: TextStyleClass.mainContent),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Permissions').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("İzinler bulunamadı"));
          } else {
            final permissions = snapshot.data!.docs;
      
            return ListView.builder(
              itemCount: permissions.length,
              itemBuilder: (context, index) {
                final permission = permissions[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PublicPermissionDetailPage(
                          permissionId: permissions[index].id,
                          userId: permission["userId"], permission: permission,
                        ),
                      ),
                    );
                    },
                    child: Container(
                            decoration:BoxDecoration( 
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ) , 
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Kişi: ",
                                style: TextStyleClass.mainContent.copyWith(
                                  color: enabledColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                permission["Ad_Soyad"],
                                style: TextStyleClass.mainContent.copyWith(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "Başlama Tarihi",
                            style: TextStyleClass.mainContent.copyWith(
                              color: enabledColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            permission["İzin Başlangıç"],
                            style: TextStyleClass.mainContent.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Bitiş Tarihi",
                            style: TextStyleClass.mainContent.copyWith(
                              color: enabledColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            permission["İzin Bitiş"],
                            style: TextStyleClass.mainContent.copyWith(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            permission["İzin Durumu"],
                            style: TextStyleClass.mainContent.copyWith(
                              color: enabledColor,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            size: 30,
                            permission["İzin Durumu"] == "Beklemede"
                                ? Icons.access_time_filled_rounded
                                : permission["İzin Durumu"] == "Onaylandı"
                                    ? Icons.check
                                    : permission["İzin Durumu"] == "Reddedildi"
                                        ? Icons.cancel
                                        : Icons.help_outline,
                            color: permission["İzin Durumu"] == "Beklemede"
                                ? Colors.yellow
                                : permission["İzin Durumu"] == "Onaylandı"
                                    ? Colors.green
                                    : permission["İzin Durumu"] == "Reddedildi"
                                        ? Colors.red
                                        : Colors.grey,
                          ),
                        ],
                      )
                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                );
          
              },
            );
          }
        },
      ),
    );
  }
}
