import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/state.dart';
import 'package:hotel_task/presentation/models/booked_data.dart';
import 'package:hotel_task/shared/style.dart';

class BookedListView extends StatelessWidget {
  const BookedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<AppBloc, AppStates>(
        builder: (context, state) {
          final bookedRooms = AppBloc.get(context).bookedRooms;
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bookedRooms.length,
              itemBuilder: (context, index) => Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Room type: ${bookedRooms[index].roomType}",
                        style: response14font),
                    Text("Room Cost: ${bookedRooms[index].cost}",
                        style: response14font),
                    Text("Guest:", style: response16font),
                    Container(
                      width:  MediaQuery.of(context).size.width * 0.2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: bookedRooms[index].guests.length,
                        itemBuilder: (context, inx) => Text(
                            bookedRooms[index].guests[inx],
                            style: response14font), //
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
