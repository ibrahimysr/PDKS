import 'package:flutter/material.dart';
import 'package:pdks/style/textstyle.dart';
import 'package:pdks/widgets/my_container.dart';

Widget myStack(Function()? ontap, Function()? ontap2, String title) {
  return Container(
    width: double.infinity,
    height: 130,
    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
    padding: const EdgeInsets.only(bottom: 10),
                     decoration: BoxDecoration( 
                      color: Colors.white,borderRadius: BorderRadius.circular(25)
                     ),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(title,style: TextStyleClass.mainContent,),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: ontap,
                child: myContainer(Colors.green, Icons.login, "Giriş"),
              ),
              GestureDetector(
                onTap: ontap2,
                child: myContainer(Colors.red, Icons.output, "Çıkış"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
