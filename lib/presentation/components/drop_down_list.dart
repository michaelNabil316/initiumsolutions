import 'package:flutter/material.dart';
import 'package:hotel_task/shared/style.dart';


class DropDownList extends StatelessWidget {
  final arrList ;
  final dropdownValue;
  final void Function(String?) fun;
  DropDownList(
      {required this.dropdownValue,
        required this.arrList ,
        required this.fun,
        Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.07,
      width: size.width*0.5,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: arrList.map<DropdownMenuItem<String>>((selectedItem) {
            return DropdownMenuItem<String>(
              value: selectedItem,
              child: Text(selectedItem,style: response14font),
            );
          }).toList(),
          onChanged: fun,
          value: dropdownValue,
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
