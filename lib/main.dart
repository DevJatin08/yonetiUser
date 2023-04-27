import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Screen/Splash/SplashScreem.dart';

String? fcmToken;

void main() async {
  Stripe.publishableKey =
      "pk_test_51KPBpMD7PODSamJce9ipvXPg2p2CRe7MyDvwAjUSgxhbwMbjBr26omBWdLr2kA2g2RNdlaWosJLQYX9ncAE22GgW00E4qqTt5A";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      sharedPreferences = await SharedPreferences.getInstance();
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      await FirebaseMessaging.instance.subscribeToTopic("users");
      fcmToken = await FirebaseMessaging.instance.getToken();
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      log(fcmToken.toString(), name: "FCM Token");
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      ///Local Notification
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        "channelId",
        "channelName",
        importance: Importance.max,
        priority: Priority.high,
        icon: 'ic_launcher',
        color: Colors.red,
        channelShowBadge: true,
        colorized: true,
        enableVibration: true,
        fullScreenIntent: true,
        playSound: true,
      );

      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
          print('Got a message whilst in the foreground!');
          print('Message data: ${message.data}');

          if (message.notification != null) {
            print('Message also contained a notification: ${(message.notification!.body)}');

            ///Local Notification
            await flutterLocalNotificationsPlugin.show(
              0,
              message.notification?.title,
              message.notification?.body,
              notificationDetails,
            );
          }
        },
      );
      log("${settings.authorizationStatus}", name: "Notification Settings");
      sharedPreferences = await SharedPreferences.getInstance();
      globalInitializer.intialize();
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          // systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark, // status bar color
          statusBarIconBrightness: Brightness.dark));
      await Stripe.instance.applySettings();
      runApp(ProviderScope(child: MyApp()));
    },
    (error, st) => print(error),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: primaryColor,
          primarySwatch: primarySwatch,
          scaffoldBackgroundColor: Color(0xfff2f2f3)),
      home: SafeArea(child: SplashScreen()),
    );
  }
}
