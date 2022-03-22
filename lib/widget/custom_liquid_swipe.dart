import 'package:appointments/data_types.dart';
import 'package:appointments/utils/layout_util.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomLiquidSwipe extends StatefulWidget {
  const CustomLiquidSwipe({Key? key}) : super(key: key);

  @override
  _CustomLiquidSwipe createState() => _CustomLiquidSwipe();
}

class _CustomLiquidSwipe extends State<CustomLiquidSwipe> {
  int page = 0;
  late LiquidController liquidController;

  List<LiquidSwipeData> data = [
    LiquidSwipeData(
      image: "assets/images/swiper-1.jpg",
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
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  data[index].image != null
                      ? Image(
                          image: AssetImage(data[index].image),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover)
                      : const SizedBox(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: rSize(40)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.2),
                          Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data[index].text1.isNotEmpty
                            ? Text(
                                data[index].text1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(fontSize: rSize(35)),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: rSize(20),
                        ),
                        data[index].text2.isNotEmpty
                            ? Text(
                                data[index].text2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(fontSize: rSize(25)),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: rSize(10),
                        ),
                        data[index].text3.isNotEmpty
                            ? Text(
                                data[index].text3,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(fontSize: rSize(15)),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              );
            },
            positionSlideIcon: 0.75,
            // slideIconWidget: liquidController.currentPage != data.length - 1
            //     ? Padding(
            //         padding: EdgeInsets.symmetric(horizontal: rSize(30)),
            //         child: Container(
            //           padding: EdgeInsets.symmetric(
            //               vertical: rSize(15), horizontal: rSize(15)),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(rSize(15)),
            //               color: Theme.of(context).colorScheme.primary),
            //           child: IconTheme(
            //               data: Theme.of(context).iconTheme,
            //               child: const Icon(FontAwesomeIcons.arrowLeft)),
            //         ),
            //       )
            //     : SizedBox(),
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: 800,
            enableSideReveal: false,
            // liquidController.currentPage != data.length - 1 ? true : false,
            enableLoop: false,
            ignoreUserGestureWhileAnimating: true,
          ),
          Positioned(
            bottom: 0,
            left: rSize(30),
            right: rSize(30),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  liquidController.currentPage != data.length - 1
                      ? CustomTextButton(
                          customTextButtonProps: CustomTextButtonProps(
                              onTap: () => liquidController.animateToPage(
                                  page: liquidController.currentPage + 1 >
                                          data.length - 1
                                      ? 0
                                      : liquidController.currentPage + 1),
                              text: "Next"))
                      : const SizedBox(),
                  AnimatedSmoothIndicator(
                    duration: const Duration(milliseconds: 400),
                    activeIndex: liquidController.currentPage,
                    count: data.length,
                    effect: WormEffect(
                        type: WormType.thin,
                        spacing: rSize(16),
                        dotWidth: rSize(16),
                        dotHeight: rSize(16),
                        dotColor: Theme.of(context).colorScheme.background,
                        activeDotColor: Theme.of(context).colorScheme.primary),
                    onDotClicked: (index) {
                      liquidController.jumpToPage(page: index);
                    },
                  ),
                  liquidController.currentPage == data.length - 1
                      ? CustomTextButton(
                          customTextButtonProps: CustomTextButtonProps(
                              onTap: () => liquidController.jumpToPage(
                                  page: data.length - 1),
                              text: "Finish"))
                      : CustomTextButton(
                          customTextButtonProps: CustomTextButtonProps(
                              onTap: () => liquidController.jumpToPage(
                                  page: data.length - 1),
                              text: "Skip to End")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
