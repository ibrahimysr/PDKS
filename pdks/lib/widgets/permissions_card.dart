import 'package:flutter/material.dart';
import 'package:pdks/style/textstyle.dart';

class PermissionCard extends StatelessWidget {
  final Map<String, dynamic> permission;

  const PermissionCard({required this.permission, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration:BoxDecoration( 
          color: Colors.white, 
          borderRadius: BorderRadius.circular(10)
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
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            permission["İzin Tipi"],
                            style: TextStyleClass.mainContent.copyWith(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Başlama Tarihi",
                        style: TextStyleClass.mainContent.copyWith(
                          color: Colors.black,
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
                          color: Colors.black,
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
                          color: Colors.black,
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
    );
  }
}
