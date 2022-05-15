import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/widget/custom_liquid_swipe.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLiquidSwipe(
        liquidSwipeDataList: [
          LiquidSwipeData(
            image: "assets/images/swiper-1.jpg",
            title: Languages.of(context)!.swiper1Title,
            subTitle: Languages.of(context)!.swiper1SubTitle,
            description: Languages.of(context)!.swiper1Desc,
          ),
          LiquidSwipeData(
            image: "assets/images/swiper-2.jpg",
            title: Languages.of(context)!.swiper2Title,
            subTitle: Languages.of(context)!.swiper2SubTitle,
            description: Languages.of(context)!.swiper2Desc,
          ),
          LiquidSwipeData(
            image: "assets/images/swiper-3.jpg",
            title: Languages.of(context)!.swiper3Title,
            subTitle: Languages.of(context)!.swiper3SubTitle,
            description: Languages.of(context)!.swiper3Desc,
          ),
          LiquidSwipeData(
            image: "assets/images/swiper-4.jpg",
            title: Languages.of(context)!.swiper4Title,
            subTitle: Languages.of(context)!.swiper4SubTitle,
            description: Languages.of(context)!.swiper4Desc,
          ),
        ],
      ),
    );
  }
}
