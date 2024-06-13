import 'package:delivery/bloc/Cubit/AppCubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: AppCubit.get(context).primaryColor,
            child: Image.asset(
              'assets/images/started.jpeg',
              fit: BoxFit.cover,
              height: 550.h,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: AppCubit.get(context).themeMode == true
                    ? Colors.grey[800]!.withOpacity(0.8)
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Best Deliveries \\nIn Jerusalem'.tr(),
                      style: TextStyle(
                        fontSize: 32.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.0.h),
                    Text(
                      "Bringing convenience and deliciousness directly to you"
                          .tr(),
                      style: TextStyle(color: Colors.grey, fontSize: 16.0.sp),
                    ),
                    SizedBox(height: 20.0.h),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      color: AppCubit.get(context).primaryColor,
                      elevation: 0.0,
                      hoverElevation: 0.0,
                      height: 50.h,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Continue".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
