import 'package:appointments/data_types.dart';
import 'package:appointments/utils/layout_util.dart';
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
                      SizedBox(
                        height: rSize(60),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                          liquidController.currentPage == data.length - 1
                              ? CustomButton(
                                  customButtonProps: CustomButtonProps(
                                      isPrimary: true,
                                      capitalizeText: false,
                                      onTap: () => liquidController.jumpToPage(
                                          page: data.length - 1),
                                      text: "Start"))
                              : CustomTextButton(
                                  customTextButtonProps: CustomTextButtonProps(
                                      onTap: () => liquidController.jumpToPage(
                                          page: data.length - 1),
                                      text: "Skip to End")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        // positionSlideIcon: 0.75,
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
