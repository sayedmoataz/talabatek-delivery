import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Column EmptyWidget(title,{double? hieght}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
       SizedBox(
        height:hieght ?? 100,
      ),
      Lottie.asset('assets/images/empty.json',
          width: 300,
          height: 200,
          alignment: Alignment.center,
          fit: BoxFit.fill),
      const SizedBox(
        height: 20,
      ),
       Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    ],
  );
}