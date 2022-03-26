import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/app_bar_painter.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final CustomAppBarProps customAppBarProps;
  const CustomAppBar({Key? key, required this.customAppBarProps}) : super(key: key);

  @override
  Size get preferredSize => Device.get().isIphoneX ? Size.fromHeight(rSize(70)) : Size.fromHeight(rSize(55));

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> with SingleTickerProviderStateMixin {
  double rippleStartX = 0;
  double rippleStartY = 0;
  late AnimationController _controller;
  late Animation _animation;
  bool isInSearchMode = false;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener(animationStatusListener);
  }

  animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        isInSearchMode = true;
      });
    }
  }

  void onSearchTapUp(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });
    _controller.forward();
  }

  cancelSearch() {
    setState(() {
      isInSearchMode = false;
    });
    onSearchQueryChange('');
    _controller.reverse();
  }

  onSearchQueryChange(String query) {
    print('search $query');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(children: [
      AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        shadowColor: Colors.transparent,
        titleSpacing: 0,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(rSize(15), 0, rSize(15), 0),
                child: CustomIcon(icon: widget.customAppBarProps.leadingWidget),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment:
                      widget.customAppBarProps.centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    widget.customAppBarProps.titleWidget ??
                        Text(widget.customAppBarProps.titleText,
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              )
            ]),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.customAppBarProps.withSearch
                  ? GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
                        child: CustomIcon(
                          icon: IconTheme(
                            data: Theme.of(context).primaryIconTheme,
                            child: const Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ),
                      onTapUp: onSearchTapUp,
                    )
                  : Container(),
              widget.customAppBarProps.customIcon != null
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
                      child: CustomIcon(icon: widget.customAppBarProps.customIcon),
                    )
                  : Container(),
            ],
          )
        ],
      ),
      AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: AppBarPainter(
              containerHeight: widget.preferredSize.height,
              center: Offset(rippleStartX, rippleStartY),
              radius: _animation.value * screenWidth,
              context: context,
            ),
          );
        },
      ),
      isInSearchMode
          ? (SearchBar(
              onCancelSearch: cancelSearch,
              onSearchQueryChanged: onSearchQueryChange,
            ))
          : (Container())
    ]);
  }
}
