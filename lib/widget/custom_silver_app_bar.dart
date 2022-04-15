import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class CustomSilverAppBar extends SliverPersistentHeaderDelegate {
  final CustomSilverAppBarProps customSilverAppBarProps;
  CustomSilverAppBar({
    required this.customSilverAppBarProps,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // Image.network(
          //   "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          //   fit: BoxFit.cover,
          // ),
          Padding(
            padding:
                EdgeInsets.only(top: customSilverAppBarProps.safeAreaHeight),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  customSilverAppBarProps.withBack
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(rSize(15), 0, 0, 0),
                          child: EaseInAnimation(
                            onTap: () => Navigator.pop(context),
                            child: CustomIcon(
                              customIconProps: CustomIconProps(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                icon: IconTheme(
                                  data: Theme.of(context).iconTheme,
                                  child: const Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: customSilverAppBarProps.centerTitle
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        customSilverAppBarProps.titleWidget ??
                            Text(customSilverAppBarProps.titleText,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                      ],
                    ),
                  )
                ]),
          ),
          // Positioned(
          //   top: customSilverAppBarProps.expandedHeight / 2 - shrinkOffset,
          //   left: MediaQuery.of(context).size.width / 4,
          //   child: Opacity(
          //     opacity:
          //         (1 - shrinkOffset / customSilverAppBarProps.expandedHeight),
          //     child: Card(
          //       elevation: 20,
          //       child: SizedBox(
          //         height: customSilverAppBarProps.expandedHeight,
          //         width: MediaQuery.of(context).size.width / 2,
          //         child: FlutterLogo(),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => customSilverAppBarProps.expandedHeight;

  @override
  double get minExtent =>
      kToolbarHeight + customSilverAppBarProps.safeAreaHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
