import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomInputFieldButton extends StatelessWidget {
  final String text;
  final Function? onTap;
  const CustomInputFieldButton({
    Key? key,
    this.text = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EaseInAnimation(
      beginAnimation: 0.98,
      onTap: onTap ?? () => {},
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: rSize(15),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            rSize(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 1),
              blurRadius: 2,
            )
          ],
          border: Border.all(
              width: rSize(1),
              color: Theme.of(context).colorScheme.onBackground),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        width: double.infinity,
        height: rSize(50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.caption,
            ),
            IconTheme(
              data: Theme.of(context).primaryIconTheme,
              child: Icon(
                FontAwesomeIcons.chevronDown,
                size: rSize(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
