import 'package:delivery/bloc/Cubit/AppCubit.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: LoadingBouncingGrid.square(
        size: 80,backgroundColor: AppCubit.get(context).primaryColor,)),
    );
  }
}
