import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';


class ScreenAdaptar {
  static init(context) {
    ScreenUtil.init(
        context,

      designSize: Size(360, 690));
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static setWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static setFontSize(double fontSize) {
    return ScreenUtil().setSp(fontSize);
  }
  static statusBarHeight() {
    return ScreenUtil().statusBarHeight;
  }


}