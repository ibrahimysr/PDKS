import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';


class WorkerShiftList extends StatelessWidget {
  final List<dynamic> permissionlist;

  const WorkerShiftList({super.key, required this.permissionlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
        title: Text('İzin Detayları',style: TextStyleClass.mainContent),
        centerTitle: true, 
       
          backgroundColor:
              appcolor
      ),
      body: ListView.builder(
        itemCount: permissionlist.length,
        itemBuilder: (context, index) {
          final permissionData = permissionlist[index];
          return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color:Colors.white, 
          borderRadius: BorderRadius.circular(15)
        ), 
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
                            "Tipi: ",
                            style: TextStyleClass.mainContent.copyWith(
                              color: enabledColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            permissionData["İzin Tipi"],
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
                        permissionData["İzin Başlangıç"],
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
                        permissionData["İzin Bitiş"],
                        style: TextStyleClass.mainContent.copyWith(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        permissionData["İzin Durumu"],
                        style: TextStyleClass.mainContent.copyWith(
                          color: enabledColor,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        size: 30,
                        permissionData["İzin Durumu"] == "Beklemede"
                            ? Icons.access_time_filled_rounded
                            : permissionData["İzin Durumu"] == "Onaylandı"
                                ? Icons.check
                                : permissionData["İzin Durumu"] == "Reddedildi"
                                    ? Icons.cancel
                                    : Icons.help_outline,
                        color: permissionData["İzin Durumu"] == "Beklemede"
                            ? Colors.yellow
                            : permissionData["İzin Durumu"] == "Onaylandı"
                                ? Colors.green
                                : permissionData["İzin Durumu"] == "Reddedildi"
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
          );
        },
      ),
    );
  }
}
