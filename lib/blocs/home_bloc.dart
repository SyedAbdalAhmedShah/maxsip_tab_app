import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maxsip/managers/user_manager.dart';
import 'package:maxsip/models/sel_account_detail.dart';
import 'package:maxsip/models/user_model.dart';
import 'package:maxsip/repostories/home_reposotry.dart';
import 'package:maxsip/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sim_data_plus/sim_data.dart';
import 'package:system_alert_window/system_alert_window.dart';

import '../utils/helper_functions.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository = HomeRepository();
  HelperFunctions helperFunctions = HelperFunctions();
  SelAccountDetails? selAccountDetails;

  HomeBloc() : super(HomeInitial()) {
    on<StoreUserDataEvent>((event, emit) async {
      emit(LoadingHomeState());
      String? mobileNumber;

      try {
        final connectivity = await InternetConnectionChecker().hasConnection;
        print("has connection $connectivity");
        if (connectivity) {
          SimData simData = await SimDataPlugin.getSimData();
          for (var simcard in simData.cards) {
            print('SIM CARD DATA ${simcard.phoneNumber}');
          }
          if (simData.cards != null) {
            if (simData.cards.isNotEmpty) {
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.reload();
              String? token = await FirebaseMessaging.instance.getToken();
              print("FCM TOKEN $token");
              String? transferStatus = preferences.getString('TransferoutStatus');
              String? buttonPressed = preferences.getString(Strings.buttonPressed);

              if (buttonPressed != null) {
                if (transferStatus == 'TransferOut' && buttonPressed == Strings.consentFormButtonPressed) {
                  debugPrint('in');
                  emit(StatusIsTransferout());
                } else if (Strings.secondaryFormButtonPressed == buttonPressed) {
                  debugPrint('i am here --------------');
                  emit(RedButtonPressed());
                }
              } else {
                debugPrint('else');
                // bool mobilePermission = await MobileNumber.hasPhonePermission;
                // if (mobilePermission) {
                mobileNumber = simData.cards.first.phoneNumber;
                //   await preferences.setString(Strings.mobileNumber, mobileNumber.toString());
                // }

                AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
                String? manufacturer = androidDeviceInfo.manufacturer;
                String? model = androidDeviceInfo.model;
                if (kDebugMode) {
                  print(mobileNumber);
                }
                selAccountDetails = await repository.getSelAccountDetails(mobileNumber.toString());
                if (selAccountDetails != null) {
                  final orderId = selAccountDetails?.accounts!.first.subscriberorderid;
                  final availableData = selAccountDetails?.accounts!.first.availabledata;
                  bool? systemWindowPermission =
                      await SystemAlertWindow.checkPermissions(prefMode: SystemWindowPrefMode.OVERLAY);

                  // if (systemWindowPermission != null) {
                  //   if (selAccountDetails?.accounts?.first.imei != null) {
                  //     repository.modeSwitchApi(selAccountDetails?.accounts?.first.imei ?? '');
                  //   }
                  // }
				  print(mobileNumber);
				  if(mobileNumber==null || mobileNumber.isEmpty){
					print("SimCard not active");
					emit(NoAccountFound());
					return;
				  }	
				  print("SimCard active");				  
                  UserModel userInfo = UserModel(
                      fcmToken: token,
                      manufacturer: manufacturer,
                      deviceModelName: model,
                      phoneNumber: mobileNumber,
                      availableData: availableData.toString(),
                      orderID: orderId.toString());
                  UserManager.user = userInfo;
                  await repository.storeUserDataIntoDB(userInfo, systemWindowPermission!);
                  emit(SuccessfullyUserDataInserted());
                } else {
                  emit(NoAccountFound());
                }
              }
            } else {
              emit(FailureState(message: Strings.simCardError));
            }
          } else {
            emit(FailureState(message: Strings.simCardError2));
          }
        } else {
          emit(FailureState(message: Strings.internetError));
        }
      } catch (error) {
        print('error in home bloc $error');
        emit(NoAccountFound());
      }
    });
  }
}
