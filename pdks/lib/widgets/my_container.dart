import 'package:flutter/material.dart';

import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';

Widget myContainer(Color color, IconData? icon, String title) {
  return Container(
    width: 100,
    height: 80,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyleClass.mainContent.copyWith(color: appcolor2),
        ),
        const SizedBox(
          height: 3,
        ),
        Center(
            child: Icon(
          icon,
          size: 30,
          color: appcolor2,
        )),
      ],
    ),
  );
}
