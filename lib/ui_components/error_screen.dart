import 'package:flutter/material.dart';
import 'package:maxsip/utils/assets.dart';
import 'package:maxsip/utils/helper_functions.dart';
import 'package:maxsip/utils/strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ErrorScreen extends StatefulWidget {
  final String message;
  ErrorScreen({required this.message});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  HelperFunctions helperFunctions = HelperFunctions();
  @override
  void initState() {
    if (widget.message == Strings.simCardError) {
      helperFunctions.noSimCardAccount();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(Assets.errorPicture), fit: BoxFit.contain)),
              ),
              // Image(image:const , height: 50.h ,width: 60.w,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.message,
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
