import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/state.dart';
import 'package:hotel_task/shared/style.dart';

class IconCounter extends StatelessWidget {
  const IconCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            margin: EdgeInsets.all(ScreenUtil().setSp(5)),
            child:
                Icon(Icons.bed, size: ScreenUtil().setSp(25), color: pagColor),
          ),
          CircleAvatar(
            radius: ScreenUtil().setSp(10),
            backgroundColor: Colors.grey,
            child: BlocBuilder<AppBloc, AppStates>(
                builder: (context, state) => Text(
                      AppBloc.get(context).bookedRooms.length.toString(),
                  style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.white),
                    )),
          ),
        ],
      ),
    );
  }
}
