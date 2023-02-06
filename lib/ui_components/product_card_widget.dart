import 'package:flutter/material.dart';
import 'package:maxsip/ui_components/vertical_gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/assets.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 15.h,
                width: 20.h,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.product2), fit: BoxFit.fill)),
              ),
              Text(
                'Product Name',
                style: TextStyle(fontSize: 16.sp),
              ),
              CustomGap(
                height: 1.h,
              ),
              Text(
                'Category',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.grey.withOpacity(0.6)),
              ),
              const CustomGap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '18\$',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
