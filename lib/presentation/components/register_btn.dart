import 'package:flutter/material.dart';
import 'package:hotel_task/shared/style.dart';

class ButtonWidget extends StatelessWidget {
  final String bText;
  final function;
  const ButtonWidget(this.bText, this.function, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: customDecor,
        child: Text(
          "$bText",
          style: enrollstyle,
        ),
      ),
    );
  }
}
