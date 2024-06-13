import 'dart:developer';

import 'package:delivery/bloc/Cubit/AppCubit.dart';
import 'package:delivery/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

import '../../main.dart';
import '../../service/network/local/DbHelper.dart';
import '../component/CustomSettingsScreenRowItem.dart';
import '../component/CustomSideDrawerRowItem.dart';
import '../component/text_style.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    AppCubit cubit = AppCubit.get(context);

    // bool isDarkMode = false;
    return PopScope(
      onPopInvoked: (didPop) async {
        Navigator.pop(context);
        // return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: cubit.userModel!.image != null
                                    ? NetworkImage(cubit.userModel!.image!)
                                    : AssetImage("assets/images/icon.png")
                                        as ImageProvider),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.userModel!.name ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                cubit.userModel!.phone ?? '',
                                style: TextStyle(fontSize: 13, color: kGrey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.015,
                    ),
                    Container(
                      color: Colors.grey[400],
                      width: screenSize.width * 0.9,
                      height: 0.4,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0125,
                    ),
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.account_circle,
                      title: "New Orders".tr(),
                      callback: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.account_circle,
                      title: "Personal Data".tr(),
                      callback: () {
                        Navigator.pushNamed(context, '/personalDataScreen');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.history,
                      title: "My Orders".tr(),
                      callback: () {
                        Navigator.pushNamed(context, '/myOrders');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.history,
                      title: "complete".tr(),
                      callback: () {
                        Navigator.pushNamed(context, '/finishedOrders');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.public,
                      title: "App Language".tr(),
                      callback: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: Image.asset('assets/images/about.gif',
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    height: 120.h),
                                content: Text("Change Language".tr(),
                                    style: textStyle(
                                      context,
                                      size: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center),
                                actions: [
                                  Column(
                                    children: [
                                      Text(
                                        "What Language do you prefer ?".tr(),
                                        style: textStyle(
                                          context,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              cubit.changeAppLanguage('en');
                                              EasyLocalization.of(context)!
                                                  .setLocale(
                                                      Locale('en', 'US'));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 80,
                                              child: Text(
                                                "English".tr(),
                                                style: textStyle(
                                                  context,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: cubit.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              cubit.changeAppLanguage('ar');
                                              EasyLocalization.of(context)!
                                                  .setLocale(
                                                      Locale('ar', 'IQ'));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 80,
                                              child: Text(
                                                "العربيه".tr(),
                                                style: textStyle(
                                                  context,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                    ),

                    /*       SizedBox(
                      height: 20,
                    ),
                
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.star,
                      title: "Reviews",
                      destinationScreen: "/personalDataScreen",
                    ),*/
                    SizedBox(
                      height: screenSize.height * 0.015,
                    ),
                    Container(
                      color: Colors.grey[400],
                      width: screenSize.width * 0.9,
                      height: 0.4,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.025,
                    ),
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.insert_drive_file,
                      title: "Terms and Conditions".tr(),
                      callback: () {
                        Navigator.pushNamed(
                            context, '/termsAndConditionsScreen');
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * 0.025,
                    ),
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.share,
                      title: "Share App".tr(),
                      callback: () {
                        Share.share(
                            "If you love the app please review the app on playstore ore and share it with your friends. https://play.google.com/store/apps/details?id=com.talabatek.delivery");
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * 0.025,
                    ),
                    CustomSideDrawerRowItem(
                      screenSize: screenSize,
                      icon: Icons.star,
                      title: "Rate App".tr(),
                      callback: () {
                        LaunchReview.launch(
                            androidAppId: "com.talabatek.delivery",
                            iOSAppId: "1568670214");
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * 0.025,
                    ),
                    CustomSettingsScreenRowItem(
                      title: "Dark Mode".tr(),
                      subTitle: "Toggle app mode".tr(),
                      icon: Icons.sunny,
                      widget: Switch(
                          activeColor: AppCubit.get(context).primaryColor,
                          value: AppCubit.get(context).themeMode,
                          onChanged: (value) {
                            setState(() {
                              AppCubit.get(context).changeTheme();
                            });
                          }),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.066,
                    ),
                    CustomSideDrawerRowItem(
                      isForLogout: true,
                      screenSize: screenSize,
                      icon: Icons.exit_to_app,
                      colorIcon: Colors.red,
                      title: "Logout".tr(),
                      callback: () async{
                     await   CacheHelper.sharedPreferences!.clear();
                        firebaseMessaging.unsubscribeFromTopic("delivery").then(
                            (value) =>
                                log('un subscibed to delivery after logout'));
                        CacheHelper.saveBoolData(key: "isLogged", value: false);
                        CacheHelper.saveBoolData(
                            key: 'firebaseLogin', value: false);

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
