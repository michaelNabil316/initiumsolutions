import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const darkColor = Color.fromARGB(255, 28, 35, 84);

const pagColor = Color.fromARGB(255, 202, 152, 67);

const appbarTitleStyle = TextStyle(
    color: darkColor, fontWeight: FontWeight.bold);

final loginTextStyle = TextStyle(
    color: pagColor, fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(14));

const logoutTextStyle = TextStyle(
    color: Colors.blueGrey, fontWeight: FontWeight.bold);

final customDecor = BoxDecoration(
  borderRadius: BorderRadius.circular(25),
  color: pagColor,
);
final anscustomDecor = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: pagColor,
);
final enrollstyle = TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(20));
TextStyle  response14font = TextStyle(fontSize: ScreenUtil().setSp(14));
TextStyle  response16font = TextStyle(fontSize: ScreenUtil().setSp(19));
TextStyle  WelcomStyle = TextStyle(fontSize: ScreenUtil().setSp(19));