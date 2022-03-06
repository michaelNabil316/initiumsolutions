import 'package:hotel_task/presentation/models/room_type.dart';

RoomType roomType = RoomType();
//let suggesting we have 3 branches / locations
const branchesData = ["Cairo","Alex","Sharm El Sheikh"];
// and let every branch have 6 rooms
List roomsData = [
  {"branch":"","room_number":1,"booked":false,"type":"${roomType.singleRoom.toString()}","guest":"","cost":300,"bookfrom":"","bookto":""},
  {"branch":"","room_number":2,"booked":false,"type":"${roomType.singleRoom.toString()}","guest":"","cost":300,"bookfrom":"","bookto":""},

  {"branch":"","room_number":3,"booked":false,"type":"${roomType.doubleRoom.toString()}","guest":"","cost":500,"bookfrom":"","bookto":""},
  {"branch":"","room_number":4,"booked":false,"type":"${roomType.doubleRoom.toString()}","guest":"","cost":500,"bookfrom":"","bookto":""},

  {"branch":"","room_number":5,"booked":false,"type":"${roomType.suitRoom.toString()}","guest":"","cost":700,"bookfrom":"","bookto":""},
  {"branch":"","room_number":6,"booked":false,"type":"${roomType.suitRoom.toString()}","guest":"","cost":700,"bookfrom":"","bookto":""},
];

List roomtypeList = ["single","double","suit"];