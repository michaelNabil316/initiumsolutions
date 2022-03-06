import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/bloc.dart';
import 'package:hotel_task/shared/style.dart';
import 'dialog_alert.dart';

class LogoutTxtBtn extends StatelessWidget {
  const LogoutTxtBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => TextButton(
      onPressed: () {
        //are you sure dialog
        alertMessage(context, 'hint',
            Text("Are you sure ? you can not book until login !",style: response14font), () {
          AppBloc.get(context).changeLoggedIn();
          Navigator.of(context).pop();
        });
      },
      child: Text(
        "Logout",
        style: loginTextStyle,
      ),),
    );
  }
}
