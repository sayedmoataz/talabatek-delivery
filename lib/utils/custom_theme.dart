import 'package:delivery/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bloc/Cubit/AppCubit.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      //scaffoldBackgroundColor: Colors.grey[300],
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: AppCubit.get(context).primaryColor,
        accentColor: Palette.amber500,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        titleTextStyle: theme.textTheme.headline6!.copyWith(
          color: Palette.black,
        ),
        iconTheme: IconThemeData(color: Palette.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      textTheme: Typography.blackMountainView,
      dividerColor: Palette.amber500,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: Colors.grey[800],
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch:AppCubit.get(context).primaryColor,
        accentColor: Palette.darkSecondaryColor,
      ),
      dividerColor: Palette.amber500,
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }
}
