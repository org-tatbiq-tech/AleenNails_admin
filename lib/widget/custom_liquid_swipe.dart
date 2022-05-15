import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomLiquidSwipe extends StatefulWidget {
  final List<LiquidSwipeData> liquidSwipeDataList;
  const CustomLiquidSwipe({
    Key? key,
    required this.liquidSwipeDataList,
  }) : super(key: key);

  @override
  _CustomLiquidSwipe createState() => _CustomLiquidSwipe();
}

class _CustomLiquidSwipe extends State<CustomLiquidSwipe> {
  int page = 0;
  late LiquidController liquidController;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late List<LiquidSwipeData> data = widget.liquidSwipeDataList;
    return Scaffold(
      body: LiquidSwipe.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              data[index].image.isNotEmpty
                  ? Image(
                      image: AssetImage(data[index].image),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: rSize(40)),
                // width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.5),
                      Theme.of(context).colorScheme.onBackground.withOpacity(1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.mirror,
                  ),
                ),
              ),
              Positioned(
                bottom: rSize(20),
                left: rSize(40),
                right: rSize(40),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data[index].title.isNotEmpty
                          ? Text(data[index].title,
                              style: Theme.of(context).textTheme.headline2)
                          : const SizedBox(),
                      SizedBox(
                        height: rSize(20),
                      ),
                      data[index].subTitle.isNotEmpty
                          ? Text(data[index].subTitle,
                              style: Theme.of(context).textTheme.bodyText2)
                          : const SizedBox(),
                      SizedBox(
                        height: rSize(10),
                      ),
                      data[index].description.isNotEmpty
                          ? Text(data[index].description,
                              style: Theme.of(context).textTheme.subtitle2)
                          : const SizedBox(),
                      SizedBox(
                        height: rSize(60),
                      ),
                      SizedBox(
                        height: rSize(50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AnimatedSmoothIndicator(
                              duration: const Duration(milliseconds: 400),
                              activeIndex: liquidController.currentPage,
                              count: data.length,
                              effect: WormEffect(
                                  type: WormType.thin,
                                  spacing: rSize(16),
                                  dotWidth: rSize(16),
                                  dotHeight: rSize(16),
                                  dotColor:
                                      Theme.of(context).colorScheme.background,
                                  activeDotColor:
                                      Theme.of(context).colorScheme.primary),
                              onDotClicked: (index) {
                                liquidController.jumpToPage(page: index);
                              },
                            ),
                            AnimatedSwitcher(
                              reverseDuration:
                                  const Duration(milliseconds: 400),
                              duration: const Duration(milliseconds: 400),
                              child: liquidController.currentPage ==
                                      data.length - 1
                                  ? CustomButton(
                                      key: const ValueKey(0),
                                      customButtonProps: CustomButtonProps(
                                        isPrimary: true,
                                        onTap: () => {
                                          Navigator.pushNamed(
                                              context, '/loginScreen')
                                        },
                                        text: "Start",
                                      ),
                                    )
                                  : CustomButton(
                                      key: const ValueKey(1),
                                      customButtonProps: CustomButtonProps(
                                        isPrimary: false,
                                        onTap: () => liquidController
                                            .jumpToPage(page: data.length - 1),
                                        isSecondary: true,
                                        backgroundColor: Colors.transparent,
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        text: "Skip to End",
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        onPageChangeCallback: pageChangeCallback,
        waveType: WaveType.liquidReveal,
        liquidController: liquidController,
        fullTransitionValue: 800,
        enableSideReveal: false,
        enableLoop: false,
        ignoreUserGestureWhileAnimating: true,
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
