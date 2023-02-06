import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxsip/blocs/home_state.dart';
import 'package:maxsip/ui_components/reusable_widget.dart';
import 'package:maxsip/utils/custom_dialog.dart';
import 'package:maxsip/utils/helper_functions.dart';
import 'package:maxsip/utils/strings.dart';
// import 'package:mobile_number/mobile_number.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_form/super_form.dart';

import '../../blocs/home_bloc.dart';
import '../../blocs/home_event.dart';
import '../../managers/user_manager.dart';
import '../../utils/app_colors.dart';

var info;

class Consent extends StatefulWidget {
  const Consent({Key? key}) : super(key: key);

  @override
  _ConsentState createState() => _ConsentState();
}

class _ConsentState extends State<Consent> with WidgetsBindingObserver {
  CollectionReference transferNote = FirebaseFirestore.instance.collection('TransferNote');
  HomeBloc? homeBloc;
  HelperFunctions helperFunctions = HelperFunctions();
  Future<void> submitData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? mobileNumber = await MobileNumber.mobileNumber;
    String? orderID = UserManager.user.orderID;
    if (kDebugMode) {
      // print(mobileNumber);
    }
    await transferNote
        .doc(orderID
            // mobileNumber?.substring(2)
            )
        .set(info);
    await preferences.clear();
    CustomDialogs().showDialog(context);
  }

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    WidgetsBinding.instance.addObserver(this);
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
        debugPrint('bloc state from consent form $state');
        if (state is StatusIsTransferout) {
          helperFunctions.navigateToConsentForm(context);
        }
        if (state is RedButtonPressed) {
          helperFunctions.navigateToCancelScreen(context);
        }
      },
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ReusableWidgets.appBar(),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: LoadingAnimationWidget.discreteCircle(color: AppColors.THEME_COLOR, size: 40),
              inAsyncCall: state is LoadingHomeState,
              child: ListView(children: [
                SuperForm(
                  restorationId: "submit",
                  validationMode: ValidationMode.onChange,
                  onSubmit: (values) {
                    if (kDebugMode) {
                      print(values.toString());
                    }
                    setState(() {
                      info = values;
                      submitData();
                    });
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Strings.aboutACP,
                          style: const TextStyle(fontSize: 15, wordSpacing: 1),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 500,
                          height: 70.h,
                          child: Column(
                            children: const [
                              TermsAndConditionsCheckbox(),
                              // SizedBox(height: 15),
                              //Text('I acknowledge I have reviewed the provided disclosures, I consent to all as listed, and I provide my authorization to enroll in the Affordable Connectivity Program with Maxsip Telecom.'),
                              NameField(),
                              // SizedBox(height: 10),
                              Text(Strings.iUnderstandDigitalSignature),
                              SubmitButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          },
        ),
      )),
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextSuperFormField(
      key: const Key('Name'),
      decoration: const InputDecoration(
        labelText: "Signature",
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        prefixIcon: Icon(Icons.fingerprint),
      ),
      name: "Full Name",
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

class TermsAndConditionsCheckbox extends StatelessWidget {
  const TermsAndConditionsCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CheckboxSuperFormField.listTile(
        key: const Key('tc'),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.only(left: 4),
        name: "termsAndConditionsAccepted",
        rules: [
          RequiredRule("Please Select an option"),
          //MinimumLengthRule(1, "Please Select an option"),
          ContainsRule("box2", "Must Be checked"),
          ContainsRule("box4", "Must Be checked"),
          //ContainsRule("option2", "Yes")
          //ContainsRule(
          //"yes", "You must accept our Terms & Condition to continue")
        ],
        options: [
          CheckboxOption(
              "box1",
              Text(
                Strings.option1,
                style: const TextStyle(fontSize: 11),
              )),
          CheckboxOption("box2", Text(Strings.option2, style: const TextStyle(fontSize: 11))),
          CheckboxOption(
              "MaxsipConsent",
              Text(Strings.consentOption,
                  style: const TextStyle(
                    fontSize: 11,
                  ))),
          CheckboxOption("box3", Text(Strings.option3, style: const TextStyle(fontSize: 11))),
          CheckboxOption("box4", Text(Strings.option4, style: const TextStyle(fontSize: 11))),
        ],
      ),
      const SuperFormErrorText(name: "termsAndConditionsAccepted"),
    ]);
  }
}
