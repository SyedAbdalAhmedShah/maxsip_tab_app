import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxsip/blocs/home_bloc.dart';
import 'package:maxsip/blocs/home_state.dart';
import 'package:maxsip/ui_components/error_screen.dart';
import 'package:maxsip/ui_components/reusable_widget.dart';
import 'package:maxsip/ui_components/userinfo_tile.dart';
import 'package:maxsip/ui_components/vertical_gap.dart';
import 'package:maxsip/ui_components/web_view.dart';
import 'package:maxsip/utils/app_colors.dart';
import 'package:maxsip/utils/helper_functions.dart';
import 'package:maxsip/utils/strings.dart';
// import 'package:mobile_number/mobile_number.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:system_alert_window/system_alert_window.dart';

import '../../blocs/home_event.dart';
import '../../main.dart';
import '../../managers/user_manager.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with WidgetsBindingObserver {
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
  HomeBloc? bloc;
  HelperFunctions helperFunctions = HelperFunctions();
  @override
  void initState() {
    bloc = BlocProvider.of<HomeBloc>(context);

    bloc?.add(StoreUserDataEvent());
    WidgetsBinding.instance.addObserver(this);
    SystemAlertWindow.registerOnClickListener(callBack);
    // initAlaramManager();
    super.initState();
  }

  initAlaramManager() async {
    await AndroidAlarmManager.periodic(const Duration(seconds: 5), 1, transferCheckout,
        startAt: DateTime.now(), allowWhileIdle: true, exact: true, rescheduleOnReboot: true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      bloc?.add(StoreUserDataEvent());
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        debugPrint('state of bloc from homebloc $state');
        if (state is StatusIsTransferout) {
          helperFunctions.navigateToConsentForm(context);
        }
        if (state is RedButtonPressed) {
          helperFunctions.navigateToCancelScreen(context);
        }
        if (state is NoAccountFound) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => WebViewScreen()));
        }
        if (state is FailureState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ErrorScreen(message: state.message)));
        }
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: ReusableWidgets.appBar(),
              body: state is LoadingHomeState
                  ? Center(
                      child: LoadingAnimationWidget.discreteCircle(color: AppColors.THEME_COLOR, size: 40),
                    )
                  : bloc!.selAccountDetails != null
                      ? _buildBody(size, state)
                      : const Center(
                          child: Text(Strings.noAccountFound),
                        ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: buildFloatingActionButton(),
              bottomNavigationBar: buildBottomAppBar(),
            ),
          );
        },
      ),
    );
  }

  Padding _buildBody(Size size, Object? state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.04),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserInfoTile(
                title: Strings.availableData,
                subTitle:
                    state is LoadingHomeState ? Strings.getting : UserManager.user.availableData ?? Strings.emptyString,
              ),
              UserInfoTile(
                title: Strings.manufacturer,
                subTitle:
                    state is LoadingHomeState ? Strings.getting : UserManager.user.manufacturer ?? Strings.emptyString,
              ),
            ],
          ),
          const CustomGap(),
          UserInfoTile(
            title: Strings.orderId,
            subTitle: state is LoadingHomeState ? Strings.getting : UserManager.user.orderID ?? Strings.emptyString,
            width: 60.w,
          ),
          const CustomGap(),
          UserInfoTile(
            title: Strings.phoneNumber,
            subTitle: state is LoadingHomeState ? Strings.getting : UserManager.user.phoneNumber ?? Strings.emptyString,
            width: 60.w,
          ),
          const SizedBox(
            height: 200,
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(Strings.patientPending),
          )
        ],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.THEME_COLOR,
      child: const Icon(Icons.add),
      onPressed: () {},
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 12,
      color: AppColors.THEME_COLOR,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  size: 4.h,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  size: 4.h,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
