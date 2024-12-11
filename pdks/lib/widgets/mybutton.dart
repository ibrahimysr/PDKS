import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
import 'package:pdks/style/textstyle.dart';

Widget myButton(Function()? ontap,String title) { 
  return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: enabledColor, 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                              onPressed: ontap, child:  Text(title,style: TextStyleClass.mainContent.copyWith(
                                color: appcolor2
                              ),)));
}