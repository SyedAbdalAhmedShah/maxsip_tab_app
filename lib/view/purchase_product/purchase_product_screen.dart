import 'package:flutter/material.dart';
import 'package:maxsip/ui_components/carousal_slider_view.dart';
import 'package:maxsip/ui_components/product_card_widget.dart';
import 'package:maxsip/ui_components/vertical_gap.dart';
import 'package:maxsip/utils/strings.dart';

class PurchaseProductView extends StatelessWidget {
  const PurchaseProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.products),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CarousalSliderView(),
              const CustomGap(),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, childAspectRatio: 3 / 3.5, crossAxisSpacing: 20, mainAxisSpacing: 20),
                  itemCount: 10,
                  itemBuilder: (BuildContext ctx, index) {
                    return const ProductCardWidget();
                  }),
              // SizedBox(
              //   height: 30.h,
              //   child: ListView.separated(
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) => ,
              //       separatorBuilder: (context, index) => SizedBox(
              //             width: 1.h,
              //           ),
              //       itemCount: 10),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
