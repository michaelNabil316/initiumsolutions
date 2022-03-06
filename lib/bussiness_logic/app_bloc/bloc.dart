import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_task/data/sqflite_helper.dart';
import 'package:hotel_task/presentation/models/booked_data.dart';
import 'package:hotel_task/presentation/models/room_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());
  static AppBloc get(context) => BlocProvider.of(context);
  DbHelper dBHelper = DbHelper();
  bool isLoggedIn = false;
  List<Room> rooms = [];
  List guests = [];
  List<Room> branchRooms = [];
  List<BookedRoomData> bookedRooms = [];
  double allCost = 0;
  String currentGuest = "";
  var prefserences;
  bool haveSale = false;

  void createDB() async {
    emit(LoadingDatabaseState());
    prefserences = await SharedPreferences.getInstance();
    await dBHelper.createDataBase();
    dBHelper.getRoomsDatabase().then((value) {
      rooms = value;
      for (var r in rooms) {
      }
      emit(SuccessfulRoomDatabaseState());
    }).catchError((error) {
      emit(ErrorRoomDatabaseState(error.toString()));
    });
    dBHelper.getGuestDatabase().then((value) {
      guests = value;
      for (String g in guests) {
        if (currentGuest == g) {
          prefserences.setBool("currentGuestSale", true);
          guestHaveSale();
        }
      }
      emit(SuccessfulGuestsDatabaseState());
    }).catchError((error) {
      emit(ErrorGuestsDatabaseState(error.toString()));
    });
  }

  //save guest who booked only in the datatbase
  saveNewGuestDatabase() {
    dBHelper.insertNewGuest(currentGuest).then((value) {
      rooms = value;
      emit(SuccessfulInsertUserState());
    }).catchError((error) {
      emit(ErrorInsertUserState(error.toString()));
    });
  }

  //change flag
  changeLoggedIn() {
    isLoggedIn = !isLoggedIn;
    emit(IsLoggedChangedState());
  }

  //keep guest logged in also if closed the app
  getCurrentGuest() async {
    prefserences = await SharedPreferences.getInstance();
    if (prefserences.getString('guest') != null) {
      currentGuest = prefserences.getString('guest');
      changeLoggedIn();
      emit(ChangeGuestState());
    }
    if (prefserences.getBool('currentGuestSale') != null) {
      guestHaveSale();
    }
    print(
        "name: $currentGuest, isLoggedIn: $isLoggedIn, have a sale: $haveSale");
  }

  setCurrentGuest(String guest) {
    prefserences.setString('guest', "$guest");
    currentGuest = guest;
    emit(ChangeGuestState());
  }

  getBranchRooms(String branchName) {
    branchRooms = [];
    for (Room room in rooms) {
      if (room.branch == branchName) {
        branchRooms.add(room);
      }
    }
    emit(GetBranchRoomsState());
  }

  //this guest have a sale
  guestHaveSale() {
    haveSale = true;
    emit(HaveSaleState());
  }

  //update statues of the task
  void updateRoom(String branchName) async {
    for (BookedRoomData r in bookedRooms) {
      String allGuests = r.guests[0];
      for (int i = 1; i < r.guests.length; i++) {
        allGuests += ",${r.guests[i]}";
      }
      await dBHelper.updateRoom(r.databaseId, true, allGuests);
      allGuests = "";
    }
    dBHelper.getRoomsDatabase().then((value) {
      rooms = value;
      getBranchRooms(branchName);
      emit(SuccessfulRoomDatabaseState());
    }).catchError((error) {
      emit(ErrorRoomDatabaseState(error.toString()));
    });
  }

  //update the list of booked rooms
  updateBookedList(BookedRoomData room) {
    bookedRooms.add(room);
    emit(UpdateBookedListState());
  }

  clearBookedList() {
    bookedRooms = [];
    emit(ClearBookedListState());
  }

  sumAllCost() {
    allCost = 0;
    for (BookedRoomData i in bookedRooms) {
      allCost += i.cost;
    }
    emit(UpdateAllCost());
  }
}
