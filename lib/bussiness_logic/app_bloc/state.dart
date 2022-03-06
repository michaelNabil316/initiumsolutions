abstract class AppStates {}

class AppInitialState extends AppStates {}

class LoadingDatabaseState extends AppStates {}
class SuccessfulRoomDatabaseState extends AppStates {}
class ErrorRoomDatabaseState extends AppStates {
  String error;
  ErrorRoomDatabaseState(this.error);
}class SuccessfulGuestsDatabaseState extends AppStates {}
class ErrorGuestsDatabaseState extends AppStates {
  String error;
  ErrorGuestsDatabaseState(this.error);
}
class IsLoggedChangedState extends AppStates {}

class GetBranchRoomsState extends AppStates {}

class HaveSaleState extends AppStates {}

class ChangeGuestState extends AppStates {}

class SuccessfulInsertUserState extends AppStates {}
class ErrorInsertUserState extends AppStates {
  String error;
  ErrorInsertUserState(this.error);
}
class UpdateBookedListState extends AppStates {}

class ClearBookedListState extends AppStates {}

class UpdateAllCost extends AppStates {}
