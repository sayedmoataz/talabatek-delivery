import 'dart:developer';

import 'package:delivery/Model/order_model.dart';
import 'package:delivery/view/screen/loginScreen.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../Model/notification_model.dart';
import '../../Model/user_model.dart';
import '../../main.dart';
import '../../service/network/local/DbHelper.dart';
import '../../service/network/remote/dio_helper.dart';
import '../../view/component/PopDialog.dart';
import '../../view/screen/homeScreen.dart';
import 'AppStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState()) {
    // int? pcIndex = CacheHelper.getData(key: 'primaryColor');
    bool firstMode = CacheHelper.getData(key: "isLight") ?? true;
    themeMode = firstMode;
  }
  static AppCubit get(context) => BlocProvider.of(context);

  dynamic primaryColor = Colors.green;
  bool themeMode = true;
  Color textColor = Colors.black;

  void changeTheme() {
    themeMode ? themeMode = false : themeMode = true;
    print(themeMode);

    CacheHelper.saveBoolData(key: "isLight", value: themeMode);
    emit(ThemeChangedState());
  }

  getFirstMode(mode) {
    CacheHelper.saveBoolData(key: "isLight", value: mode);
    themeMode = CacheHelper.getData(key: "isLight");
    emit(getFirstModeState());
  }

  void splashTimer() async {
    await Future.delayed(
        Duration(seconds: 5), () => emit(SplashscreenLoading()));
  }

  bool loading = false;
  String appLanguage = 'ar'; // en --or-- ar
  int changingLanguage = 0;

  void changeAppLanguage(String newValue) {
    appLanguage = newValue;
    changingLanguage = 1;
    emit(ChangeAppLanguageState());
    ////////////////
    CacheHelper.saveStringData(
      key: 'appLanguage',
      value: appLanguage,
    ).then((value) async {
      changingLanguage = 0;
      emit(ChangeAppLanguageSuccessState());
    });
  }

  void loginWithEmailAndPassword(
      {required email, required password, required context}) {
    emit(LogInInitialState());
    // LoadingScreen();
    loading = true;

    DioHelper.postData(
            url: "delivery/login",
            data: CacheHelper.getData(key: 'fcm') == null
                ? {
                    'password': password,
                    'key': email,
                    'fcm': Fcmtoken,
                  }
                : {
                    'password': password,
                    'key': email,
                  })
        .then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        CacheHelper.saveStringData(key: 'fcm', value: Fcmtoken);
        CacheHelper.saveStringData(key: 'email', value: email);
        CacheHelper.saveStringData(
            key: 'username', value: value.data['user']['name']);
        CacheHelper.saveStringData(
            key: 'access', value: value.data['user']['token']);
        CacheHelper.saveIntData(key: 'userId', value: value.data['user']['id']);
        //subscribe to notifications
        firebaseMessaging.subscribeToTopic(
            "${email.replaceAll("@", '').replaceAll(".", '').replaceAll("-", '')}");
        firebaseMessaging
            .subscribeToTopic("delivery")
            .then((value) => log('subscibed to delivery after login'));
        CacheHelper.saveBoolData(key: "isLogged", value: true);
        print('user id ${CacheHelper.getData(key: 'userId')}');
        // handleNotifications();
        getUserData(context: context);
        loading = false;

        popDialog(
            context: context,
            title: 'Welcome Back'.tr(),
            content: 'Login Done Sucessfully'.tr(),
            boxColor: primaryColor);
        emit(LogInSuccessState());
      } else {
        loading = false;
        emit(LogInSuccessState());

        popDialog(
            context: context,
            title: 'Something wrong happen'.tr(),
            content: value.toString(),
            boxColor: Colors.red);
      }

      // createSnackBar(context,'Welcome Back ${value.user!.displayName}');
      emit(LogInSuccessState());
    }).catchError((e) {
      popDialog(
          context: context,
          title: e.toString(),
          boxColor: Colors.red,
          content: '');

      emit(LogInErrorState());
      print(e.toString());
    });
  }

  UserModel? userModel;
  getUserData({context}) async {
    emit(getProfileInitialState());
    DioHelper.getData(
      url: 'user/profile',
    ).then((value) {
      print(value.data);
      print(CacheHelper.getData(key: 'access'));

      userModel = UserModel.fromJson(value.data);
      print(value.data);
      print("user data");
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      emit(getProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getProfileErrorState());
    });
  }

  getRealTimeOrders() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("onMessage: ${message.notification?.title ?? ''}");
      getOrders();
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("onMessageOpenedApp: ${message.data}");
      getOrders();
    });
  }

  NotificationModel? notificationModel;

  Future<void> getNotification() async {
    await DioHelper.getData(
      url: 'api/user-notifications',
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        notificationModel = NotificationModel.fromJson(value.data);

        emit(GetNotificationSuccessState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetNotificationSuccessState());
    });
  }

  bool orderLoading = false;

  Future<void> checkOrder(orderId, context) async {
    await DioHelper.getData(
      url: 'api/order/$orderId',
    ).then((value) {
      orderLoading = true;
      print(value.statusCode);
      if (value.statusCode == 200) {
        if (value.data['order']['status'] == 'finished') {
          print(value.data['order']['status']);
          takeOrder(orderId, context);
        } else {
          popDialog(
              context: context,
              title: 'Another delivery take the order'.tr(),
              content: 'look for another one'.tr(),
              boxColor: Colors.red);
          getOrders();
          orderLoading = false;
        }

        emit(GetNotificationSuccessState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetNotificationSuccessState());
    });
  }

  Future<void> takeOrder(orderId, context) async {
    await DioHelper.getData(
      url: 'api/start-order/$orderId',
    ).then((value) {
      print(value.statusCode);
      print(value.data);
      if (value.statusCode == 200) {
        popDialog(
            context: context,
            title: value.data['message'],
            content: 'Start deliver it now',
            boxColor: primaryColor);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        orderLoading = false;
        emit(GetNotificationSuccessState());
      } else {
        popDialog(
            context: context,
            title: 'Something wrong happen',
            content: value.toString(),
            boxColor: Colors.red);
        orderLoading = false;
        emit(GetNotificationSuccessState());
      }
    }).catchError((e) {
      print(e.toString());
      orderLoading = false;
      emit(GetNotificationSuccessState());
    });
  }

  Future<void> deleteAcc(context, id) async {
    emit(UploadProfileImageLoadingState());

    DioHelper.deleteData(
      url: "user/delete/$id",
    ).then((value) {
      print(value.data);
      CacheHelper.saveBoolData(key: "isLogged", value: false);
      CacheHelper.saveBoolData(key: 'firebaseLogin', value: false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);

      emit(UploadProfileImageSuccessState());
    }).catchError((e) {
      popDialog(
          context: context,
          title: 'Problem happen'.tr(),
          content: e.toString(),
          boxColor: Colors.red);
      print(e.toString());
      showToast(
        e.toString(),
        borderRadius: BorderRadius.circular(5),
        context: context,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: Duration(milliseconds: 600),
      );
      emit(UploadProfileImageErrorState(e.toString()));
    });
  }

  OrderModel? orderModel;

  Future<void> getOrders() async {
    emit(GetOrdersLoadingState());
    await DioHelper.getData(
      url: 'api/order?status=finished',
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        orderModel = OrderModel.fromJson(value.data);
        print('order data');
        // finishedOrderModel = orderModel!.results!
        //     .where((element) => element.status! == "finished")
        //     .toList();
        emit(GetOrdersSucessState());
      }
    }).catchError((e) {
      print(e.toString());

      emit(GetOrdersErrorState(msg: e.toString()));
    });
  }

  int? allOrder;
  int finishOrder = 0;
  int notFinishOrder = 0;
  List<OrderModelItem>? newOrdersOrderModel;
  List<OrderModelItem>? completedOrderModel;
  List<OrderModelItem>? myOrdersOrderModel;
  List<OrderModelItem>? notCompletedOrderModel;

  Future<void> getDeliveryOrders() async {
    finishOrder = 0;
    notFinishOrder = 0;
    await DioHelper.getData(
      url: 'api/order?deliveryId=${CacheHelper.getData(key: 'userId')}',
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        orderModel = OrderModel.fromJson(value.data);
        myOrdersOrderModel = orderModel!.results!
            .where((element) => element.status! == "in the way")
            .toList();
        completedOrderModel = orderModel!.results!
            .where((element) => element.status! == "complete")
            .toList();

        // notCompletedOrderModel = orderModel!.results!
        //     .where((element) => element.status! != "complete")
        //     .toList();
        print('order data');
        allOrder = orderModel!.results!.length;
        print(orderModel!.count.toString());
        print(allOrder);
        for (int i = 0; i <= orderModel!.results!.length; i++) {
          if (orderModel!.results![i].status == 'complete')
            finishOrder += 1;
          else
            notFinishOrder += 1;
        }

        emit(GetNotificationSuccessState());
      }
    }).catchError((e) {
      print(e.toString());

      emit(GetNotificationSuccessState());
    });
  }

  Future<void> updateOrder(orderId, status, context) async {
    FormData formData = FormData.fromMap({
      'status': status,
    });
    orderLoading = true;
    await DioHelper.patchData(url: 'api/order/$orderId', data: formData)
        .then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        popDialog(
            context: context,
            title: value.data['message'],
            content: 'Status Change Successfully'.tr(),
            boxColor: primaryColor);
        getDeliveryOrders();
        orderLoading = false;
        Navigator.pop(context);

        emit(GetNotificationSuccessState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetNotificationSuccessState());
    });
  }
}
