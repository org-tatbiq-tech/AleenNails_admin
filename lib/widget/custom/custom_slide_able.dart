import 'package:common_widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomSlidable extends StatelessWidget {
  final CustomSlidableProps customSlidableProps;
  const CustomSlidable({
    Key? key,
    required this.customSlidableProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: customSlidableProps.groupTag,
      closeOnScroll: true,
      key: customSlidableProps.key,
      enabled: true,
      endActionPane: ActionPane(
        extentRatio: 0.2,
        dragDismissible: true,
        motion: const BehindMotion(),
        children: [
          Builder(builder: (context) {
            return Expanded(
              child: SizedBox.expand(
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomIcon(
                        customIconProps: CustomIconProps(
                          isDisabled: false,
                          onTap: () => {
                            customSlidableProps.deleteAction!(),
                            Slidable.of(context)?.close() ?? () => {}
                          },
                          icon: null,
                          path: 'assets/icons/trash.png',
                          containerSize: 30,
                          backgroundColor: Colors.transparent,
                          iconColor: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      child: customSlidableProps.child,
    );
  }
}

class CustomSlidableProps {
  final String groupTag;
  final Widget child;
  final Function? deleteAction;
  ValueKey key;
  CustomSlidableProps({
    this.groupTag = 'groupTag',
    required this.child,
    this.deleteAction,
    this.key = const ValueKey(0),
  });
}
