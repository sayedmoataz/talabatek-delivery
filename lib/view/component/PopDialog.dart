import 'package:delivery/view/component/text_style.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/Cubit/AppCubit.dart';


Future<Object?> popDialog({
  required context,
  required String title,
  required String content,
  required Color boxColor,
}) {
  return showFlash(
      context: context,
      persistent: true,
      transitionDuration: const Duration(milliseconds: 400),
      duration: const Duration(seconds: 2),
      builder: (context, controller) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Flash(
                position: FlashPosition.bottom,


                controller: controller,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h,bottom: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width:220.w,
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.h),
                                topRight: Radius.circular(15.h))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: textStyle(
                                      context, color: boxColor, size: 12.sp,fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 1.sp,
                            ),
                            Text(
                              content,
                              maxLines: 2,
                              style: textStyle(
                                  context, color: AppCubit.get(context).primaryColor, size: 11.sp,fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2.h,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      });
}