import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserInfoTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final double? width;
  const UserInfoTile(
      {Key? key, required this.title, required this.subTitle, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      // margin: EdgeInsets.symmetric(horizontal: 2.w),
      height: 12.h,
      width: width ?? 40.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          SizedBox(
            height: 1.h,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
