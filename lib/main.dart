import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_task/presentation/screens/home_page.dart';
import 'bussiness_logic/app_bloc/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (_) => AppBloc()..createDB()..getCurrentGuest(),
      child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  HomePage(),
      ),
    );
  }
}
