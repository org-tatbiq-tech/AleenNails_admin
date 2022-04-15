import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/data_types.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {},
                text: 'Services',
                isPrimary: true,
                isSecondary: true,
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {},
                text: 'Services',
                isPrimary: true,
                isSecondary: true,
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {},
                text: 'Services',
                isPrimary: true,
                isSecondary: true,
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {},
                text: 'Services',
                isPrimary: true,
                isSecondary: true,
              ),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {},
                text: 'Services',
                isPrimary: true,
                isSecondary: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
