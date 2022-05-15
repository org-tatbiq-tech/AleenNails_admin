import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomInputFieldButton extends StatelessWidget {
  final String text;
  final Widget? textWidget;
  final Function? onTap;
  final double fontSize;
  final bool withDefaultHeight;
  final double height;
  const CustomInputFieldButton({
    Key? key,
    this.text = '',
    this.fontSize = 18,
    this.onTap,
    this.textWidget,
    this.withDefaultHeight = true,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EaseInAnimation(
      beginAnimation: 0.98,
      onTap: onTap ?? () => {},
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            rSize(10),
          ),
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: rSize(15),
          ),
          width: double.infinity,
          height: withDefaultHeight ? rSize(height) : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: textWidget ??
                    Text(
                      text,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontSize: rSize(fontSize),
                          ),
                    ),
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
      ),
    );
  }
}
