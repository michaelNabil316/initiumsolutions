import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// this widget for the name textfield
class CustomFormTxtField extends StatelessWidget {
  final TextEditingController controller;
  const CustomFormTxtField({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //using media query to get height and width of the screen
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () =>Container(
        margin:  EdgeInsets.symmetric(horizontal:  ScreenUtil().setHeight(50)),
        height: ScreenUtil().setHeight(70),
        child: TextFormField(
          controller: controller,
          maxLines: 1,
          style: TextStyle(fontSize: ScreenUtil().setSp(18),color: Colors.grey),
          decoration: InputDecoration(
           labelStyle:TextStyle(fontSize: ScreenUtil().setSp(18)),
            errorStyle: TextStyle(fontSize: ScreenUtil().setSp(15)),
            labelText: 'Name',
            border: OutlineInputBorder(
            ),
            prefixIcon: Icon(
              Icons.person,size: ScreenUtil().setSp(20),
            ),
          ),
          validator: (value) {
            //if the name was empty
            if (value!.isEmpty) return 'Empty name';
            //or if student make space insted of name
            if (value.trim().isEmpty) return 'Empty name';
            return null;
          },
          inputFormatters: [
            //make it accept english letters and space only
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-\ " "]")),
            //make it accept a custom length of name
            LengthLimitingTextInputFormatter(25),
          ],
        ),
      ),
    );
  }
}
