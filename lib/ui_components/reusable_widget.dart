import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/assets.dart';

class ReusableWidgets {
  static appBar() {
    return AppBar(
      toolbarHeight: 12.h,
      flexibleSpace: const Image(
        image: AssetImage(Assets.imagesMaxsip1logo),
        fit: BoxFit.contain,
      ),
      backgroundColor: Colors.white,
    );
  }
}
