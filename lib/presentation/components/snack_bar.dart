import 'package:flutter/material.dart';
import 'package:hotel_task/shared/style.dart';

customSnackBar (context,text){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
      Text(text, style: response14font),
    ),
  );
}