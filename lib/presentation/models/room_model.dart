import 'package:flutter/cupertino.dart';

class Room {
  String branch;
  int roomNumber;
  int dbId;
  bool booked;
  String type;
  String guest;
  double cost;
  String bookfrom;
  String bookto;
  Room({
    required this.branch,
    required this.roomNumber,
    required this.dbId,
    required this.booked,
    required this.type,
    required this.guest,
    required this.cost,
    required this.bookfrom,
    required this.bookto,
  });
}
