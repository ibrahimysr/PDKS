import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';

class MesaiPage extends StatelessWidget {
  final List<dynamic> mesaiList;

  const MesaiPage({super.key, required this.mesaiList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
        title:  Text('Mesai Detayları',style: TextStyleClass.mainContent,),
        centerTitle: true, 
       
          backgroundColor:
        appcolor
        
      ),
      body: ListView.builder(
        itemCount: mesaiList.length,
        itemBuilder: (context, index) {
          final mesaiData = mesaiList[index];
          return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Tarih: ",
                                        style: TextStyleClass.mainContent.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        mesaiData["tarih"],
                                        style: TextStyleClass.mainContent.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ), 
                                  
                                ],
                              ),
                            ),
                          
                           
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 8,bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Giriş Saati: ",
                                            style: TextStyleClass.mainContent,
                                          ),
                                          Text(
                                             mesaiData["giris_saati"].toString(),
                                            style: TextStyleClass.mainContent,
                                          ),
                                        ],
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                          children: [
                                            Text(
                                              "Çıkış Saati: ",
                                              style: TextStyleClass.mainContent,
                                            ),
                                            Text(
                                               mesaiData["bitis_saati"].toString(),
                                              style: TextStyleClass.mainContent,
                                            ), 
                                            
                                          ],
                                        ),
                                    ),
                                    ],
                                  ),
                                   Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Toplam Mesai Saati: ",
                                        style: TextStyleClass.mainContent.copyWith(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        mesaiData["toplam_calisma_suresi"],
                                        style: TextStyleClass.mainContent.copyWith(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
        },
      ),
    );
  }
}
