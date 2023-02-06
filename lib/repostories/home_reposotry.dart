import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:maxsip/models/user_model.dart';
import 'package:maxsip/utils/strings.dart';
// import 'package:mobile_number/mobile_number.dart';

import '../models/sel_account_detail.dart';

class HomeRepository {
  Future storeUserDataIntoDB(UserModel info, bool systemOverlayFlag) async {
    var collection = FirebaseFirestore.instance.collection('UsersData');
    await collection.doc(info.phoneNumber) // <-- Document ID //
        .set({
      'manufacturer': info.manufacturer,
      "Model": info.deviceModelName,
      "FcmToken": info.fcmToken,
      "orderID": info.orderID,
      "systemOverlayFlag": systemOverlayFlag
    }, SetOptions(merge: true)).then((value) => debugPrint('inserted/updated')); // <-- Your data
  }

  Future getPhoneNumberPermission() async {
    // await MobileNumber.hasPhonePermission;
  }

  Future<SelAccountDetails?> getSelAccountDetails(String mobileNumber) async {
    Response response;
    var dio = Dio();
    var data = {
      "Credential": {
        "CLECID": "84",
        "UserName": "MAXSIP",
        "TokenPassword": "87584B1DS-B782HU-440784-928FI-7AE3A71869KJ",
        "PIN": "769523",
      },
      //"MDN": "12345678"
      "MDN": "9295881749" // transferout
      // "MDN": "8382404547"     // enrolled
      // "MDN": mobileNumber.substring(2)
    };
    if (kDebugMode) {
      print("number " + mobileNumber);
    }
    response = await dio.post(Strings.selAccountDetails, data: data);
    // final responseBody = json.decode(response.data[]);
    // print('response $responseBody');
    print(response.data);
    final account = response.data['Accounts'];
    debugPrint('Account $account');
    if (account != null) {
      SelAccountDetails selAccountDetails = SelAccountDetails.fromJson(response.data);

      return selAccountDetails;
    } else {
      return null;
    }
  }

  Future modeSwitchApi(String imei) async {
    Response response;
    var dio = Dio();
    var data = {"imei": imei};
    response = await dio.post(Strings.switchUrl, data: data);
    if (kDebugMode) {
      print("modeSwitchApi $response");
    }
  }
}
