import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_task/presentation/components/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/state.dart';
import 'package:hotel_task/shared/style.dart';

class RoomsStatusScreen extends StatelessWidget {
  final String branchName;
  const RoomsStatusScreen({Key? key, required this.branchName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc.get(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        "$branchName",
        SizedBox(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: backIcon(context),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AppBloc, AppStates>(builder: (context, state) {
          appBloc.getBranchRooms(branchName);
          return ScreenUtilInit(
              minTextAdapt: true,
              splitScreenMode: true,
              builder: () => ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: appBloc.branchRooms.length,
            itemBuilder: (context, index) => ListTile(
              leading: Text(appBloc.branchRooms[index].roomNumber.toString(),style: response14font),
              title: Text(
                  appBloc.branchRooms[index].booked ? "Booked" : "Available",style: response16font),
              subtitle: Text(appBloc.branchRooms[index].type.toString(),style: response14font),
              trailing: Text(appBloc.branchRooms[index].booked
                  ? "15/3/2022 ${appBloc.branchRooms[index].bookto}"
                  : "${appBloc.branchRooms[index].cost}LE",style: response14font),
            ),),
          );
        }),
      ),
    );
  }
}
