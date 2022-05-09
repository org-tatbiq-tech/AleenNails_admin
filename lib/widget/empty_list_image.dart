import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:flutter/material.dart';

class EmptyListImage extends StatelessWidget {
  final EmptyListImageProps emptyListImageProps;
  const EmptyListImage({
    Key? key,
    required this.emptyListImageProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _renderEmptyCard() {
      return Container(
        width: rSize(250),
        padding: EdgeInsets.only(
          left: rSize(10),
          right: rSize(50),
          top: rSize(10),
          bottom: rSize(5),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(
            rSize(10),
          ),
          border: Border.all(
            width: rSize(1),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIcon(
              customIconProps: CustomIconProps(
                icon: null,
                path: emptyListImageProps.iconPath,
                backgroundColor: Colors.transparent,
                iconColor: Theme.of(context).colorScheme.primaryContainer,
                containerSize: 30,
                withPadding: true,
                contentPadding: 2,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    thickness: rSize(3),
                    endIndent: rSize(0),
                    indent: rSize(10),
                    height: rSize(8),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    thickness: rSize(3),
                    endIndent: rSize(25),
                    indent: rSize(10),
                    height: rSize(8),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: rSize(-55),
                child: Opacity(
                  opacity: 0.7,
                  child: Transform.scale(
                    scale: 0.8,
                    child: _renderEmptyCard(),
                  ),
                ),
              ),
              Positioned(
                bottom: rSize(-30),
                child: Opacity(
                  opacity: 0.8,
                  child: Transform.scale(
                    scale: 0.9,
                    child: _renderEmptyCard(),
                  ),
                ),
              ),
              _renderEmptyCard(),
            ],
          ),
          SizedBox(
            height: rSize(90),
          ),
          Text(
            emptyListImageProps.title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: rSize(emptyListImageProps.bottomWidgetPosition),
          ),
          emptyListImageProps.bottomWidget ?? const SizedBox(),
        ],
      ),
    );
  }
}
