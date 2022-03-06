import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/bloc.dart';
import 'package:hotel_task/bussiness_logic/app_bloc/state.dart';
import 'package:hotel_task/presentation/components/custom_app_bar.dart';
import 'package:hotel_task/presentation/components/custom_txt_field.dart';
import 'package:hotel_task/presentation/components/logo_widget.dart';
import 'package:hotel_task/presentation/components/register_btn.dart';
import 'package:hotel_task/shared/navigate.dart';
import 'home_page.dart';


final registerformKey = GlobalKey<FormState>();
final nameController = TextEditingController();
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc.get(context);
    return Scaffold(
        backgroundColor: Colors.white,
        //a custom app bar widget
        appBar: customAppBar(context,'Login',SizedBox(),IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: backIcon(context),
        ),),
        body: SingleChildScrollView(
          //this form for the name textfiled for validation
          child: Form(
            key: registerformKey,
            child: Column(
              children: [
                //this an image widget
                LogoWidget(imgPath: 'assets/images/initiumBanner.png'),
                SizedBox(height: 30),
                //using custom text filed design
                CustomFormTxtField(controller: nameController),
                //if name is validate,enroll button will navigate to the questions
                BlocBuilder<AppBloc,AppStates>(
                  builder:(context,state)=> ButtonWidget('Login', ()async {
                    if (registerformKey.currentState!.validate()) {
                      //save guest in shared preferences
                      appBloc.setCurrentGuest(nameController.text);
                      //change logged in bool
                      appBloc.changeLoggedIn();
                      //navigate to question screen
                      navigateAndFinish(context, HomePage());
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
