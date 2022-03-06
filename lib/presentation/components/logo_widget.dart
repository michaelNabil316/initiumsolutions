import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoWidget extends StatelessWidget {
  final String imgPath;
  const LogoWidget({Key? key, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => Container(
          //get the logo of the company from the assets
          child: Image.asset(
            imgPath,
            height: ScreenUtil().setHeight(250),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
