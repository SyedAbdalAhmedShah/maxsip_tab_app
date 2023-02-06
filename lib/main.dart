import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maxsip/blocs/home_bloc.dart';
import 'package:maxsip/utils/app_colors.dart';
import 'package:maxsip/utils/helper_functions.dart';
import 'package:maxsip/utils/strings.dart';
import 'package:maxsip/view/home/home_page.dart';
import 'package:maxsip/view/video_call.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_alert_window/system_alert_window.dart';

void callBack(String tag) {
  WidgetsFlutterBinding.ensureInitialized();
  log(tag);
  switch (tag) {
    case "simple_button":
      HelperFunctions().updateButton(transferStatus: Strings.reminder);
      SystemAlertWindow.closeSystemWindow(
          prefMode: SystemWindowPrefMode.OVERLAY);
      break;
    case "updated_simple_button":
      HelperFunctions().updateButton(transferStatus: Strings.agree);
      HelperFunctions().launchApp(Strings.consentFormButtonPressed);
      break;
    case "red_button":
      HelperFunctions().updateButton(transferStatus: Strings.cancel);
      HelperFunctions().launchApp(Strings.secondaryFormButtonPressed);
      log("Focus button has been called");
      break;
    case 'ok':
      SystemAlertWindow.closeSystemWindow(
          prefMode: SystemWindowPrefMode.OVERLAY);
      break;

    default:
      log("OnClick event of $tag");
  }
}

void transferCheckout() async {
  HelperFunctions helperFunctions = HelperFunctions();
  await helperFunctions.transferOutCheckJob();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("FIREBASE BACKGROUND DATA ${message.data}");
  String? isReminderButtonPressed = message.data["isReminderButton"];
  debugPrint('isReminderButton $isReminderButtonPressed');
  String maxsipNumber = "Please call 866-629-7471 for any questions";
  String notificationText =
      "Your affordable connectivity benefits requires additional information to continue receiving your free monthly internet.\n" +
          maxsipNumber;

  SystemWindowHeader header = SystemWindowHeader(
    title: SystemWindowText(
        text: "Maxsip Telecom",
        fontSize: 25,
        fontWeight: FontWeight.BOLD,
        textColor: Colors.blue),
    padding: SystemWindowPadding.setSymmetricPadding(12, 100),
    subTitle: SystemWindowText(
        text: notificationText,
        //'text: "${message.notificatio n?.body}",
        fontSize: 20,
        fontWeight: FontWeight.BOLD,
        textColor: Colors.black87),
    decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
  );
  SystemAlertWindow.showSystemWindow(
      height: 400,
      header: header,
      margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
      gravity: SystemWindowGravity.TOP,
      footer: SystemWindowFooter(
          padding: SystemWindowPadding(
            left: 20,
            right: 20,
          ),
          buttons: [
            SystemWindowButton(
              text: SystemWindowText(
                  text: "I wish to continue receiving my benefits",
                  fontSize: 15,
                  textColor: Colors.black),
              tag: "updated_simple_button",
              width: 0,
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: Colors.lightGreen,
                  endColor: Colors.lightGreen,
                  borderWidth: 0,
                  borderRadius: 0.0),
            ),
            if (isReminderButtonPressed != Strings.reminderTrue)
              SystemWindowButton(
                text: SystemWindowText(
                    text: "Please Remind me later",
                    fontSize: 15,
                    textColor: Colors.black),
                tag: "simple_button",
                padding: SystemWindowPadding(
                    left: 10, right: 10, bottom: 10, top: 10),
                width: 0,
                height: SystemWindowButton.WRAP_CONTENT,
                decoration: SystemWindowDecoration(
                    startColor: Colors.yellow,
                    endColor: Colors.yellow,
                    borderWidth: 0,
                    borderRadius: 0.0),
              ),
            SystemWindowButton(
              text: SystemWindowText(
                  text: "i wish to cancel my benefit",
                  fontSize: 15,
                  textColor: Colors.black),
              tag: "red_button",
              padding:
                  SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              width: 0,
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: Colors.redAccent,
                  endColor: Colors.redAccent,
                  borderWidth: 0,
                  borderRadius: 0.0),
            ),
          ]),
      prefMode: SystemWindowPrefMode.OVERLAY);
  String? transferStatus = message.data["body"];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(Strings.transferOutStatus, transferStatus ?? '');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // FlutterLocalNotificationsPlugin().initialize(const InitializationSettings(android: initializationSettingsAndroid));
  await AndroidAlarmManager.initialize();
  MobileAds.instance.initialize();
  await SystemAlertWindow.requestPermissions(
      prefMode: SystemWindowPrefMode.OVERLAY);
  await Permission.ignoreBatteryOptimizations.request();
  await Permission.phone.request();
  await HelperFunctions()
      .intializationNotification(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
  AndroidAlarmManager.periodic(const Duration(hours: 3), 1, transferCheckout,
      startAt: DateTime.now(),
      allowWhileIdle: true,
      exact: true,
      rescheduleOnReboot: true);
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

  //InterstitialAd? interstitialAd;
  @override
  void initState() {
    SystemAlertWindow.registerOnClickListener(callBack);
    //InterstitialAd.load(
    //adUnitId:
    //"ca-app-pub-3940256099942544/1033173712", //TODO this need to change with real account
    //request: const AdRequest(),
    //adLoadCallback: InterstitialAdLoadCallback(
    //onAdLoaded: (ad) {
    //interstitialAd = ad;
    //interstitialAd?.show();
    //},
    //onAdFailedToLoad: (error) =>
    //log('error while loading ad : ${error.message}'),
    //),
    //);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc(),
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          title: Strings.appName,
          theme: ThemeData(
              primarySwatch: AppColors.APP_COLOR as MaterialColor,
              textTheme: GoogleFonts.robotoSerifTextTheme()),
          home: HomePageScreen(),
        );
      }),
    );
  }
}
