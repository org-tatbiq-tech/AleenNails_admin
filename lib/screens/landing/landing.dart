import 'package:appointments/data_types.dart';
import 'package:appointments/widget/custom_liquid_swipe.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  late List<LiquidSwipeData> _data;
  @override
  void initState() {
    super.initState();
    setState(() {
      _data = [
        LiquidSwipeData(
          image: "assets/images/swiper-1.jpg",
          text1: "This is a Title",
          text2: "This is a sub Title",
          text3: "This is a sub subTitle",
        ),
        LiquidSwipeData(
          image: "assets/images/swiper-3.jpg",
          text1: "This is a Title",
          text2: "This is a sub Title",
          text3: "This is a sub subTitle",
        ),
        LiquidSwipeData(
          image: "assets/images/swiper-4.jpg",
          text1: "This is a Title",
          text2: "This is a sub Title",
          text3: "This is a sub subTitle",
        ),
        LiquidSwipeData(
          image: "assets/images/swiper-2.jpg",
          text1: "This is a Title",
          text2: "This is a sub Title",
          text3: "This is a sub subTitle",
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLiquidSwipe(
        liquidSwipeDataList: _data,
      ),
    );
  }
}
