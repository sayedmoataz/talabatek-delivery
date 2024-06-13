import 'package:delivery/firebase_options.dart';
import 'package:delivery/service/network/local/DbHelper.dart';
import 'package:delivery/service/network/remote/dio_helper.dart';
import 'package:delivery/utils/custom_theme.dart';
import 'package:delivery/view/screen/finished_orders.dart';
import 'package:delivery/view/screen/homeScreen.dart';
import 'package:delivery/view/screen/loginScreen.dart';
import 'package:delivery/view/screen/my_orders.dart';
import 'package:delivery/view/screen/notification_screen.dart';
import 'package:delivery/view/screen/personalDataScreen.dart';
import 'package:delivery/view/screen/settingsScreen.dart';
import 'package:delivery/view/screen/splash_screen.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery/view/screen/getStartedScreen.dart';

import 'bloc/Cubit/AppCubit.dart';
import 'bloc/Cubit/AppStates.dart';
import 'bloc/bloc_observer.dart';

String? Fcmtoken;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, name: 'delivery_app');
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  
  bool firstMode = CacheHelper.getData(key: "isLight") ?? true;

  firebaseMessaging.requestPermission(sound: true, alert: true);

  FirebaseMessaging.instance.getAPNSToken().then((apnsToken) async {
    if (apnsToken != null) {
      print("APNS token: $apnsToken");
      Fcmtoken = await firebaseMessaging.getToken();
      print("FCM token: $Fcmtoken");
      await handleNotifications();
    } else {
      print("APNS token is null. Push notifications might not be enabled correctly.");
    }
  }).catchError((e) {
    print("Error getting APNS token: $e");
  });

  DioHelper.init();

  Bloc.observer = MyBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..getUserData()..getFirstMode(firstMode),
        ),
      ],
      child: EasyLocalization(
        child: MyApp(),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'IQ'),
        ],
        saveLocale: true,
        fallbackLocale: Locale('ar', 'IQ'),
        path: 'assets/languages',
      ),
    ),
  );
}

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Future<void> handleNotifications() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (Fcmtoken != null) {
    await firebaseMessaging.subscribeToTopic("all").then((_) {
      print("Subscribed to topic 'all'");
    }).catchError((e) {
      print("Error subscribing to topic: $e");
    });
  } else {
    print("FCM token is null. Cannot subscribe to topic.");
  }
}

void sendTokenToServer(String fcmToken) {
  print('Token: $fcmToken');
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            EasyLocalization.of(context)!.delegate,
          ],
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          initialRoute: '/splash',
          routes: {
            '/home': (context) => HomeScreen(),
            '/splash': (context) => SplashScreen(),
            '/login': (context) => LoginScreen(),
            '/notification': (context) => NotificationScreen(),
            '/getStarted': (context) => GetStartedScreen(),
            '/myOrders': (context) => MyOrders(),
            '/finishedOrders': (context) => FinishedOrders(),
            '/personalDataScreen': (context) => PersonalDataScreen(),
            '/homeScreen': (context) => HomeScreen(),
            '/settingsScreen': (context) => SettingsScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Delivery app',
          themeMode: AppCubit.get(context).themeMode ? ThemeMode.dark : ThemeMode.light,
          theme: CustomTheme.lightTheme(context),
          darkTheme: CustomTheme.darkTheme(context),
        ),
      ),
    );
  }
}
