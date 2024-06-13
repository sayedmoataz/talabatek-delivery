import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Cubit/AppCubit.dart';
import '../../bloc/Cubit/AppStates.dart';
import '../../service/network/local/DbHelper.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..splashTimer(),
      child: BlocListener<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is SplashscreenLoading)
              CacheHelper.getData(key: "isLogged") == true
                  ? Navigator.pushReplacementNamed(context, "/home")
                  : Navigator.pushReplacementNamed(context, "/getStarted");
            else
              print(state);
          },
          child: Scaffold(
              body: Image.asset(
            'assets/images/splash.gif',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ))),
    );
  }
}
