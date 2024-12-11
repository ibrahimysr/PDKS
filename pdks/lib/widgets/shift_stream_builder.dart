import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdks/service/shift_service.dart';
import 'package:pdks/service/user_service.dart';
import 'package:pdks/style/textstyle.dart';


import 'package:provider/provider.dart';


class ShiftStreamBuilder extends StatelessWidget {
  const ShiftStreamBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ShiftService shiftService = ShiftService();
    final userProvider = Provider.of<UserService>(context);
    final currentUser = userProvider.currentUser;
            List<Map<String, dynamic>> shifts;


    return Scaffold(
    
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: shiftService.getShift(currentUser!.uid.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Hata: ${snapshot.error}'));
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text("Bir Bilgi Bulunamadı"));
                } else {
                  final userData = snapshot.data!.data() as Map<String, dynamic>;
                   shifts = List<Map<String, dynamic>>.from(userData['Mesai'] ?? []);
            
                  if (shifts.isEmpty) {
                    return const Center(child: Text("Bir Bilgi Bulunamadı"));
                  }
            
                  return ListView.builder(
                    itemCount: shifts.length,
                    itemBuilder: (context, index) {
                      final shift = shifts[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color:Colors.white,
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Tarih: ",
                                    style: TextStyleClass.mainContent.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    shift["tarih"],
                                    style: TextStyleClass.mainContent.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                           
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 8,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Giriş Saati: ",
                                        style: TextStyleClass.mainContent,
                                      ),
                                      Text(
                                        shift["giris_saati"].toString(),
                                        style: TextStyleClass.mainContent,
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Row(
                                      children: [
                                        Text(
                                          "Çıkış Saati: ",
                                          style: TextStyleClass.mainContent,
                                        ),
                                        Text(
                                          shift["bitis_saati"].toString(),
                                          style: TextStyleClass.mainContent,
                                        ),
                                      ],
                                    ),
                                ),
                                ],
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
          ),
          
        ],
      ),
    );
  }
}
