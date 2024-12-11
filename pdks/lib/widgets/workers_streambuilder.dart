import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/views/manager/workers_details_page.dart';

class WorkersStreamBuilder extends StatelessWidget {
  const WorkersStreamBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
     
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('Role', isEqualTo: 'Çalışan')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Bir Bilgi Bulunamadı"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final userData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
      
                final profileImageUrl =
                    userData["profileImageUrl"] ?? ""; // Profil resmi URL'si
                final adSoyad = userData["Ad_Soyad"] ?? ""; // Ad ve Soyad
                final birim = userData["Birim"] ?? ""; // Kullanıcının birimi
                final gorev = userData["Görev"] ?? ""; // Kullanıcının görevi
      
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WorkersDetailPage(userData: userData),
                          ));
                    },
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_sharp,
                              color: enabledColor,
                            )),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profileImageUrl),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            adSoyad,
                            style: TextStyleClass.mainContent.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Birim: ",
                                    style: TextStyleClass.mainContent,
                                  ),
                                  Text(
                                    birim,
                                    style: TextStyleClass.mainContent,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Text(
                                    "Görev: ",
                                    style: TextStyleClass.mainContent,
                                  ),
                                  Text(
                                    gorev,
                                    style: TextStyleClass.mainContent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
