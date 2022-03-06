import 'package:flutter/material.dart';
import 'package:hotel_task/shared/style.dart';


Future<dynamic> alertMessage(BuildContext context,String title,Widget content, yesFun) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title,style:WelcomStyle),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: Text('Cancel',style:response14font),
        ),
         TextButton(
            onPressed: yesFun,
            child: Text('Yes',style:response14font),
          ),
      ],
    ),
  );
}
