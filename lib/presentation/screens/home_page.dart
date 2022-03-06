import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/state.dart';
import 'package:hotel_task/data/constant_data.dart';
import 'package:hotel_task/presentation/components/custom_app_bar.dart';
import 'package:hotel_task/presentation/components/drop_down_list.dart';
import 'package:hotel_task/presentation/components/login_txt_btn.dart';
import 'package:hotel_task/presentation/components/logo_widget.dart';
import 'package:hotel_task/presentation/components/logout_txt_btn.dart';
import 'package:hotel_task/presentation/components/snack_bar.dart';
import 'package:hotel_task/presentation/screens/rooms_status_screen.dart';
import 'package:hotel_task/shared/navigate.dart';
import 'package:hotel_task/shared/style.dart';

import 'booking_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropDownItem = "Cairo";
  @override
  Widget build(BuildContext context) {
    final appcubit = AppBloc.get(context);
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: customAppBar(context, "Hotel",
            appcubit.isLoggedIn ? LogoutTxtBtn() : LoginTxtBtn(), SizedBox()),
        body: SingleChildScrollView(
          child: ScreenUtilInit(
            minTextAdapt: true,
            splitScreenMode: true,
            builder: () => Column(
              children: [
                //hotel photo
                LogoWidget(
                    imgPath: 'assets/images/welcomhotel.jpg'),
                SizedBox(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(30),
                ),
                //show a sale if this guest booked before
                if (appcubit.haveSale)
                  Text("You have a sale up to 95%", style: response14font),
                SizedBox(height: ScreenUtil().setHeight(30)),
                //branches dropdown list
                DropDownList(
                  arrList: branchesData,
                  dropdownValue: dropDownItem,
                  fun: (value) {
                    setState(() {
                      dropDownItem = value!;
                    });
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                //rooms state button
                ElevatedButton(
                  onPressed: () {
                    if (appcubit.isLoggedIn) {
                      navigateTo(
                          context, RoomsStatusScreen(branchName: dropDownItem));
                    } else
                      customSnackBar(context, "Please Login first");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                    child: Text("rooms status", style: response14font),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                //booking page
                ElevatedButton(
                  onPressed: () {
                    if (appcubit.isLoggedIn) {
                      navigateTo(
                          context, BookingScreen(branchName: dropDownItem));
                    } else
                      customSnackBar(context, "Please Login first");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                    child: Text("Book a room", style: response14font),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
