import 'package:flutter/material.dart';
import 'package:pdks/style/color.dart';
Widget bottomNavigatorButton(Function()? ontap,int index,int index2,String title,IconData icon) { 
  return MaterialButton(
                  minWidth: 50,
                  onPressed: ontap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      index == index2 ? Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: enabledColor
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(icon,color: Colors.white,size: 18,),
                            ),
                          )):Icon(icon,color: Colors.grey,size: 18,),
                      const SizedBox(height: 4,),
                      Text(
                        title,
                        style: TextStyle(
                          color: index == index2 ? textColor : Colors.grey,
                          fontWeight: index == index2
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
} 