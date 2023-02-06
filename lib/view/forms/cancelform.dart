import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxsip/blocs/home_state.dart';
import 'package:maxsip/ui_components/reusable_widget.dart';
import 'package:maxsip/utils/custom_dialog.dart';
import 'package:maxsip/utils/helper_functions.dart';
// import 'package:mobile_number/mobile_number.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_form/super_form.dart';

import '../../blocs/home_bloc.dart';
import '../../blocs/home_event.dart';
import '../../managers/user_manager.dart';
import '../../utils/app_colors.dart';
import '../../utils/strings.dart';

var info;

class Cancel extends StatefulWidget {
  const Cancel({Key? key}) : super(key: key);

  @override
  _CancelState createState() => _CancelState();
}

class _CancelState extends State<Cancel> with WidgetsBindingObserver {
  HelperFunctions helperFunctions = HelperFunctions();
  HomeBloc? homeBloc;
  CollectionReference cancelNote = FirebaseFirestore.instance.collection('CancelNote');

  Future<void> submitData() async {
    // String? mobileNumber = await MobileNumber.mobileNumber;
    String? orderID = UserManager.user.orderID;
    if (kDebugMode) {
      // print(mobileNumber);
    }
    await cancelNote.doc(orderID).set(info);
    CustomDialogs().showDialog(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    homeBloc = BlocProvider.of<HomeBloc>(context);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      homeBloc?.add(StoreUserDataEvent());
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is StatusIsTransferout) {
          helperFunctions.navigateToConsentForm(context);
        }

        if (state is RedButtonPressed) {
          helperFunctions.navigateToCancelScreen(context);
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: ReusableWidgets.appBar(),
            body: ModalProgressHUD(
              progressIndicator: LoadingAnimationWidget.discreteCircle(color: AppColors.THEME_COLOR, size: 40),
              inAsyncCall: state is LoadingHomeState,
              child: buildBody(),
            ),
          ));
        },
      ),
    );
  }

  ListView buildBody() {
    return ListView(children: [
      SuperForm(
        restorationId: "submit",
        validationMode: ValidationMode.onChange,
        onSubmit: (values) {
          if (kDebugMode) {
            print(values.toString());
          }
          setState(() {
            info = values;
            if (kDebugMode) {
              print(info["Full Name"]);
            }
            submitData();
          });
        },
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                Strings.sorryToSeeYouGo,
                style: TextStyle(fontSize: 25, wordSpacing: 1),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 500,
                height: 70.h,
                child: Column(
                  children: const [
                    NameField(),
                    //Text(Strings.iUnderstandDigitalSignature),
                    SubmitButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class NameField extends StatelessWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextSuperFormField(
      key: const Key('Name'),
      decoration: const InputDecoration(
        labelText: Strings.reasonForLeaving,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        prefixIcon: Icon(Icons.stop),
      ),
      name: Strings.reasonForLeaving,
      rules: [
        RequiredRule("Must not be empty"),
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 32,
          ),
        ),
      ),
      onPressed: () => SuperForm.of(context, listen: false).submit(),
      child: const Text(Strings.submit),
    );
  }
}
