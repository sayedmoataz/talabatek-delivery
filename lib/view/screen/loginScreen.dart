import 'package:delivery/bloc/Cubit/AppCubit.dart';
import 'package:delivery/view/component/loadingScreen_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../component/text_style.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: AppCubit.get(context).loading == true
            ? LoadingScreen()
            : Stack(
                children: <Widget>[
                  Container(
                    height: 250.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/loginBack.jpg'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 270),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppCubit.get(context).themeMode == true
                          ? Colors.grey[800]
                          : Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(23),
                      child: ListView(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/images/icon.png',
                                height: 60,
                              ),
                              GradientText(
                                'Talabatek Delivery'.tr(),
                                colors: [
                                  AppCubit.get(context).primaryColor,
                                  AppCubit.get(context).themeMode == true
                                      ? Colors.white
                                      : Colors.black,
                                ],
                                gradientType: GradientType.radial,
                                radius: 4,
                                style: textStyle(context,
                                    size: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpaceing: 1.5),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Container(
                              child: TextFormField(
                                controller: emailController,
                                style: TextStyle(fontFamily: 'SFUIDisplay'),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Emair or Phone'.tr(),
                                    prefixIcon: Icon(Icons.person_outline),
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _obscureText,
                              style: TextStyle(fontFamily: 'SFUIDisplay'),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText == true
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: _toggle,
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'Password'.tr(),
                                  prefixIcon: Icon(Icons.lock_outline),
                                  labelStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: MaterialButton(
                              onPressed: () {
                                if (validateData(context)) {
                                  AppCubit.get(context)
                                      .loginWithEmailAndPassword(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          context: context);
                                }
                              }, //since this is only a UI app
                              child: Text(
                                'SIGN IN'.tr(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'SFUIDisplay',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: AppCubit.get(context).primaryColor,
                              elevation: 0,
                              minWidth: 400,
                              height: 50,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Forget your password ?".tr(),
                                      style: TextStyle(
                                        fontFamily: 'SFUIDisplay',
                                        fontSize: 15,
                                      )),
                                  TextSpan(
                                      text: " Contact Us".tr(),
                                      style: TextStyle(
                                        fontFamily: 'SFUIDisplay',
                                        color:
                                            AppCubit.get(context).primaryColor,
                                        fontSize: 15,
                                      ))
                                ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ) /*SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/biker.svg"),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFiled(
                      screenSize: screenSize,
                      hintText: "Email",
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    CustomTextFiled(
                      screenSize: screenSize,
                      hintText:"Password",
                      isForPasword: true,
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 35,
                    ),

                    CustomButton(
                      text: "Login",
                      role: () async {
                        if (validateData(context)) {
                          AppCubit.get(context).loginWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context);
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),*/
        );
  }

  bool validateData(context) {
    if (emailController.text.isEmpty) {
      showToast(
        "Email or Phone is required",
        context: context,
        borderRadius: BorderRadius.circular(5),
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: Duration(milliseconds: 250),
      );
      return false;
    } else if (passwordController.text.isEmpty) {
      showToast(
        "Password is required",
        context: context,
        borderRadius: BorderRadius.circular(5),
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: Duration(milliseconds: 250),
      );
      return false;
    } else {
      return true;
    }
  }
}
