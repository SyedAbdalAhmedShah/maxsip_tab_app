import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomGap extends StatelessWidget {
  final double? height;
  final double? width;
  const CustomGap({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 2.h,
      width: width,
    );
  }
}
