import 'dart:isolate';

import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_silver_app_bar.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    _renderActions() {
      return Row(
        children: [
          SizedBox(
            width: rSize(120),
          ),
          EaseInAnimation(
            onTap: () => {},
            child: CustomIcon(
              customIconProps: CustomIconProps(
                icon: Icon(
                  Icons.phone,
                  size: rSize(24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: rSize(10),
          ),
          EaseInAnimation(
            onTap: () => {},
            child: CustomIcon(
              customIconProps: CustomIconProps(
                icon: Icon(
                  Icons.message,
                  size: rSize(24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: rSize(10),
          ),
          EaseInAnimation(
            onTap: () => {},
            child: CustomIcon(
              customIconProps: CustomIconProps(
                icon: Icon(
                  Icons.email,
                  size: rSize(24),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Contact Details',
          withBack: true,
          // withSearch: true,
          barHeight: 120,
          withClipPath: true,
          customIcon: Icon(
            Icons.edit,
            size: rSize(24),
          ),
          customIconTap: () => {},
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAvatar(
                  customAvatarProps: CustomAvatarProps(
                    radius: rSize(100),
                    rectangleShape: false,
                    circleShape: true,
                    editable: false,
                    isMale: true,
                  ),
                ),
                SizedBox(
                  width: rSize(20),
                ),
                Expanded(
                  child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    spacing: rSize(2),
                    runSpacing: rSize(2),
                    children: [
                      Text(
                        'Ahmad Manaa',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        '0505800955',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'ahmadmnaa.b@gmail.com',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _renderActions(),
          ],
        ),
      ),
    );
  }

  Widget makeVideo({image}) {
    return AspectRatio(
      aspectRatio: 1.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.3)
          ])),
          child: Align(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 70,
            ),
          ),
        ),
      ),
    );
  }
}
