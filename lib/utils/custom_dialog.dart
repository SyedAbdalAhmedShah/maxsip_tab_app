import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maxsip/utils/strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:system_alert_window/models/system_window_header.dart';
import 'package:system_alert_window/models/system_window_text.dart';
import 'package:system_alert_window/system_alert_window.dart';

import '../view/home/home_page.dart';

class CustomDialogs {
  static getDilaog({
    required BuildContext context,
    Function()? callBack,
    String? title,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('OPPS'),
        content: Text(title ?? ''),
        actions: [
          TextButton(
            onPressed: callBack ?? () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  showDialog(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: const Text(Strings.success),
              content: const Text(Strings.successSubmitted),
              actions: [
                TextButton(
                    onPressed: () async => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomePageScreen(),
                        ),
                        (route) => false),
                    child: const Text('Ok'))
              ],
            ));
  }
}
