import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:android_id/android_id.dart';
import 'package:app_launcher/app_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maxsip/models/sel_account_detail.dart';
import 'package:maxsip/repostories/home_reposotry.dart';
import 'package:maxsip/utils/custom_dialog.dart';
import 'package:maxsip/utils/strings.dart';
// import 'package:mobile_number/mobile_number.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_data_plus/sim_data.dart';
import 'package:system_alert_window/system_alert_window.dart';

import '../view/forms/cancelform.dart';
import '../view/forms/newform.dart';

class HelperFunctions {
  Future intializationNotification(backgoundMessage) async {
    assert(backgoundMessage != null);
    // RemoteMessage? message =
    await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        if (kDebugMode) {
          print('Message also contained a notification: ${message.notification?.title}');
        }
      }
    });
    FirebaseMessaging.onBackgroundMessage(backgoundMessage);
  }

  Future transferOutCheckJob() async {
    try {
      bool connectivity = await InternetConnectionChecker().hasConnection;
      if (connectivity) {
        DartPluginRegistrant.ensureInitialized();

        SimData simData = await SimDataPlugin.getSimData();
        if (simData.cards.isNotEmpty) {
          await Firebase.initializeApp();
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          print('TOKEN $fcmToken');
          print("SIM CARD LENGTH  ${simData.cards.length} ");
          for (var mobi in simData.cards) {
            SelAccountDetails? accountDetails =
                await HomeRepository().getSelAccountDetails(mobi.phoneNumber.toString());
            var data = {"mobileNumber": mobi.phoneNumber};
            if (accountDetails != null) {
              String? status = accountDetails.accounts?.first.ebbpstatus;
              if (kDebugMode) {
                print('status $status');
              }
              if (status == Strings.transferOut) {
                await notificationApiCall(data);
              }
            }
          }
        } else {
          showLocalNotification(Strings.simCardError2, Strings.simCardError);
        }
      } else {
        showLocalNotification(Strings.internetError1, Strings.internetError2);
      }
    } catch (error) {
      if (kDebugMode) {
        print('error $error');
      }
    }
  }

  showLocalNotification(String title, String body) {
    const notificationChannelId = 'my_foreground';
    const notificationId = 888;
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.cancelAll();
    return flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannelId,
          'MY FOREGROUND SERVICE',
          icon: 'launch_image',
          ongoing: true,
        ),
      ),
    );
  }

  Future noSimCardAccount() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print("DEVICE TOKEN IS =========$fcmToken");
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      if (androidId != null) {
        if (fcmToken != null) {
          DocumentReference docRef = FirebaseFirestore.instance.collection("noAccountActive").doc(androidId);
          String docRefId = docRef.id;
          await docRef.set({
            Strings.fcmToken: fcmToken,
            Strings.docId: docRefId,
          });
        }
      } else {
        if (kDebugMode) {
          print("device id is empty");
        }
      }
    } catch (error) {
      print('ERROR is : $error');
    }
  }

  navigateToConsentForm(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Consent(),
        ),
        (route) => false);
  }

  navigateToCancelScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Cancel(),
        ),
        (route) => false);
  }

  void updateButton({required String transferStatus}) async {
    await Firebase.initializeApp();
    SimData simData = await SimDataPlugin.getSimData();
    final phoneNumber2 = simData.cards.first.phoneNumber;
    print('phone number object $phoneNumber2');
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var phoneNumber = preferences.getString(Strings.mobileNumber);
    bool isReminderButtonPressed = false;
    // log("mobile update button message ");
    // log(phoneNumber!);
    if (transferStatus == Strings.reminder) {
      isReminderButtonPressed = true;
    }
    var collection = FirebaseFirestore.instance.collection('UsersData');
    collection
        .doc(phoneNumber2)
        .update({'buttonSelected': transferStatus, "isReminderButtonPressed": isReminderButtonPressed})
        .then((_) => log('Updated firebase'))
        .catchError((error) => log('Update failed: $error'));
  }

  launchApp(String buttonPressed) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("checkApi", true);
    bool isClear = await preferences.remove(Strings.buttonPressed);
    final firestore = FirebaseFirestore.instance;
    DocumentReference<Map<String, dynamic>> docRef = firestore.collection("collectionPath").doc();
    QuerySnapshot<Map<String, dynamic>> qShot = await docRef.collection('collectionPath').get();
    List<QueryDocumentSnapshot> listDoc = qShot.docs;

    if (isClear) {
      await preferences.setString(Strings.buttonPressed, buttonPressed);
      SystemAlertWindow.closeSystemWindow(prefMode: SystemWindowPrefMode.OVERLAY);
      await AppLauncher.openApp(androidApplicationId: 'com.maxsiptel.app');
    }
  }

  Future notificationApiCall(Map<String, dynamic> data) async {
    try {
      Dio dio = Dio();
      Response response;
      response = await dio.post(Strings.sendNotificationToDevice,
          data: data,
          options: Options(
            validateStatus: (status) => true,
          ));
      if (kDebugMode) {
        print(response.data);
      }
    } catch (error) {
      print('ERROR OCCURE IN NOTIFICATION API CALL $error');
    }
  }
}
