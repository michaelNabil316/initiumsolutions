import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/state.dart';
import 'package:hotel_task/data/constant_data.dart';
import 'package:hotel_task/presentation/components/booked_listview.dart';
import 'package:hotel_task/presentation/components/custom_app_bar.dart';
import 'package:hotel_task/presentation/components/custom_txt_field.dart';
import 'package:hotel_task/presentation/components/dialog_alert.dart';
import 'package:hotel_task/presentation/components/drop_down_list.dart';
import 'package:hotel_task/presentation/components/icon_counter.dart';
import 'package:hotel_task/presentation/components/register_btn.dart';
import 'package:hotel_task/presentation/components/snack_bar.dart';
import 'package:hotel_task/presentation/models/booked_data.dart';
import 'package:hotel_task/presentation/models/room_model.dart';
import 'package:hotel_task/shared/style.dart';

class BookingScreen extends StatefulWidget {
  final String branchName;
  const BookingScreen({Key? key, required this.branchName}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String dropDownItem = "single";
  final nameController1 = TextEditingController();
  final nameController2 = TextEditingController();
  final nameController3 = TextEditingController();

  final registerformKey = GlobalKey<FormState>();
  List<Room> availbleRooms = [];
  int choosedRoomDbId = 0;
  Room? currentRoom;

  @override
  void initState() {
    super.initState();
    AppBloc.get(context).getBranchRooms(widget.branchName);
    filterAvailableRooms("single");
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc.get(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        "Booking",
        appBloc.bookedRooms.length > 0 ? IconCounter() : SizedBox(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: backIcon(context),
        ),
      ),
      body: SingleChildScrollView(
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: () => Form(
            key: registerformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Welcom to ${widget.branchName} branch",
                    style: WelcomStyle),
                if (appBloc.haveSale)
                  SizedBox(height: ScreenUtil().setHeight(30)),
                if (appBloc.haveSale)
                  Text("You have a sale up to 95%", style: response14font),
                SizedBox(
                    width: double.infinity, height: ScreenUtil().setHeight(30)),
                Text("room type:", style: response16font),
                SizedBox(height: ScreenUtil().setHeight(30)),
                DropDownList(
                  arrList: roomtypeList,
                  dropdownValue: dropDownItem,
                  fun: (value) {
                    setState(() {
                      dropDownItem = value!;
                      filterAvailableRooms(value);
                    });
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                availbleRooms.length > 0
                    ? BlocBuilder<AppBloc, AppStates>(
                        builder: (context, state) => Column(
                          children: [
                            Text("enter Guest name", style: response16font),
                            SizedBox(height: ScreenUtil().setHeight(30)),
                            CustomFormTxtField(controller: nameController1),
                            if (dropDownItem == "double")
                              CustomFormTxtField(controller: nameController2),
                            if (dropDownItem == "suit")
                              Column(
                                children: [
                                  CustomFormTxtField(
                                      controller: nameController2),
                                  CustomFormTxtField(
                                      controller: nameController3),
                                ],
                              ),
                            SizedBox(height: ScreenUtil().setHeight(30)),
                            ElevatedButton(
                              onPressed: () {
                                if (registerformKey.currentState!.validate()) {
                                  for (var room in availbleRooms) {
                                    if (room.dbId == choosedRoomDbId) {
                                      setState(() {
                                        currentRoom = room;
                                      });
                                    }
                                  }
                                  if (currentRoom != null) {
                                    List<String> currentGuests = [];
                                    if (nameController1.text.isNotEmpty)
                                      currentGuests.add(nameController1.text);
                                    if (nameController2.text.isNotEmpty)
                                      currentGuests.add(nameController2.text);
                                    if (nameController3.text.isNotEmpty)
                                      currentGuests.add(nameController3.text);
                                    appBloc.updateBookedList(BookedRoomData(
                                      guests: currentGuests,
                                      databaseId: choosedRoomDbId,
                                      cost: appBloc.haveSale
                                          ? currentRoom!.cost * 0.95
                                          : currentRoom!.cost,
                                      roomType: dropDownItem,
                                      room: currentRoom!,
                                    ));
                                    setState(() {
                                      if (availbleRooms.length == 1)
                                        availbleRooms = [];
                                      else
                                        availbleRooms.remove(currentRoom);
                                      updateCurrentId();
                                      nameController1.text = "";
                                      nameController2.text = "";
                                      nameController3.text = "";
                                    });
                                  }
                                }
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(8)),
                                child: Text("Add", style: response14font),
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(30)),
                          ],
                        ),
                      )
                    : Text("No rooms available in $dropDownItem",
                        style: response16font),
                ButtonWidget('Book', () {
                  if (appBloc.bookedRooms.length > 0) {
                    appBloc.sumAllCost();
                    alertMessage(
                        context,
                        "booking summary",
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Hotel branch: ${widget.branchName}",
                                style: response14font),
                            BookedListView(),
                            Text("Check cost: ${appBloc.allCost}",
                                style: response14font),
                          ],
                        ), () {
                      // update room in data base
                      appBloc.updateRoom(widget.branchName);
                      //save this guest who booked in database (for sale)
                      appBloc.saveNewGuestDatabase();
                      //this guest have a sale
                      appBloc.guestHaveSale();
                      //filter available rooms again
                      filterAvailableRooms(dropDownItem);
                      //clear booking list
                      appBloc.clearBookedList();
                      //update current page data
                      AppBloc.get(context).getBranchRooms(widget.branchName);
                      filterAvailableRooms(dropDownItem);
                      Navigator.of(context).pop();
                    });
                  } else
                    customSnackBar(context, "Please add at least 1 room");
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  filterAvailableRooms(String filterType) {
    setState(() {
      availbleRooms = [];
      for (var item in AppBloc.get(context).branchRooms) {
        if (item.type == filterType && item.booked == false) {
          availbleRooms.add(item);
          choosedRoomDbId = item.dbId;
        }
      }
    });
  }

  updateCurrentId() {
    for (var item in availbleRooms) {
      setState(() {
        choosedRoomDbId = item.dbId;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController1.dispose();
    nameController2.dispose();
    nameController3.dispose();
  }
}
