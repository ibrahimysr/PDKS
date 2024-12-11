import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';

Widget managerContainer( IconData? icon,String title,Function()? ontap) { 

  return GestureDetector( 
    onTap: ontap,
    child: Container(
      width: 150, 
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: enabledColor
             
            ),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: appcolor2,
                size: 30,
              ),
            ),
          ),
         const SizedBox(height: 10,),
          Text(
            title,
            style:
                TextStyleClass.mainContent.copyWith(fontSize: 18),
          )
        ],
      ),
    ),
  );
}