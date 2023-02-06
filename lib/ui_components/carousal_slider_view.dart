import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maxsip/utils/assets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarousalSliderView extends StatelessWidget {
  const CarousalSliderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(image: AssetImage(Assets.product1), fit: BoxFit.fill)),
      ),
      options: CarouselOptions(
        height: 30.h,
        viewportFraction: 0.98,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
