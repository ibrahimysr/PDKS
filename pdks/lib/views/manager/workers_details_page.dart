import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/views/manager/worker_permissions_list.dart';

import 'package:pdks/views/manager/worker_shift_list.dart';
import 'package:pdks/widgets/mybutton.dart';

// ignore: must_be_immutable
class WorkersDetailPage extends StatelessWidget {
  Map<String, dynamic> userData;

  WorkersDetailPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
         
          backgroundColor:
        appcolor, 
        title: Text(
          "Kullanıcı Detayı",
          style: TextStyleClass.mainTitle.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userData["profileImageUrl"]),
                  radius: 35,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    userData["Ad_Soyad"].toString().toUpperCase(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30) ,
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: appcolor2, 
                borderRadius: BorderRadius.circular(15)
      
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Birim:",
                          style: TextStyleClass.mainContent
                              .copyWith(color: enabledColor),
                        ) ,
                        Text(
                          userData["Birim"],
                          style: TextStyleClass.mainContent.copyWith( 
                            color: Colors.black
                          )
                              
                        ) ,
                      ],
                    ), 
                    Row(
                      children: [
                        Text(
                          "Görev:",
                          style: TextStyleClass.mainContent
                              .copyWith(color: enabledColor),
                        ) ,
                        Text(
                          userData["Görev"],
                          style: TextStyleClass.mainContent.copyWith( 
                            color: Colors.black
                          )
                              
                        ) ,
                      ],
                    ),
                  ],
                ), 
                
              ),
            ),  
              const SizedBox(height: 20) ,
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: appcolor2, 
                borderRadius: BorderRadius.circular(15)
      
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Telefon No: ",
                          style: TextStyleClass.mainContent
                              .copyWith(color: enabledColor),
                        ) ,
                        Text(
                          userData["Telefon Numarası"],
                          style: TextStyleClass.mainContent.copyWith( 
                            color: Colors.black
                          )
                              
                        ) ,
                      ],
                    ), 
                   
                  ],
                ), 
                
              ),
            ),  
             const SizedBox(height: 20) ,
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: appcolor2, 
                borderRadius: BorderRadius.circular(15)
      
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Email: ",
                          style: TextStyleClass.mainContent
                              .copyWith(color: enabledColor),
                        ) ,
                        Text(
                          userData["Email"],
                          style: TextStyleClass.mainContent.copyWith( 
                            color: Colors.black
                          )
                              
                        ) ,
                      ],
                    ), 
                   
                  ],
                ), 
                
              ),
            ), 
             const SizedBox(height: 20) ,
             
            const SizedBox(height: 20,) ,
            myButton(() { 
              Navigator.push(context, MaterialPageRoute(builder: (context) => MesaiPage(mesaiList: userData["Mesai"],),));
            }, "Mesai Detayları"), 
            const SizedBox(height: 20,) ,
            myButton(() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WorkerShiftList(permissionlist: userData["İzinler"]),));
            }, "İzin Detayları"),
            
            const SizedBox(height: 20),
           
          ],
        ),
      ),
    );
  }
}
