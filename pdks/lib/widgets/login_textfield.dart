import 'package:flutter/material.dart';

import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';

Widget loginTextField(TextEditingController controller, String title, Icon icon,
    bool open, String data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        data,
        style: TextStyleClass.mainContent,
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        height: 65,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: appcolor2,
            borderRadius: BorderRadius.circular(
             10
            ),
            ),
        child: TextField(
          obscureText: open,
          controller: controller,
          style: const TextStyle(color: textColor),
          decoration: InputDecoration(
              icon: icon,
              iconColor: enabledColor,
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ),
    ],
  );
}
