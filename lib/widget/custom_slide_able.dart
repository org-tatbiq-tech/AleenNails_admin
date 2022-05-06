import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomSlidable extends StatelessWidget {
  CustomSlidableProps customSlidableProps;
  CustomSlidable({
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
                      EaseInAnimation(
                        onTap: () => {
                          customSlidableProps.deleteAction!(),
                          Slidable.of(context)?.close() ?? () => {}
                        },
                        child: CustomIcon(
                          customIconProps: CustomIconProps(
                            icon: null,
                            path: 'assets/icons/trash.png',
                            containerSize: rSize(30),
                            backgroundColor: Colors.transparent,
                            iconColor: Theme.of(context).colorScheme.error,
                          ),
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
