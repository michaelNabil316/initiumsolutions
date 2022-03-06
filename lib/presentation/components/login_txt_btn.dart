import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_task/presentation/screens/login_screen.dart';
import 'package:hotel_task/shared/navigate.dart';
import 'package:hotel_task/shared/style.dart';

class LoginTxtBtn extends StatelessWidget {
  const LoginTxtBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          navigateTo(context, RegisterScreen());
        },
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: () => Text(
            "Login",
            style: loginTextStyle,
          ),
        ));
  }
}
